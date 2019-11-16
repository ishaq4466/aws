#!/bin/bash
yum update -y
sleep 2
REGION=`curl http://169.254.169.254/latest/dynamic/instance-identity/document/ | grep region |awk -F \" '{print $4}'`
INSTANCE_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
MAC_ID=`curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/`
VPC_ID=`curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$MAC_ID/vpc-id`

# Getting the route tables In $VPC_ID
ROUTETABLE_IDS=`aws ec2 describe-route-tables --region $REGION --output text | grep ROUTETABLES | grep $VPC_ID | awk '{print $3}'`


for x in $ROUTETABLE_IDS
do
# Finding the default RT for VPC
MAIN=`aws ec2 describe-route-tables --filters "Name=route-table-id,Values=$x" --query 'RouteTables[0].Associations[0].Main' --output text --region $REGION`
if [ "$MAIN" == "True" ]
then
echo "MAIN Route table: $x for VPC $VPC_ID"
TARGETS=`aws ec2 describe-route-tables --filters "Name=route-table-id,Values=$x" --output text --region $REGION | grep "0.0.0.0/0" | awk '{print $3}'` 
if [ "$TARGETS" == "" ]
then
echo "No route found with destinition 0.0.0.0/0 "
echo "Creating default route with destinition 0.0.0.0/0"
aws ec2 create-route --route-table-id $x --destination-cidr-block 0.0.0.0/0 --instance-id $INSTANCE_ID --region $REGION
echo "setting source-dest-check to no"
aws ec2 modify-instance-attribute --instance-id $INSTANCE_ID --no-source-dest-check --region $REGION
echo done
elif [ "$TARGETS" != "$INSTANCE_ID" ]
then 
echo "replacing default route with nat_id $INSTANCE_ID from $TARGETS"
aws ec2 replace-route --route-table-id $x --destination-cidr-block 0.0.0.0/0 --instance-id $INSTANCE_ID --region $REGION
echo "Replacement done"
echo "setting source-dest-check to no"
aws ec2 modify-instance-attribute --instance-id $INSTANCE_ID --no-source-dest-check --region $REGION
echo done
else
echo "No changes required"
fi
fi
done
