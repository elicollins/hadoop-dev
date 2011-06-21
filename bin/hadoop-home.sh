#!/usr/bin/env bash
HADOOP_SRC_ROOT=/home/eli/src/hadoop$1
export HADOOP_COMMON_HOME=$HADOOP_SRC_ROOT/common
export HADOOP_HDFS_HOME=$HADOOP_SRC_ROOT/hdfs
export HADOOP_MAPRED_HOME=$HADOOP_SRC_ROOT/mapreduce
export HADOOP_OPTS="$HADOOP_OPTS -Djava.security.egd=file:///dev/urandom"
