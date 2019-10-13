#!/bin/bash

[ "$1" == "" ] && { echo -e "Please provide EFS endpoint\n"; exit 0; } 
[ "$2" == "" ] && { echo -e "Please provide PATH FOR KAHA_DB\n"; exit 0; }
EFSDNS="$1"
KAHADB_PATH="$2"
echo -e "EFS DNS: $EFSDNS "
echo -e "KAHADB_PATH: $KAHADB_PATH "
echo -e "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $EFSDNS:/ $KAHADB_PATH"
echo -e "sudo chown -R ec2-user:ec2-user $KAHADB_PATH"


