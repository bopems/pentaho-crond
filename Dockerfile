# Pull Base Image
FROM zhicwu/java:8

# Set Maintainer Details
MAINTAINER Bope Microservices - bopems/pentaho-crond

# Set Environment Variables
ENV PDI_VERSION=7.1 PDI_BUILD=7.1.0.0-12 PDI_PATCH=7.1.0.0 PDI_USER=pentaho KETTLE_HOME=/data-integration

# Install Required Packages, Configure Crons and Add User
RUN apt-get update \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd -md $KETTLE_HOME -s /bin/bash $PDI_USER

# Download Pentaho Data Integration Community Edition and Unpack
RUN wget --progress=dot:giga http://downloads.sourceforge.net/project/pentaho/Data%20Integration/${PDI_VERSION}/pdi-ce-${PDI_BUILD}.zip \
	&& unzip -q *.zip \
	&& rm -f *.zip

# Switch Directory
WORKDIR $KETTLE_HOME

RUN mkdir $KETTLE_HOME/jobs \
    && mkdir $KETTLE_HOME/drivers

# Add Entry Point and Templates
COPY dockerentrypoint.sh $KETTLE_HOME/docker-entrypoint.sh

#move to apt-gets to maintain a pattern
RUN apt-get update && apt-get install -y dos2unix && apt-get install -y libwebkitgtk-1.0-0

RUN chmod +x docker-entrypoint.sh

RUN dos2unix $KETTLE_HOME/docker-entrypoint.sh

ENTRYPOINT ["/data-integration/docker-entrypoint.sh"]
