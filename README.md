# docker-pdi-ce
Docker image for Pentaho Data Integration (PDI, aka Kettle) server community edition.

## What's inside

* Oracle JDK 8 latest release
* [Pentaho Data Integration Community Edition](http://community.pentaho.com/) 7.1.0.0-12 with the followings:
* Up-to-date JDBC drivers: [PostgreSQL JDBC Driver](https://jdbc.postgresql.org/) 42.1.1, [MySQL Connector/J](http://dev.mysql.com/downloads/connector/j/) 5.1.42, [jTDS](https://sourceforge.net/projects/jtds/) 1.3.1, [H2DB](http://www.h2database.com) 1.4.196, [HSQLDB](http://hsqldb.org/) 2.4.0 and [Cassandra JDBC Driver](https://github.com/zhicwu/cassandra-jdbc-driver) 0.6.3
* Oracle ojdbc7 

## How to use
**Note: The instructions below assumes you have [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/) installed.**
- Download pdi locally https://sourceforge.net/projects/pentaho/files/Data%20Integration/ (Version 7.1)
- Unzip it and open spoon.sh/bat
- Follow the video to create new jobs (https://www.youtube.com/watch?v=FXKLqXyuakM)
- After creating a job and a transformation file, move them to jobs folder.
- Create a ssh file to be executed as a cron job. Example:
```
# #!/bin/bash
# /data-integration/kitchen.sh -file=/data-integration/jobs/transacao_deposito_varejista.kjb
```
- Edit the cronjob file to create a cron rule to your job
```
# * * * * * /data-integration/jobs/run-transacao-varejista.sh
```
- Start PDI server
```
# docker-compose up -d
```
Your jobs should be running properly after executing the commands.

##TODO
Create a listener to export the jobs in case of failures. Currently there is
a method to send alerts through Pentaho in case of failure, but it depends on 
someone configuring it.
