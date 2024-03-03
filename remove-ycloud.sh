#!/bin/bash
yc vpc subnet list | grep -E '[[:alpha:][:digit:]]{20}' > tmpYC.txt
awk '{print $2}' tmpYC.txt > tmp2YC.txt
wc -l tmp2YC.txt > tmpCount.txt
awk '{print $1}' tmpCount.txt > tmp3YC.txt
subnetCount=$(cat tmp3YC.txt)
for (subCount = $subnetCount; subCount <= $subnetCount; subCount++)
do
yc vpc subnet delete
rm -rf tmp*

