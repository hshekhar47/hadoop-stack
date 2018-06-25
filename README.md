# Hadoop Stack

## Prerequisite
Require: `docker` and `docker-compose`.

Create directory `./resources` and download following resource into this directory
 - [server-jre-8u172-linux-x64.tar.gz](http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/server-jre-8u172-linux-x64.tar.gz)
 - [hadoop-2.7.6.tar.gz](http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz)
 - [spark-2.3.0-bin-hadoop2.7.tgz](http://www-us.apache.org/dist/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz)
 - [ojdbc6.jar](http://download.oracle.com/otn/utilities_drivers/jdbc/11204/ojdbc6.jar)
 - [mysql-connector-java-5.1.45-bin.jar](https://cdn.mysql.com/archives/mysql-connector-java-5.1/mysql-connector-java-5.1.45.tar.gz)
 - [apache-hive-2.3.3-bin.tar.gz](http://www-us.apache.org/dist/hive/hive-2.3.3/apache-hive-2.3.3-bin.tar.gz)

Once done build each image 

#### [hshekhar47/debian-jre8](./debian-jre8/REDME.md) 
`debian` `oracle-server-jre8` `passwordless ssh`
##### Build 
```bash
./build.sh build debian-jre8
```

#### [hshekhar47/hadoop-core](./hadoop-core/README.md) 
`hshekhar47/debian-jre8` `hadoop-2.7.6` `spark-2.3.0` `sqoop-1.4.7`
##### Build 
```bash
./build.sh build hadoop-core
```

#### [hshekhar47/hdfs-namenode](./hdfs-namenode/README.md) 
`hshekhar47/hadoop-core`
##### Build 
```bash
./build.sh build hdfs-namenode
```

#### [hshekhar47/hdfs-datanode](./hdfs-datanode/README.md)
`hshekhar47/hadoop-core`
##### Build 
```bash
./build.sh build hdfs-datanode
```

## Start 
1. Run below command lauch hadoop-stack locally
```bash
docker compose -f hadoop-stack.yml up
```


# References
[Setup a hadoop cluster](https://linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/)

[Setup sqoop on hadoop cluster](http://sawmyas-hadoop.blogspot.com/2015/12/sqoop-146-on-hadoop-270-cluster.html)