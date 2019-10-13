1. Create an AMI of the ec2 instance running the activeMQ service.

2. Create a Launch configuration from that AMI for the Auto Scaling group

3. From that Launch configuration create an Autoscaling group with 
	nessary size group and scaling policies.

4. Create an Classic load balancer so that the msg request comming from
	the clients first hits the LB and than equally gets distributed to the
	activeMq ec2 nodes.
	Basically we are putting tha ASG behind the LB for high avalabilty 
	and load balancing 
	
5. Test the fault tolerancy and elasticity of ASG and high avalability
	of CLB

6. For EFS using as a shared storage on which kahaDB will be synced
	between the activeMq nodes, 
	* Create an EFS with different Mount target and same security as EC2 instance
	* Automate the mounting step of EFS when the new instance get launced

### [Overview Img](https://drive.google.com/open?id=19YiNwmkcGo2u8cocgzhzAJ8a_oZd962f)