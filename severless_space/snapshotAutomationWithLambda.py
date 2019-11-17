from datetime import datetime
import boto3


# Keeping only the 3 most recent snapshots and deleting rest all.
def prune_snapshots(): 
    account_id = boto3.client('sts').get_caller_identity().get('Account')
    ec2 = boto3.client('ec2')
    regions = [region['RegionName']
               for region in ec2.describe_regions()['Regions']]

    for region in regions:
        print("Region:", region)
        ec2 = boto3.client('ec2', region_name=region)
        response = ec2.describe_snapshots(OwnerIds=[account_id])
        snapshots = response["Snapshots"]

        # Sort snapshots by date ascending
        snapshots.sort(key=lambda x: x["StartTime"])

        # Remove snapshots we want to keep (i.e. 3 most recent)
        snapshots = snapshots[:-3]

        for snapshot in snapshots:
            id = snapshot['SnapshotId']
            try:
                print("Deleting snapshot:", id)
                ec2.delete_snapshot(SnapshotId=id)
            except Exception as e:
                print("Snapshot {} in use, skipping.".format(id))
                continue



def create_snapshot():

    ec2_client = boto3.client('ec2')
    regions = [region['RegionName']
               for region in ec2_client.describe_regions()['Regions']]

    for region in regions:
        print('Instances in EC2 Region {0}:'.format(region))
        ec2 = boto3.resource('ec2', region_name=region)


        # Getting all the instances with tag name=> backup:true
        instances = ec2.instances.filter(Filters=[{'Name': 'tag:backup', 'Values': ['true']}])

        # Return an ISO 8601 timestamp, i.e. 2019-01-31T14:01:58
        timestamp = datetime.utcnow().replace(microsecond=0).isoformat()

        for i in instances.all():
            for v in i.volumes.all():
            	# Saving the backup description as below also this description
            	# is printed on the cloud watch log
                desc = 'Backup of {0}, volume {1}, created {2}'.format(
                    i.id, v.id, timestamp)
                print(desc)
                snapshot = v.create_snapshot(Description=desc)
                print("Created snapshot:", snapshot.id)










