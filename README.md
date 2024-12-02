# End-to-end DevOps | Python - MySQL App

> This is a simple Python Flask application that performs CRUD operations on a MySQL database, the project contains scripts and Kubernetes manifests for deploying the Python application with Mysql Database on an AWS EKS cluster and RDS with an accompanying ECR repositories. The deployment includes setting up monitoring with Prometheus and Grafana, and a CI/CD pipeline.

## Technologies

- Python
- MySQL 
- AWS 
- Docker
- Kubernetes
- Terraform
- Helm
- GitHub Actions
- Bash Script

### Running the App

1. Clone the repository:

   ```
   git clone https://github.com/ahmedalaa14/Full-DevOps-Project-AWS-Python-MySQL
   cd /todo-app
   ```

2. Create a virtual environment and activate it:

   ```
   python3 -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```

3. Install the required dependencies:

   ```
   pip3 install -r requirements.txt
   ```

4. Start the Flask application:

   ```
   python3 app.py
   ```

5. Access the application at `http://localhost:5000`.

## 2. Running with Docker 

1. Build the Docker image:

   ```
   docker build -t todo-app .
   ```

2. Run the Docker container with host network (to access the local MySQL server):

   ```
   docker run --network=host todo-app
   ```

3. Access the application at `http://localhost:5000`.

## 3. Running App and Database with Docker compose (Optional)

To run the application using docker compose:

```
docker-compose up
```

This will Run both the application and the database containers and will also create a table in the database using the sql script `init-db.sql`

To take it down run the following command:

```
docker-compose down
```

## 4. Build, Deploy and Run the application on AWS EKS and RDS

To build and deploy the application on AWS EKS and RDS execute the following script:

```
./build.sh
```

This will build the infrastructure, Deploy Monitoring Tools, and run some commands:

1.  EKS (Kubernetes Cluster)
2.  2x ECR (Elastic Container Registry) `One for the App Image and one for the DB K8s Job`
3.  RDS (Relational Database Service) `RDS Cluster with One Instance`
4.  Generate and store RDS credentials into AWS Secret Manager
5.  VPC, Subnets and Network Configuration
6.  Monitoring Tools Deployment (Alert Manager, Prometheus, Grafana)
7.  Build and Push the Dockerfile for the Application and MySQL Kubernetes Job to the ECR
8.  Create Kubernetes Secrets with the RDS Credentials
9.  Create Namespace and Deploy the application and the Job
10. Reveal the LoadBalancer URL for the application, alertmanager, prometheus and grafana

