import boto3

def spin_ec2(imageId,instanceType,keyName,minCount,maxCount):
	ec2=boto3.client('ec2')
	response=ec2.run_instances(ImageId='imageId',InstanceType='instanceType',KeyName='keyName',MinCount=',minCount',MaxCount='maxCount')
	print(response)

def list_buckets():
	print("Getting all the bucket")
	s3=boto3.resource('s3')
	for bucket in s3.buckets.all():
		print(bucket)

def who_you_are():
	print("Getting the user info")
	sts=boto3.client('sts') 
	sts.get_caller_identity() # it will return a dictionary


def stop_instance():
    # Get list of regions
    ec2_client = boto3.client('ec2')
    regions = [region['RegionName']
               for region in ec2_client.describe_regions()['Regions']]

    # Iterate over each region
    for region in regions:
        ec2 = boto3.resource('ec2', region_name=region)

        print("Region:", region)

        # Get only running instances
        instances = ec2.instances.filter(
            Filters=[{'Name': 'instance-state-name',
                      'Values': ['running']}])

        # Stop the instances
        for instance in instances:
            instance.stop()
            print('Stopped instance: ', instance.id)






