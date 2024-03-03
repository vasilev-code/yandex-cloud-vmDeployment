#!/bin/bash

yc compute instance list | grep -E '[[:alpha:][:digit:]]{20}' > tmp7YC.txt
awk '{print $2}' tmp7YC.txt > tmp8YC.txt
wc -l tmp8YC.txt > tmpVMCount.txt
awk '{print $1}' tmpVMCount.txt > tmp9YC.txt
vmCount=$(cat tmp9YC.txt)
for ((instanceCount = 1; instanceCount <= $vmCount; instanceCount++))
do
vmName=$(cat tmp8YC.txt | head -n$instanceCount)
yc compute instance delete --id $vmName
done

yc vpc subnet list | grep -E '[[:alpha:][:digit:]]{20}' > tmpYC.txt
awk '{print $2}' tmpYC.txt > tmp2YC.txt
wc -l tmp2YC.txt > tmpCount.txt
awk '{print $1}' tmpCount.txt > tmp3YC.txt
subnetCount=$(cat tmp3YC.txt)
for ((subCount = 1; subCount <= $subnetCount; subCount++))
do
subnetName=$(cat tmp2YC.txt | head -n$subCount)
yc vpc subnet delete --id $subnetName
done

yc vpc network list | grep -E '[[:alpha:][:digit:]]{20}' > tmp4YC.txt
awk '{print $2}' tmp4YC.txt > tmp5YC.txt
wc -l tmp5YC.txt > tmpNetCount.txt
awk '{print $1}' tmpNetCount.txt > tmp6YC.txt
netCount=$(cat tmp6YC.txt)
for ((networkCount = 1; networkCount <= $netCount; networkCount++))
do
networkName=$(cat tmp5YC.txt | head -n$networkCount)
yc vpc network delete --id $networkName
done

rm -rf tmp*

