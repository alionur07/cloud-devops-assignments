# The aim of the project
AzureDevops CI/CD pipeline allows both a react frontend and a springboot backend applications to be deployed across environments. It uses terraform for infrastructure as code and AWS for public cloud.


# Project technical stack

|  |    | 
| :-------- | :------- |
| **APP** | Springboot-Backend, React-Frontend |
| **DB** | Postgresql (RDS) |
| **CI/CD** | Azure Devops |
| **Version-Control** | Github |
| **IAC** | Terraform |
| **Container Management Service** | Amazon EKS |
| **Container Registery** | DockerHub |
| **Monitoring** | Prometheus, Grafana, ElasticStack, Fluentd |

# Project Architecture
![image](https://user-images.githubusercontent.com/33215825/150870066-cf784f07-c705-4711-9181-26871fae3368.png)


# DB
Used **spring.jpa.hibernate.ddl-auto=update** methods in application.properties file to create tables using data model entities. 

Default data model and table are given below.

![image](https://user-images.githubusercontent.com/33215825/150870968-fbe7012d-e100-4daf-909e-204503cba95c.png)
![image](https://user-images.githubusercontent.com/33215825/150871049-2c562892-85d8-449f-b6c0-0cf0eba196be.png)

# IAC-Terraform

VPC, RDS, EKS, SecurityGroups, Auidt components are created with terraform in infrasutracture.


**EKS layer gives us Kubeconfig and we will use it on the CI/CD step. Also we can use on local.**


## CI/CD

----------------------------------


## Monitoring
```
kubectl port-forward svc/kube-prometheus-stack-grafana 8081:80
```
```
user: admin
pass: prom-operator
```
![image](https://user-images.githubusercontent.com/33215825/150185778-3c7161a4-6606-4457-b90b-17fda4e92327.png)
![image](https://user-images.githubusercontent.com/33215825/150185933-12ccd433-f87f-4cf7-a9bf-d155538c4af2.png)

**Logging**
```
kubectl create ns alionur-demo-elk
kubectl apply -f .\all-in-one.yaml
kubectl apply -f .\elasticsearch.yaml
kubectl apply -f .\kibana.yaml 
`````
- Replace the elastic password in /ECK/fluentd/values.yaml with the received secret **elastic-eck-es-elastic-user**.

![image](https://user-images.githubusercontent.com/33215825/150213912-d12a0642-08bf-4221-9773-2e31389dd4a8.png)

![image](https://user-images.githubusercontent.com/33215825/150213697-37dc4bc4-acf7-4cbd-82e0-1d0d65e0fdb4.png)
```
helm install fluend fluentd/ -n alionur-demo-elk
```

![image](https://user-images.githubusercontent.com/33215825/150213440-4319266b-ccb3-40bf-b7d0-6fb912b495bb.png)

## Destroy
```
cd terraform/eks
terraform destroy -auto-approve -var-file="../secrets.auto.tfvars"
```
```
cd terraform/rds
terraform destroy -auto-approve -var-file="../secrets.auto.tfvars"
```
```
cd terraform/vpc
terraform destroy -auto-approve -var-file="../secrets.auto.tfvars"
```
## References

 - https://www.hashicorp.com/
 - https://bitnami.com/
 - https://helm.elastic.co
 - https://prometheus-community.github.io/helm-charts
