#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log_as_colored_text() {
    case "$1" in
        "RED")
            printf "${RED}$2 ${NC}";;
        "GREEN")
            printf "${GREEN}$2 ${NC}";;
        *)
            printf "${CYAN}$2 ${NC}";;
    esac
}

log() {
    timestamp=`date '+%Y-%m-%d %H:%M:%S'`
    case "$1" in
        "SUCCESS")
            log_as_colored_text "GREEN" "${timestamp} [INFO ] $2";;
        "ERROR")
            log_as_colored_text "RED" "${timestamp} [ERROR ] $2";;
        "INFO")
            log_as_colored_text "CYAN" "${timestamp} [INFO ] $2";;
        *)
            log_as_colored_text "CYAN" "${timestamp} [INFO ] $2";;
    esac
    echo ""
}

check_node_alive() {
    attempts=0
    while [ $attempts -lt 5 ]; do
        ping -c 1 "$1" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            return 0
        else
            ((attempts++))
            #log "ERROR" "No hostname $1 found. Searched ${attempts} time(s)."
            sleep 5
        fi
    done
    return 3;
}

echo $PATH | grep -q "${HADOOP_HOME}"
if [ $? -ne 0 ]; then
    PATH=${PATH}:${HADOOP_HOME}/bin
    export PATH
fi

echo $PATH | grep -q "${SPARK_HOME}"
if [ $? -ne 0 ]; then
    PATH=${PATH}:${SPARK_HOME}/bin
    export PATH
fi

log "INFO" "Starting the SSH daemon..."
sudo service ssh restart || { log "ERROR" "Could not start ssh service."; exit 1;}
log "SUCCESS" "Started SSH daemon successfully."

export HOSTNAME=`hostname`
sed -i "s#localhost#$HOSTNAME#g" ${HADOOP_HOME}/etc/hadoop/core-site.xml
sed -i "s#localhost#$HOSTNAME#g" ${HADOOP_HOME}/etc/hadoop/yarn-site.xml
sed -i "s#localhost#$HOSTNAME#g" ${SPARK_HOME}/conf/spark-defaults.conf

log "INFO" "Formatting NameNode data directory..."
hdfs namenode -format -force || { log "ERROR" "Could not format namenode data directory."; exit 1;}
log "SUCCESS" "Formatted NameNode data directory successfully."

[ -z "${HS_DATANODES}" ] && { log "ERROR" "Environment variable HS_DATANODES is missing."; exit 1;}
echo "" > ${HADOOP_HOME}/etc/hadoop/slaves

log "INFO" "Finding datanodes in network"
for nodename in ${HS_DATANODES} 
do
    log_as_colored_text "CYAN" "\t${nodename}: Searching "; echo -n "";
    if check_node_alive ${nodename}; then
        log_as_colored_text "GREEN" "FOUND"
        echo "${nodename}" >> ${HADOOP_HOME}/etc/hadoop/slaves
    else
        log_as_colored_text "RED" "NOT FOUND"
    fi  
    echo ""
done 
echo ""

log "INFO" "Starting HDFS"
${HADOOP_HOME}/sbin/start-dfs.sh || { log "ERROR" "Could not start HDFS."; exit 1;}
log "SUCCESS" "HDFS Started successfully."

log "INFO" "Creating filesystems"
hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod -R 777 /tmp
if [ $? -eq 0 ];then log "SUCCESS" "Created /tmp"; fi;
hdfs dfs -mkdir /spark-logs
if [ $? -eq 0 ];then log "SUCCESS" "Created /spark-logs"; fi;
hdfs dfs -mkdir -p /user/padmin 
if [ $? -eq 0 ]; then log "SUCCESS" "Created /user/padmin"; fi; 

log "INFO" "Spark jars distributions"

log "INFO" "Starting YARN"
${HADOOP_HOME}/sbin/start-yarn.sh || { log "ERROR" "Could not start YARN."; exit 1;}
log "SUCCESS" "YARN Started successfully."

log "INFO" "Staring spark history-server"
${SPARK_HOME}/sbin/start-history-server.sh

log "SUCCESS" "All services on NameNode ${HOSTNAME} started successfully."
hdfs dfsadmin -report

exit $?;
