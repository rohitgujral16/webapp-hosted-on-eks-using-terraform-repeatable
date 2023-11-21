<!--- app-name:  -->
# Highly available hello-world application deployment using IAC

## Introduction
This repository aims to deploy:-
- A scalable and highly available simple web application on EKS (nginx in this case)
- Following best practices of IAC
- Repeatable consistent apply and destroy of setup.

## Prerequisites - before you begin, please install/configure below

| Name                                                                                                                                                                             | Version |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|
| <a name="requirement_aws"></a> [AWS account](https://aws.amazon.com/resources/create-account/)                                                                                   | Create  |
| <a name="requirement_aws_cli"></a> [AWS CLI configured with IAM](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html#getting-started-quickstart-new-command) | 2.11.23 |
| <a name="requirement_S3-bucket"></a> [S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html)                                              | Create  |
| <a name="requirement_terraform"></a> [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)                                                | 1.4.7   |
| <a name="requirement_kubectl"></a> [kubectl](https://kubernetes.io/docs/tasks/tools/)                                                                                            | 1.28.4  |
| <a name="requirement_helm"></a> [Helm](https://helm.sh)                                                                                                                          | 3.13.2  |



## Services used for setup
- VPC
- EKS 
- Cluster autoscaler
- Load balancer
- Helm to deploy web application

We will use Makefile to spin up the AWS infrastructure and deploy the application.
You are encouraged to look into the contents of [Makefile](Makefile)
## Deploying the application
1. Clone this repository
```console
git clone url
cd repo
```
2. Export your s3 bucket name (this will be used as a remote backend for terraform)
```console
export TF_BUCKET_NAME="<your-bucket-name>"
```
3. (Optional) To avoid any conflicts if a vpc exist with same name/CIDR. If not it will pick [these default](modules/vpc/variables.tf) values
```console
export TF_VAR_vpc_name="<your-vpc-name>"
export TF_VAR_vpc_cidr="<your-cidr>"
export TF_VAR_cluster_name="<your-eks-clustername>"
```

4. Initialise the terraform code
```console
make init
```
4. Apply the code to create infrastructure and deploy application
```console
make apply
```
5. Validate if application is deployed
```console
make deploy-application
```
## Validating and Accessing the application
```
- You should be able to see a new Application Load balancer(ALB) getting created on the console.
- Wait for it to become active
```
[Local Image](images/ALB-active.png)
```
- Copy-paste the ALB in browser and you should be able to see the nginx application page
```
[Local Image](images/webpage.png)

## Validate scaling via cluster autoscaler
1. Check number on current nodes running
```console
kubectl get nodes
```
2. Scale the number of replicas from 2 to 3
```console
kubectl scale deployment hello-world-application --replicas=3
 ```
3. Monitor the number of nodes (Takes around 5 minutes). You should see another node getting added.
```console
watch -n 1 -t kubectl get nodes
```
[Local Image](images/Node-scaled-up.png)
## Destroy the complete infrasructure
```console
make destroy
```
