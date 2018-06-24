FROM hshekhar47/debian-jre8:0.1

LABEL "author"="Himanshu Shekhar <himanshu.shekhar.in@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
ARG HADOOP_VERSION=2.7.6
ARG SPARK_VERSION=2.3.0
ARG UNAME=padmin
ARG UNAME=padmin

ENV INSTALL_DIR=/opt/ \
    HADOOP_HOME=/opt/hadoop-2.7.6 \
    HADOOP_APPDATA=/opt/data/apps \
    SPARK_HOME=/opt/spark-2.3.0

#COPY http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz /tmp/
COPY hadoop-${HADOOP_VERSION}.tar.gz /tmp/
COPY spark-${SPARK_VERSION}-bin-hadoop2.7.tgz /tmp/

ADD conf /tmp/conf

RUN sudo apt-get update && \
    sudo mkdir -p ${INSTALL_DIR} && \
    sudo tar -xvf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C ${INSTALL_DIR} && \
    sudo rm -rf /tmp/hadoop-${HADOOP_VERSION}-* && \
    sudo cp /tmp/conf/hadoop/* ${HADOOP_HOME}/etc/hadoop/ && \
    sudo tar -xvf /tmp/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz -C ${INSTALL_DIR} && \
    sudo mv ${INSTALL_DIR}/spark-${SPARK_VERSION}-bin-hadoop2.7 ${INSTALL_DIR}/spark-${SPARK_VERSION} && \
    sudo rm -rf /tmp/spark-${SPARK_VERSION}-* && \
    sudo cp /tmp/conf/spark/* ${SPARK_HOME}/conf/ && \
    sudo chown -R ${UNAME}:${GNAME} ${INSTALL_DIR} && \
    echo "export HADOOP_HOME=${HADOOP_HOME}" >> ~/.bashrc && \
    echo "export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop" >> ~/.bashrc && \
    echo "export LD_LIBRARY_PATH=${HADOOP_HOME}/lib/native:${LD_LIBRARY_PATH}" >> ~/.bashrc && \
    echo "export SPARK_HOME=${SPARK_HOME}" >> ~/.bashrc && \
    echo "export PATH=${PATH}:${HADOOP_HOME}/bin:${SPARK_HOME}/bin" >> ~/.bashrc

# Spark ports
EXPOSE 7077 6066 8080 8081
# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]