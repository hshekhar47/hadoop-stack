FROM hshekhar47/hadoop-core:0.1

LABEL "author"="Himanshu Shekhar <himanshu.shekhar.in@bt.com>"

ADD scripts/ /usr/bin/

RUN sudo apt-get update && \
    sudo chmod +x /usr/bin/bootstrap.sh

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/usr/bin/bootstrap.sh && /bin/bash"]