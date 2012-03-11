alias nn1="namenode 1"
alias nn2="namenode 2"
alias nn3="namenode 3"

alias dn1="datanode 1"
alias dn2="datanode 2"
alias dn3="datanode 3"

alias jt1="jobtracker 1"
alias jt2="jobtracker 2"
alias jt3="jobtracker 3"

alias tt1="tasktracker 1"
alias tt2="tasktracker 2"
alias tt3="tasktracker 3"

alias hadoop1="hadoop 1"
alias hadoop2="hadoop 2"
alias hadoop3="hadoop 3"

function mvn-test { mvn -Dtest=$1 test; }

function mvn-inst {
  mvn test -DskipTests;
  mvn install -P-cbuild -DskipTests
}

function mvn-tar { 
  mvn package -Pdist -Dtar -DskipTests -Dmaven.javadoc.skip=true;
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

# svn_merge_apache hdfs 1036213 HDFS-259
function svn_merge_apache ()
{
  BRANCH=$1
  REV=$2
  JIRA=$3
  svn merge -c $REV https://svn.apache.org/repos/asf/hadoop/$BRANCH/trunk
  echo "$JIRA. svn merge -c $REV from trunk"
}

function svn_merge_common { svn_merge_apache common $1 $2; } 
function svn_merge_hdfs { svn_merge_apache hdfs $1 $2; } 
function svn_merge_mapreduce { svn_merge_apache mapreduce $1 $2; } 

# svn_revert 1035718
function svn_revert ()
{
  REV=$1
  svn merge --revision $REV:$(($REV-1)) .
}
