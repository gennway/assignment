
## Infra part

That is an example of IaC using terragrunt (terraform wrapper).
As it's only PoC there are a lot of missing/specified parts (lack of time), but it should be enough to give an overview of my idea to deploy that infra with an app.

to be added :
- configure kafka inputs for a module
- configure ec2 (bastion host with developers ssh keys)
- configure alb/target groups/listener (https that needs acm)
- prepare valid task definition for an app to replace the "place holder task definition" that is definied in _envcommon/ecs-service.hcl valid TD should contain specified mem/cpu + env vars with SSM parameter store paths for a script that will be defined in entrypoint (mentioned in app-part/scritp-for-ssm.sh)
- configure/build a module for cloudwatch + sns, to monitor app (amount of replicas, cpu, mem)
- iam roles with policies 
- configure ssm parameter store to contain secret credientals!


![Screenshot](https://user-images.githubusercontent.com/59920176/216090123-c84e3e85-4d25-4c24-85f4-68b0b26d8e33.jpg)

