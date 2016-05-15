FROM consol/tomcat-8.0
MAINTAINER Thomas Klein <github.com/thklein>

#
# Set GeoServer version and data directory 
#
ENV GEOSERVER_VERSION=2.6.0 \
    GEOSERVER_DATA_DIR="/geoserver_data"


RUN apt-get update && apt-get -y install unzip

#
# Download and install GeoServer
#
RUN cd /opt/tomcat/webapps \
    && wget --progress=bar:force:noscroll http://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-war.zip \
    && unzip -q geoserver-$GEOSERVER_VERSION-war.zip \
    && rm geoserver-$GEOSERVER_VERSION-war.zip \
    && mkdir $GEOSERVER_DATA_DIR

VOLUME $GEOSERVER_DATA_DIR

CMD /opt/tomcat/bin/deploy-and-run.sh
