function mvn-test { mvn -Dtest=$1 test; }
function mvn-compile-test { mvn -DskipTests clean test; }
function mvn-inst { mvn test -DskipTests install -P-cbuild; }

function mvn-tar { 
  mvn package -Pdist -Dtar -DskipTests -Dmaven.javadoc.skip=true;
}

function mvn-tar-native {
  mvn package -Pdist -Pnative -Dtar -DskipTests -DskipTest -Dmaven.javadoc.skip=true;
}

function ant-test-core20 { ant -Dtestcase=$1 test-core; }
function ant-test-contrib20 { 
  ant -Dtestcase=$1 -Dlibhdfs=1 -Dfusedfs=1 test-contrib;
}
function ant-test-mr { ant -Dtestcase=$1 run-test-mapred; }
function ant-test-hdfs { ant -Dtestcase=$1 run-test-hdfs; }
function ant-test-core { ant -Dtestcase=$1 run-test-core; }

# NB: src/test/bin/test-patch.sh is an external svn dep on HDFS and
# MR so needs to be run from a svn tree rather than git
function ant-test-patch() {
 ant -Dpatch.file=$1 \
   -Dforrest.home=$FORREST_HOME \
   -Dfindbugs.home=$FINDBUGS_HOME \
   -Djava5.home=$JAVA5_HOME \
   test-patch
}

function ant-releaseaudit () {
  ant releaseaudit -Djava5.home=$JAVA5_HOME -Dforrest.home=$FORREST_HOME
}

function ant-docs () {
  ant docs -Djava5.home=$JAVA5_HOME -Dforrest.home=$FORREST_HOME
}

function ant-tar () {
  ant tar -Djava5.home=$JAVA5_HOME -Dforrest.home=$FORREST_HOME
}

function ant-findbugs () {
  ant findbugs -Djava5.home=$JAVA5_HOME \
               -Dforrest.home=$FORREST_HOME \
               -Dfindbugs.home=$FINDBUGS_HOME
}

alias ant-build-install="ant -Dresolvers=internal mvn-install"
alias ant-build-resolve="ant -Dresolvers=internal clean-cache mvn-install"
alias ant-compile-libhdfs="ant -Dcompile.c++=true -Dlibhdfs=true compile"
alias ant-compile-fusedfs="ant -Dlibhdfs=1 -Dfusedfs=1 compile-contrib"
alias ant-test-fusedfs="ant -Dlibhdfs=1 -Dfusedfs=1 test-contrib"
# If the above tests fails you'll need to unmount the build mount:
#   fusermount -u build/contrib/fuse-dfs/test/mnt

# Usage: svn_merge_apache hdfs 1036213 HDFS-259
# NB: we assume the change does not cross projects and
# only modifies files within its "project" directory.
function svn_merge_apache ()
{
  BRANCH=$1
  REV=$2
  TRUNK=https://svn.apache.org/repos/asf/hadoop/common/trunk
  DIR=$TRUNK/hadoop-$BRANCH-project 
  svn merge -c $REV $DIR hadoop-$BRANCH-project
}

function svn_merge_common { svn_merge_apache common $1 } 
function svn_merge_hdfs { svn_merge_apache hdfs $1 } 
function svn_merge_mapreduce { svn_merge_apache mapreduce $1 } 

function svn_merge_branch1 ()
{
  BRANCH=https://svn.apache.org/repos/asf/hadoop/common/branches/branch-1
  REV=$1
  svn merge -c $REV $BRANCH .
}

# svn_revert 1035718
function svn_revert ()
{
  REV=$1
  svn merge --revision $REV:$(($REV-1)) .
}
