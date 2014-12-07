# docker-geoserver

[GeoServer](http://geoserver.org) is an open source server for sharing geospatial data.
This is a docker image that eases setting up GeoServer running with a separated data directory (without demo shapes) as recommended for use in production environment.

The image is based on Ubuntu + Tomcat 8 

## Building the image

To build the docker image:

```bash
$ docker build -t "geoserver" git://github.com/thklein/docker-geoserver
``` 

## Usage

To start this simple GeoServer container you can type 

```bash
$ docker run --name "geoserver" -d -p 8080:8080 thklein/geoserver
```

GeoServer stores its data in the separated data directory in `/geoserver_data`.
Docker containers run in an isolated environment, so in order to persist data and get access to the data files you'll need to use a docker volume.

First, ensure that your directory is accessibale by docker, then:

```bash
$ docker run --name "geoserver" -d $HOME/geoserver_data:/geoserver_data -p 8080:8080 thklein/geoserver
```

This makes it easier to upgrade or to take a backup.

