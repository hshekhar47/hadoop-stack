FROM debian:latest

LABEL "author"="Himanshu Shekhar <himanshu.shekhar.in@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

ARG UNAME=padmin
ARG GNAME=hadoop 

ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_172 \
	PATH=${PATH}:/usr/lib/jvm/jdk1.8.0_172/bin

COPY server-jre-8u172-linux-x64.tar.gz /tmp/

RUN apt-get update && \
    apt-get install -y sudo curl ssh && \
    groupadd -g 1000 ${GNAME} && \
    useradd -d "/home/${UNAME}" -u 1001 -g 1000 -m -s /bin/bash ${UNAME} && \
    echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/' /etc/ssh/ssh_config && \
    mkdir -p /usr/lib/jvm && \
	tar -xvf /tmp/server-jre-8u172-linux-x64.tar.gz -C /usr/lib/jvm && \
    rm -rf /tmp/server-jre-8u172-linux-x64.tar.gz && \
    chown -R ${UNAME}:${GNAME} /opt/ && \
    echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/environment

USER padmin

RUN ssh-keygen -q -t rsa -N "" -C "" -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

ENTRYPOINT ["/bin/bash", "-c", "bash"]
CMD ["/bin/bash"]
