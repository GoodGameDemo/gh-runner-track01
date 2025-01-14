# # Exercise 2.1 Setting Up and Using ARC Runner for GitHub Actions
This guide provides step-by-step instructions on how to set up and use the Action Runner Controller (ARC) for managing self-hosted GitHub runners on Kubernetes.

## Prerequisites

- Kubernetes cluster
- Helm installed
- GitHub Personal Access Token (PAT)

## Installation

### Step 1: Create a GitHub Personal Access Token (PAT)

1. Go to [GitHub Settings](https://github.com/settings/tokens).
2. Click on **Generate new token**.
3. Provide a **Note** for the token, such as "ARC Runner Token".
4. Select the **Expiration** for the token.
5. Under **Select scopes**, check the following:
    - `repo`
    - `admin:repo_hook`
    - `workflow`
6. Click **Generate token**.
7. Copy the generated token and store it securely. You will need it for the installation script.

### Step 2: Update YAML Files

Before running the installation script, ensure that the values in the `controller.yaml` and `listener.yaml` files are correctly set.

#### `controller.yaml`
- **resources**: Adjust the CPU and memory limits and requests as needed.
- **metrics**: Configure the metrics endpoints and addresses.

#### `listener.yaml`

- **githubConfigUrl**: Set the URL of your GitHub repository.
- **githubConfigSecret**: Ensure the secret name matches the one created in the installation script.
- **maxRunners**: Set the maximum number of runners.
- **minRunners**: Set the minimum number of runners.

### Step 3: Run the Installation Script

Use the `install-arc.ps1` script to install ARC in your Kubernetes cluster.

### Example Usage
```powershell
.\install-arc.ps1 -NAMESPACE "gh-runner-demo-workshop2" -INSTALLATION_NAME "arc-runner-demo-workshop2" -CONTROLLER_NAME "arc-runner-demo-workshop2-ctrl" -PAT "<your-personal-access-token>"
```

### Step 4: Verify the Deployment

After running the installation script, verify that all resources have been deployed successfully in your Kubernetes cluster.

Use the following command to check the status of the resources in the specified namespace:

```powershell
kubectl get all -n gh-runner-demo-workshop2
```

You should see the following resources:

- 2 Pods
- 1 Deployment
- 1 ReplicaSet
### Example Output

After running the verification command, you should see an output similar to the following:

```powershell
PS C:\> k get all -n gh-runner-demo-workshop2
NAME                                                                  READY   STATUS    RESTARTS   AGE
pod/arc-runner-demo-workshop2-848f4665-listener                       1/1     Running   0          58s
pod/arc-runner-demo-workshop2-ctrl-gha-rs-controller-6b964ddc4j6tsh   1/1     Running   0          64s

NAME                                                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/arc-runner-demo-workshop2-ctrl-gha-rs-controller   1/1     1            1           64s

NAME                                                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/arc-runner-demo-workshop2-ctrl-gha-rs-controller-6b964ddc4   1         1         1       64s
```