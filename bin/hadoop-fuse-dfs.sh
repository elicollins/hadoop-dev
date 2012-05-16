#!/bin/bash

# cp fuse_dfs to $HADOOP_HOME/bin
# ./hadoop-fuse-dfs.sh dfs://localhost:8020 /mnt/fuse-dfs -d

HADOOP_HOME=/home/eli/hadoop-3.0.0-SNAPSHOT

HADOOP_LIBS=$HADOOP_HOME/lib/native
JVM_LIB=$JAVA_HOME/jre/lib/amd64/server

for jar in ${HADOOP_HOME}/share/hadoop/common/*.jar; do
  CLASSPATH+="$jar:"
done
for jar in ${HADOOP_HOME}/share/hadoop/common/lib/*.jar; do
  CLASSPATH+="$jar:"
done
for jar in ${HADOOP_HOME}/share/hadoop/hdfs/*.jar; do
  CLASSPATH+="$jar:"
done
for jar in ${HADOOP_HOME}/share/hadoop/hdfs/lib/*.jar; do
  CLASSPATH+="$jar:"
done

export LD_LIBRARY_PATH=$HADOOP_LIBS:$JVM_LIB:${LD_LIBRARY_PATH}

env CLASSPATH="$CLASSPATH" $HADOOP_HOME/bin/fuse_dfs $@
