#!/usr/bin/env bash
HADOOP_SRC_ROOT=/home/eli/src
export HADOOP_COMMON_HOME=$HADOOP_SRC_ROOT/common$1
export HADOOP_HDFS_HOME=$HADOOP_SRC_ROOT/hdfs$1
export HADOOP_MAPRED_HOME=$HADOOP_SRC_ROOT/mapreduce$1
