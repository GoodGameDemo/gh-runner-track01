# Starting a GitHub Action Workflow with ARC

This guide explains how to start a GitHub Action workflow using the Action Runner Controller (ARC). Once your integration is set up, follow these steps to trigger workflows effectively.

---

## **Steps to Start a GitHub Action Workflow**

### **1. Ensure ARC and GitHub Integration**
Before starting a workflow, make sure you:
- Have set up ARC integrated with your GitHub repository.
- Verified the GitHub App and webhook configurations as detailed in [Setting Up and Using ARC Runner for GitHub Actions](./1-Install-arc.md).

---

## **2. Create a GitHub Action Workflow**

Below is an example of a GitHub Actions workflow YAML file that points to the ARC setup created in the previous step:

```yaml
name: ARC test workflow

on: workflow_dispatch

jobs:
  PrintEnvironmentInfo:
    runs-on: arc-runner-demo-workshop2
    steps:
      - run: |
          echo "Runner Name: $RUNNER_NAME"
          echo "Runner OS: $RUNNER_OS"
          echo "Runner Arch: $RUNNER_ARCH"
      - run: echo "::add-mask::$CUSTOM_SECRET"
      - run: printenv
```

- Replace `arc-runner-demo-workshop2` with the appropriate runner label for your ARC setup.
- Ensure ARC and GitHub configurations are correctly set up.

---

## **3. Trigger the Workflow**

### **Manual Trigger**
You can manually trigger a GitHub Action workflow:

1. Go to the **Actions** tab in your repository.
2. Select the desired workflow.
3. Click **Run workflow** button.

---

## **4. Validating the Workflow Execution**
### **Check for New Pods in Kubernetes**
To ensure that a new pod is created for the workflow when it's triggered, run the following command in the appropriate namespace:

```sh
kubectl get pods -n <your-namespace>
```

Replace `<your-namespace>` with the namespace where ARC is deployed. Look for a new pod corresponding to the workflow run.

1. **GitHub Actions Logs**:
   - Verify that the workflow executes successfully without errors.
   - Check for any ARC-related logs or outputs in the logs.

2. **Kubernetes Logs**:
   - Use `kubectl` commands to check the status and logs of the ARC pods in your Kubernetes cluster.

---

## **5. Troubleshooting Common Issues**

1. **Webhook Not Triggering**:
   - Ensure the webhook is active in GitHub under **Settings** → **Webhooks**.
   - Confirm that the event type (e.g., `workflow_dispatch`) is correctly set in ARC.

2. **Workflow Fails**:
   - Verify the GitHub Action YAML file for any misconfigurations.
   - Check resource limits and permissions in ARC.

3. **Logs Are Incomplete**:
   - Ensure proper logging is configured in both GitHub Actions and ARC.

---

This guide provides the basic steps to create, start, and monitor a GitHub Action workflow using ARC. For advanced configurations, refer to the official [ARC Documentation](https://github.com/actions-runner-controller/actions-runner-controller).