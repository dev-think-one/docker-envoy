# Docker image for [`laravel-envoy`](https://laravel.com/docs/envoy) 

## Usage (docker-compose)

Firstly you need provide ssh key and config  and then run:
```bash
docker-compose run --rm --build envoy run deploy
```

Please check [example](/example/README.md)

## Deploy image to dockerhub

```bash
./docker-push.sh
```

## Credits

- [![Think Studio](https://yaroslawww.github.io/images/sponsors/packages/logo-think-studio.png)](https://think.studio/)
