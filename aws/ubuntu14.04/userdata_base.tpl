#!/bin/bash -ex

# Disable swapping

sysctl vm.swappiness=0
echo "vm.swappiness = 0" >> /etc/sysctl.conf



# Ensure 1500 MTU

ip link set dev eth0 mtu 1500
echo "post-up /sbin/ifconfig eth0 mtu 1500" >> /etc/network/interfaces.d/eth0.cfg



# Disable hugepages

apt-get install -y hugepages
hugeadm --thp-never
echo never > /sys/kernel/mm/transparent_hugepage/defrag



# Mount data drive

mkfs -t ext4 /dev/xvdb
mkdir /mnt/data
mount -t ext4 /dev/xvdb /mnt/data
echo "/dev/xvdb /mnt/data ext4 defaults 0 1" >> /etc/fstab

mkdir /mnt/data/couchbase
mkdir /mnt/data/couchbase/data
mkdir /mnt/data/couchbase/index
chmod -R 777 /mnt/data/couchbase


# Install Couchbase

wget -O ~/couchbase.deb ${installer_url}
dpkg -i ~/couchbase.deb

sleep 15



# Node init

/opt/couchbase/bin/couchbase-cli node-init -c 127.0.0.1:8091 \
  --node-init-data-path=/mnt/data/couchbase/data \
	--node-init-index-path /mnt/data/couchbase/index \
	-u Administrator -p `ec2metadata --instance-id`
