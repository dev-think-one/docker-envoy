@setup
    $dotenv = \Dotenv\Dotenv::createImmutable(__DIR__);
    $dotenv->load();
@endsetup

@servers(['localhost' => 'localhost', 'server' => env('DEPLOY_HOST')])

@story('deploy')
    deploy_code
    check_code
@endstory

@task('deploy_code', ['on' => 'localhost'])
    whoami
    pwd
    rsync -azvhP ./dist/index.html {{env('DEPLOY_HOST')}}:{{rtrim(env('DEPLOY_PATH'), '/')}}/index.html
@endtask

@task('check_code', ['on' => 'server'])
    whoami
    pwd
    ls -alh {{rtrim(env('DEPLOY_PATH'), '/')}}/index.html
@endtask