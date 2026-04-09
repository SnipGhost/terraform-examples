#!/bin/bash

# 1. Создаём security group
openstack security group create www

# 2. Получаем ID security group и добавляем правило
SECGROUP_ID=$(openstack security group show www -f value -c id)
openstack security group rule create --protocol tcp --dst-port 80 \
    --remote-ip 0.0.0.0/0 --ethertype IPv4 $SECGROUP_ID

# 3. Ищем образ
IMAGE_ID=$(openstack image show "debian-13-202602051630.gite7a38aaf" -f value -c id)

# 4. Создаём volume
openstack volume create --availability-zone GZ1 --type ceph-ssd --size 10 \
    --image $IMAGE_ID --bootable test-volume

# 5. Ищем flavor
FLAVOR_ID=$(openstack flavor show STD2-1-1 -f value -c id)

# 6. Ищем сеть
NETWORK_ID=$(openstack network show internet -f value -c id)

# 7. Создаём ВМ
openstack server create --flavor $FLAVOR_ID --key-name m-kucherenko \
  --security-group ssh --security-group www --volume test-volume \
  --network $NETWORK_ID --config-drive true --property tag=test \
  --availability-zone GZ1 test-vm
