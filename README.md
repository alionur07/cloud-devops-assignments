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

![image](https://user-images.githubusercontent.com/33215825/150872487-42f600dd-d860-4089-885f-5e3ad9b1e732.png)

**After the infrastructure is created, eks.tf gives us Kubeconfig and we will use it in the CI/CD step. We can also use it locally.**

## CI/CD

Infrastructure installation/destroy and application deployment process is done with AzureDevops CI/CD pipeline. In this architecture, 2 different CI and CD pipelines in Azure Devops. The descriptions are below

**CI**
- First pipeline compiles, tests, builds image  and publishes to a docker hub.
 ![image](https://user-images.githubusercontent.com/33215825/150874209-b23e1b22-a6df-48b9-940e-b6874496d12e.png)
 

- Second pipeline pulishes to infrastructure files to CD step.
![image](https://user-images.githubusercontent.com/33215825/150874269-5a7d2254-df80-4f32-b748-6c26b395cb12.png)
**Tip** Default agent is installed and used for apply and destroy processes. 

**CD**
- First pipeline include create and destroy infrastructure. The create infra gives DB and kubeconfig informations. We need to add db information to application.properties file. Service account should be created to be used in ci/cd pipeline with kubeconfig.
 
![image](https://user-images.githubusercontent.com/33215825/150874854-6b292440-50cf-449f-9574-9f700e055d7c.png)

- **Contoso-App-Components-CD** pipeline include install monitoring, ingress template  with helm. Includes **Comtoso-App-CD** associated with **Contoso-App-Components-CD**, fluentd, and application layer deployment.

![image](https://user-images.githubusercontent.com/33215825/151060686-ecad31cf-84ce-4167-beb6-e6e3338b6729.png)
![image](https://user-images.githubusercontent.com/33215825/151060832-782b409e-1190-4d26-b876-45a436d35694.png)
 ![image](https://user-images.githubusercontent.com/33215825/150875307-7fa0a026-4cb5-428d-9403-1b5605357946.png)

**Tip** It should be checked the dns given to by the ingress controller and added to the host section of the contoso-app values yaml.

![image](https://user-images.githubusercontent.com/33215825/151043574-30778c1f-c960-4752-af96-87999637f325.png)

**Tip** we should wait for the Release Component (which means monitoring tools and ingress) step. After completion the release component step, we should change elastic password in fluentd values yaml and execute Release Component fluentd pipeline. 

**Application login page and create employee outputs are below.**

|  |    | 
| :-------- | :------- |
|![image](https://user-images.githubusercontent.com/33215825/151051764-8efc4bae-af70-4115-a008-d84507969b04.png) | ![image](https://user-images.githubusercontent.com/33215825/151051612-6987f8e7-7b4f-42bf-8bd0-6c3fb250256e.png) |
| ![image](https://user-images.githubusercontent.com/33215825/151051639-fd134843-2efd-4b97-8df0-002c9f1c336b.png) | ![image](https://user-images.githubusercontent.com/33215825/151051673-6fbd0ed3-f4e3-42fc-b3b7-ba1405169bc6.png) |

----------------------------------


## Monitoring
```
kubectl port-forward svc/kube-prometheus-stack-grafana 8081:80
```
```
user: admin
pass: prom-operator
```


**Logging**

- Replace the elastic password in /ECK/fluentd/values.yaml with the received secret **elastic-eck-es-elastic-user**.

![image](https://user-images.githubusercontent.com/33215825/150213912-d12a0642-08bf-4221-9773-2e31389dd4a8.png)

![image](https://user-images.githubusercontent.com/33215825/150213697-37dc4bc4-acf7-4cbd-82e0-1d0d65e0fdb4.png)

![image](https://user-images.githubusercontent.com/33215825/150213440-4319266b-ccb3-40bf-b7d0-6fb912b495bb.png)

## Destroy

## References

 - https://www.hashicorp.com/
 - https://bitnami.com/
 - https://helm.elastic.co
 - https://prometheus-community.github.io/helm-charts
 - https://docs.spring.io/spring-metrics/docs/current/public/prometheus
