# End-to-end DevOps | Python - MySQL App

-  This is a simple Python Flask application that performs CRUD operations on a MySQL database, the project contains scripts and Kubernetes manifests for deploying the Python application with Mysql Database on an AWS EKS cluster and RDS with an accompanying ECR repositories. The deployment includes setting up monitoring with Prometheus and Grafana, and a CI/CD pipeline.

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

## 7. CI/CD Workflows

This project is equipped with GitHub Actions workflows to automate the Continuous Integration (CI) and Continuous Deployment (CD) processes.

### Continuous Integration Workflow

The CI workflow is triggered on pushes to the `main` branch. It performs the following tasks:

- Checks out the code from the repository.
- Configures AWS credentials using secrets stored in the GitHub repository.
- Logs in to Amazon ECR.
- Builds the Docker image for the Python app.
- Builds the Docker image for MySQL Kubernetes job.
- Tags the images and pushes each one to the it's Amazon ECR repository.

### Continuous Deployment Workflow

The CD workflow is triggered upon the successful completion of the CI workflow. It performs the following tasks:

- Checks out the code from the repository.
- Configures AWS credentials using secrets stored in the GitHub repository.
- Sets up `kubectl` with the required Kubernetes version.
- Deploys the Kubernetes manifests found in the `k8s` directory to the EKS cluster.

### GitHub Actions Secrets:

The following secrets need to be set in your GitHub repository for the workflows to function correctly:

- `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key.
- `KUBECONFIG_SECRET`: Your Kubernetes config file encoded in base64.

#### 1. Setting Up GitHub Secrets for AWS

Before using the GitHub Actions workflows, you need to set up the AWS credentials as secrets in your GitHub repository. The included `github_secrets.sh` script automates the process of adding your AWS credentials to GitHub Secrets, which are then used by the workflows. To use this script:

1. Ensure you have the GitHub CLI (`gh`) installed and authenticated.
2. Run the script with the following command:

   ```bash
   ./github_secrets.sh
   ```

This script will:

- Extract your AWS Access Key ID and Secret Access Key from your local AWS configuration.
- Use the GitHub CLI to set these as secrets in your GitHub repository.

**Note**: It's crucial to handle AWS credentials securely. The provided script is for demonstration purposes, and in a production environment, you should use a secure method to inject these credentials into your CI/CD pipeline.

These secrets are consumed by the GitHub Actions workflows to access your AWS resources and manage your Kubernetes cluster.

#### 2. Adding KUBECONFIG to GitHub Secrets

For the Continuous Deployment workflow to function properly, it requires access to your Kubernetes cluster. This access is granted through the `KUBECONFIG` file. You need to add this file manually to your GitHub repository's secrets to ensure secure and proper deployment.

To add your `KUBECONFIG` to GitHub Secrets, follow these steps:

1. Encode your `KUBECONFIG` file to a base64 string:

   ```bash
   cat ~/.kube/config | base64
   ```

2. Copy the encoded output to your clipboard.

3. Navigate to your GitHub repository on the web.

4. Go to `Settings` > `Secrets` > `New repository secret`.

5. Name the secret `KUBECONFIG_SECRET`.

6. Paste the base64-encoded `KUBECONFIG` data into the secret's value field.

7. Click `Add secret` to save the new secret.

This `KUBECONFIG_SECRET` is then used by the CD workflow to authenticate with your Kubernetes cluster and apply the required configurations.


