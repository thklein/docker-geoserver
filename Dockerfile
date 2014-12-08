FROM consol/tomcat-8.0
MAINTAINER Thomas Klein <github.com/thklein>

ENV GEOSERVER_VERSION 2.5.3
ENV GEOSERVER_DATA_DIR /geoserver_data

RUN wget -q http://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-war.zip -O /tmp/geoserver.zip

RUN apt-get update && apt-get -y install unzip

RUN unzip -q /tmp/geoserver.zip -d /tmp

RUN mv /tmp/geoserver.war /opt/tomcat/webapps/geoserver.war

RUN mkdir $GEOSERVER_DATA_DIR

VOLUME $GEOSERVER_DATA_DIR

CMD /opt/tomcat/bin/deploy-and-run.sh
