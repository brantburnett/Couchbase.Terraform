${userdata_base}

# Cluster init

/opt/couchbase/bin/couchbase-cli cluster-init -c 127.0.0.1:8091 -u Administrator -p `ec2metadata --instance-id` \
  --cluster-username=Administrator --cluster-password=${cluster_password} \
  --cluster-ramsize=${data_ramsize} --cluster-index-ramsize=${index_ramsize} --cluster-fts-ramsize=${fts_ramsize} \
  --services=data

# Attach other Servers

${attach_servers}

# Rebalance

/opt/couchbase/bin/couchbase-cli rebalance -c 127.0.0.1:8091 -u Administrator -p ${cluster_password}

# Additional Initialization

${additional_initialization_script}
