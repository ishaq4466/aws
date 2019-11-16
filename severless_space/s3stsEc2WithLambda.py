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









