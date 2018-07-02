FROM hshekhar47/hadoop-core:0.1

LABEL "author"="Himanshu Shekhar <himanshu.shekhar.in@gmail.com>"

ARG HIVE_VERSION=2.3.3

ENV INSTALL_DIR=/opt \
    HIVE_HOME=/opt/hive-2.3.3

COPY apache-hive-${HIVE_VERSION}-bin.tar.gz /tmp
ADD conf /tmp/conf
ADD scripts/ /usr/bin/ 

RUN sudo apt-get update && \
    tar -xvf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C ${INSTALL_DIR} && \
    mv ${INSTALL_DIR}/apache-hive-${HIVE_VERSION}-bin ${INSTALL_DIR}/hive-${HIVE_VERSION} && \
    rm -rf ${INSTALL_DIR}/hive-${HIVE_VERSION}/lib/log4j-slf4j-impl-*.jar && \
    cp /tmp/conf/hive/* ${HIVE_HOME}/conf && \
    ln -s ${INSTALL_DIR}/common-libs/mysql-connector-java-5.1.45-bin.jar ${HIVE_HOME}/lib/mysql-connector-java-5.1.45-bin.jar && \
    echo "export HIVE_HOME=${HIVE_HOME}" >> ~/.bashrc && \
    export PATH=${PATH}:${HIVE_HOME}/bin && \
    sudo chmod +x /usr/bin/bootstrap.sh && \
    sudo rm -rf /tmp/conf

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/usr/bin/bootstrap.sh && /bin/bash"]
