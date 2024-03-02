#!/bin/bash

read -p "Введите количество виртуальных машин(не более 12): "
minVM=1
maxVM=12

if [[ $REPLY -lt $minVM || $REPLY -gt $maxVM ]]; then 
echo "Количество ВМ должно быть неменьше 1 и небольше 12"
exit
else

yc vpc network create \
  --name yc-network \
  --labels my-label=yandex-cloud-network \
  --description "network"

yc vpc subnet create \
  --name yc-subnet-a \
  --zone ru-central1-a \
  --range 10.1.2.0/24 \
  --network-name yc-network \
  --description "subnet"

for (( i=1; i <=$REPLY; i++ ))

do

yc compute instance create \
  --name yc-instance$i \
  --network-interface subnet-name=yc-subnet-a,nat-ip-version=ipv4 \
  --zone ru-central1-a \
  --ssh-key ~/.ssh/id_ed25519.pub
done
fi
