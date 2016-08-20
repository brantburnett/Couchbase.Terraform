for i in 1 2 3 4 5
do
  /opt/couchbase/bin/couchbase-cli server-add -c 127.0.0.1:8091 -u Administrator -p ${cluster_password} \
    --server-add=${server_ip}:8091 --server-add-username=Administrator --server-add-password=${server_password} \
    --services=${services} \
    && break

  # Sleep 15 seconds between add attempts
  sleep 15
done
