# OpenEyes Installer

This repo contains a Dockerfile, scripts and config files in order to create a single docker container to run OpenEyes.

## Build

```docker build -t davet1985/openeyes:<version> .```

## Run

```docker run -it -p 80:80 davet1985/openeyes:<version>```

## Push

```docker push davet1985/openeyes:<version>```

_Note: the version should be something like __1.11.1___
