
#----------------------------------------------------------------
# Start ssh service and allow passwordless ssh to localhost
#----------------------------------------------------------------

/etc/init.d/ssh start

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
key=$(cat ~/.ssh/id_rsa.pub)
if ! grep -q \"$key\" ~/.ssh/authorized_keys; then
	echo $key >> ~/.ssh/authorized_keys
fi
chmod 0600 ~/.ssh/authorized_keys

#--------------------------------
# Hadoop and YARN
#--------------------------------

# format filesystem
/opt/hadoop/hadoop-3.2.2/bin/hdfs namenode -format
sleep 5

# start NameNode daemon
/opt/hadoop/hadoop-3.2.2/sbin/start-dfs.sh &
sleep 5

# make the HDFS directories needed for MapReduce jobs
/opt/hadoop/hadoop-3.2.2/bin/hdfs dfs -mkdir /user
/opt/hadoop/hadoop-3.2.2/bin/hdfs dfs -mkdir /user/chw925

# Start ResourceManager daemon and NodeManager daemon
/opt/hadoop/hadoop-3.2.2/sbin/start-yarn.sh


