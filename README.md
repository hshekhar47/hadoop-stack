# Hadoop Stack

## Prerequisite
Require: `docker` and `docker-compose`.

Create directory `./resources` and download following resource into this directory
 - server-jre-8u172-linux-x64.tar.gz
 - hadoop-2.7.6.tar.gz
 - spark-2.3.0-bin-hadoop2.7.tgz

Once done build each image 

#### [hshekhar47/debian-jre8](./debian-jre8/REDME.md) 
`debian` `oracle-server-jre8` `passwordless ssh`
##### Build 
```bash
./build.sh build debian-jre8
```

#### [hshekhar47/hadoop-core](./hadoop-core/REDME.md) 
`hshekhar47/debian-jre8` `hadoop-2.7.6` `spark-2.3.0`
##### Build 
```bash
./build.sh build hadoop-core
```

#### [hshekhar47/hdfs-namenode](./hdfs-namenode/REDME.md) 
`hshekhar47/hadoop-core`
##### Build 
```bash
./build.sh build hdfs-namenode
```

#### [hshekhar47/hdfs-datanode](./hdfs-datanode/REDME.md)
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
[Setup a hadoop Cluster](https://linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/_)
