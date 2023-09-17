FROM php:8.1

# Configure ssh

## Install ssh client
RUN apt-get update && apt-get install -y openssh-client

## Install rsync to do copy by ssh
RUN apt-get update && apt-get install -y rsync

## Create new user
RUN useradd -m user

## Create ssh directory and add key from docker "secter" (https://docs.docker.com/engine/swarm/secrets/)
RUN mkdir -p /home/user/.ssh && ln -s /run/secrets/user_ssh_key /home/user/.ssh/id_rsa
RUN chown -R user:user /home/user/.ssh

# Configure php

## Install zip, what required by envoy
RUN apt-get update \
     && apt-get install -y libzip-dev \
     && docker-php-ext-install zip

## Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clear out the local repository of retrieved package files
RUN apt-get clean

# Set created user as executor
USER user

# Install php packages
RUN composer global require laravel/envoy
RUN composer global require vlucas/phpdotenv

# Add alias for envoy run
RUN mkdir -p ~/bin
RUN echo '#! /bin/bash' >> ~/bin/run
RUN echo 'envoy run "$@"' >> ~/bin/run
RUN chmod u+x ~/bin/run

# Add global composer packages as executable
ENV PATH "$PATH:/home/user/.composer/vendor/bin:/home/user/bin"

# Set working directory (same as php image)
WORKDIR /var/www/html

CMD ["/bin/bash"]
