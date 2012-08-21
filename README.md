hadoop-dev
==========

Scripts and aliases for Hadoop development.

INSTALL
-------

   Add something like the following to your bashrc

   export HDEV=/home/eli/src/play/hadoop-dev
   . $HDEV/bin/hadoop-alias.sh
   export PATH=$HDEV/bin:$HDEV/test:$PATH

   Edit HADOOP_SRC_ROOT in $HDEV/bin/hadoop-home.sh to point to
   the root directory where you keep your source trees.


RUNNING DAEMONS
---------------

    The scripts allow you to use multiple source trees (eg src/hdfs1,
    src/hdf2, etc). To run the namenode daemon out of src/hdfs1 you
    use "nn1", to run src/hdfs2 use "nn2", and so on. To use more
    trees you can add more aliases to hadoop-alias.sh.

    Copy the conf/* files into the conf directory in your common
    tree and update per the paths on your system.

    nn1    Run the namenode daemon out of the first tree
    dn1    " datanode
    jt1    " jobtracker
    tt1    " tasktracker


RUNNING COMMANDS
----------------

    format-namenode 1

    hadoop1 fs -put temp temp0

    hadoop1 dfsadmin -safemode leave

    . $HDEV/bin/hadoop-home.sh 1
    J=$HADOOP_MAPRED_HOME/build/hadoop-mapred-examples-0.23.0-SNAPSHOT.jar
    hadoop1 jar $J pi 2 100000


TESTING
-------

    To run a specific test class (TestFoo)

      ant-test-core TestFoo
      ant-test-core20 TestFoo
      ant-test-contrib20 TestFoo
      ant-test-hdfs TestFoo
      ant-test-mr TestFoo

    To loop a specific test until it fails

      loop-core-test TestFoo
      loop-core20-test TestFoo
      loop-hdfs-test TestFoo
      loop-mr-test TestFoo


DEVELOPMENT
-----------

    Run "test-patch" on a patch

      ant-test-patch ~/hadoop-x.patch >& ~/test.out

    Release audit

      ant-releaseaudit


SUBVERSION
----------

    Revert revision r, eg

      svn_revert 1035718

    Merge revision r to a release branch

      svn_merge_common r HADOOP-XYZ
      svn_merge_hdfs r HDFS-XYX
      svn_merge_mapreduce r MAPREDUCE-XYZ
