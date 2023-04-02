## by Paula Hakeem

## Project Overview:
![221335102-d0149cba-5f74-457b-83e2-0b5138feabd5](https://user-images.githubusercontent.com/116673091/229323865-1b8c896f-a5ff-4bd5-a26f-c7252e00ce34.jpg)

- Deploy a Nodejs web application on EKS using CI/CD Jenkins Pipeline using the following steps and high-level diagram:
##### 1. Implement a secure EKS Cluster
##### 2. Deploy and configure Jenkins on EKS
##### 3. Deploy the backend application on EKS using the Jenkins pipeline


## Tools:
| Tool | Purpose |
| ------ | ------ |
| [ Amazon Web Services (AWS) ](https://aws.amazon.com/) | Elastic Kubernetes Service (EKS) is a managed, production-ready environment for running containerized applications. |
| [ Jenkins ](https://www.jenkins.io) | Jenkins – an open-source automation server is enabling developers worldwide to reliably build, test, and deploy their software. |
| [ Ansible ](https://www.ansible.com/) | Ansible helps automate the implementation of internally generated applications to your production programs  |
| [ Docker ](https://www.docker.com) | Docker is a set of platform-as-a-service (PaaS) products that use OS-level virtualization to deliver software in containers|
| [ Terraform ](https://www.terraform.io) | Terraform is an open-source infrastructure as a code software tool that enables you to safely and predictably create, change, and improve infrastructure. |


## First Part: Infrastructure Overview

- ###  Network Files Consist of :
  - Three subnets two private for EKS and another for Bastion Host
  - NAT Gateway 
  - Security group allow 22 , 80 , 443 ports

- ### EKS Files Consist of:
  - private container cluster resource with authorized networks configuration
  - node pool with count 2 
- ### Bastion File: 
    - for Creating a Private VM to Connect with EKS Cluster

## Second Part: Build the Infrastructure
### 1. Clone The Repo:
```
git clone https://github.com/paulahakeem/interview_task.git
```
### 2. Navigate to Terraform Code
> After you clone the code navigate to the `Terraform_files` folder to build the infrastructure:
```
cd Terraform_files/
```
#### 3. Initialize Terraform
```
terraform init
```

#### 4. Check Plan
```
terraform plan
```

#### 5. Apply the plan
```
terraform apply
```
## Third Part: Connect to Private EKS Cluster through Bastion VM
> After the Infrastructure is built navigate to `EC2` from the AWS console then `Instances` and click the SSH to `jump_Ec2` to run these commands:
![Screenshot from 2023-04-02 02-25-40](https://user-images.githubusercontent.com/116673091/229324001-a1a11134-7f26-4e5c-8957-ff89332e778f.png)

### 0. all steps can run automated by ansible in this repo
```
cd Ansible
choose your configuration you need
get ip of VM from instance_ip.txt in Terraform_files Directory and put it in inventory.txt file
after that run this command 
ansible-playbook -i inventory.txt playbook.yml 
```


### 1. Install Kubectl
```
sudo apt-get install kubectl
```
### 2. Install awscli
```
sudo apt-get install awscli
```
### 3. Log in with your Credentials
```
aws configure
```
### 4. Connect to EKS Cluster
> to connect to EKS cluster run this command:
```
aws eks --region <region_name> update-kubeconfig --name <cluster_name>
```

### 5. Deploying the jenkins app
> create the deployment.yml file
```
kubectl apply -f deployment.yml
```
### 7. Get `admin` user Password

Connect to Cluster via VM and type
```
kubectl exec <pod_name> -it --n <name_space> -- /bin/cat /var/jenkins_home/secrets initialAdminPassword && echo
```
### 8. Get the `Jenkins URL`
```
kubectl get all -n jenkins-ns
```
and copy the external IP address (DNS name) and paste in browser url
![Screenshot from 2023-04-02 02-28-51](https://user-images.githubusercontent.com/116673091/229324077-a0f2921a-a177-4872-ab0b-66c28c138150.png)
![Screenshot from 2023-04-02 02-30-53](https://user-images.githubusercontent.com/116673091/229324128-a5d5f495-5a9c-4006-a0c9-128e0e45e0bf.png)

## 5th Part: Build CI/CD Pipeline using Jenkins

#### Once a commit is made Jenkins will:
- Build an image from Dockerfile
- Push the image to DockerHub
- Apply deployment for the app based on the image
- Apply LoadBalancer service for the app

### 1. Add Credentials in Jenkins
- #### DockerHub Credentials
> Add your DockerHub Credentials `(Username and Password)` and save the id with this value `Dockerhub`.
![Screenshot from 2023-04-02 02-35-01](https://user-images.githubusercontent.com/116673091/229324213-928d8c46-48c0-4dfc-9fdb-9316af47999b.png)

### 2. Create CI Pipeline:
- Pull Code from GitHub
- Build the Application image using Docker
- Push Image to DockerHub
- Trigger CD Pipeline to Run

### 3. Create CD Pipeline:
- Deploy Application in EKS

## 6th Part: Check the Application
- get application external ip (DNS name) using the following command in the VM

```
kubectl get all -n backend
```
- Finally access the application
![Screenshot from 2023-04-02 02-37-10](https://user-images.githubusercontent.com/116673091/229324277-69c08442-ce93-4c22-ac7a-5e6ae4b5d18a.png)

----
# Screenshots from AWS console
![Screenshot from 2023-04-02 02-41-50](https://user-images.githubusercontent.com/116673091/229324364-f3a98da3-6c8a-4312-94f0-1b5af14389a3.png)
![Screenshot from 2023-04-02 02-43-34](https://user-images.githubusercontent.com/116673091/229324409-379bbb49-56a8-4949-8668-7090984a287e.png)


