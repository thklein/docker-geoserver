# docker-geoserver

[GeoServer](http://geoserver.org) is an open source server for sharing geospatial data.
This is a docker image that eases setting up GeoServer running with a separated data directory (without demo shapes) as recommended for use in production environment.

The image is based on Ubuntu + Tomcat 8 

## Installation

This image is available as a [trusted build on the docker image](https://registry.hub.docker.com/u/thklein/geoserver/), and is the recommended method of installation.
Simple pull the image from the docker registry hub.

```bash
$ docker pull thklein/geoserver
```

Alternatively you can build the image locally

```bash
$ git clone https://github.com/thklein/docker-geoserver.git
$ cd docker-geoserver
$ docker build -t "$USER/geoserver" .
```

## Usage

You can start the image using the command line 

```bash
$ docker run --name "geoserver" -d -p 8080:8080 thklein/geoserver
```

GeoServer stores its data in the separated data directory in `/geoserver_data`.
Docker containers run in an isolated environment, so in order to persist data and get access to the data files you'll need to use a docker volume.

```bash
$ mkdir -p $HOME/geoserver_data
$ docker run --name "geoserver" -d -v $HOME/geoserver_data:/geoserver_data -p 8080:8080 thklein/geoserver
```
Ensure that your directory is accessibale by docker. The volume makes it easier to upgrade or to take a backup.

Finally, point your browser to `http://localhost:8080/geoserver` and login using the GeoServer's default username and password:

* username: admin
* password: geoserver
