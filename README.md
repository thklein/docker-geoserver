

# docker-geoserver

[GeoServer](http://geoserver.org) is an open source server for sharing geospatial data.
This is a docker image that eases setting up GeoServer running with a separated data directory (without demo shapes) as recommended for use in production environment.

The image is based on Ubuntu + Tomcat 8

## Installation

This image is available as a [trusted build on the docker hub](https://registry.hub.docker.com/u/thklein/geoserver/), and is the recommended method of installation.
Simple pull the image from the docker hub.

```bash
$ docker pull thklein/geoserver
```

Alternatively you can build the image locally

```bash
$ git clone https://github.com/thklein/docker-geoserver.git
$ cd docker-geoserver
$ docker build -t "thklein/geoserver" .
```

## Usage

You can quick start the image using the command line

```bash
$ docker run --name "geoserver" -d -p 8080:8080 thklein/geoserver
```

GeoServer stores its data in the separated data directory in `/geoserver_data`. Docker containers run in an isolated environment, so in order to persist data and get access to the data files you'll need to use a docker volume.

```bash
$ mkdir -p ~/geoserver_data
$ docker run --name "geoserver" -d -v 
$HOME/geoserver_data:/geoserver_data -p 8080:8080 thklein/geoserver
```
Ensure that your directory is accessibale by docker. The volume makes it easier to upgrade or to take a backup.

Finally, point your browser to `http://localhost:8080/geoserver` and login using the GeoServer's default username and password:

* username: admin
* password: geoserver

## Database

For production environment GeoServer recommends the usage of a spatial database such as [PostGIS](www.postgis.org). There are a lot of ready to run PostGIS container on the docker hub so that it is not necessary to build an own docker container. We will use the image from [kartooza/postgis](https://registry.hub.docker.com/u/kartoza/postgis/).

To run this container type
```bash
$ mkdir -p ~/postgres_data
$ docker run --name "postgis" -v $HOME/postgres_data:/var/lib/postgresql 
-p 25432:5432 -d -t kartoza/postgis
```

The default username and password for the database is both `docker`.
For further information see [kartooza/postgis](https://registry.hub.docker.com/u/kartoza/postgis/).

### Fig

To run GeoServer and a PostGIS database in one step you can use [fig](www.fig.sh). Fig allows us to define and control a multi-container service with a simple yaml file. The `fig.yml` file in this repo contains the definition to run GeoServer and a PostGIS database. All you have to do is to clone the `thklein/docker-geoserver` repo and run fig.

```bash
$ git clone https://github.com/thklein/docker-geoserver.git
$ cd docker-geoserver
$ fig up
```

Fig will do the magic and starts the database and GeoServer container. The volumes of these containers will be generated in the `docker_volumes` directory within the docker-geoserver directory. 
