# Starting a GitHub Action Workflow with AWS CodeBuild

This guide explains how to start a GitHub Action workflow using AWS CodeBuild. Once your integration is set up, follow these steps to trigger workflows effectively.

---

## **Steps to Start a GitHub Action Workflow**

### **1. Ensure CodeBuild and GitHub Integration**
Before starting a workflow, make sure you:
- Have set up a **CodeBuild project** integrated with your GitHub repository.
- Verified the GitHub App and webhook configurations as detailed in [AWS CodeBuild: Setting Up GitHub Integration](./1.codebuild-github-integration.md).

---

## **2. Create a GitHub Action Workflow**

Below is an example of a GitHub Actions workflow YAML file that points to the CodeBuild project created in the previous step:

```yaml
name: AWS CodeBuild test workflow

on: workflow_dispatch

jobs:
  PrintEnvironmentInfo:
    runs-on:
      - codebuild-gh-runner01-${{ github.run_id }}-${{ github.run_attempt }}
    steps:
      - run: |
          echo "Build Image: $CODEBUILD_BUILD_IMAGE"
          echo "Build ID: $CODEBUILD_BUILD_ID"
          echo "Build ARN: $CODEBUILD_BUILD_ARN"
          echo "Project Name: $CODEBUILD_PROJECT_NAME"
      - run: printenv
```

- Replace `gh-runner01` with the appropriate prefix for your CodeBuild runner.
- Ensure AWS CodeBuild and GitHub configurations are correctly set up.

---

## **3. Trigger the Workflow**

### **Manual Trigger**
You can manually trigger a GitHub Action workflow:

1. Go to the **Actions** tab in your repository.
2. Select the desired workflow.
3. Click **Run workflow** button.

---

## **4. Validating the Workflow Execution**

1. **GitHub Actions Logs**:
   - Verify that the workflow executes successfully without errors.
   - Check for any CodeBuild-related logs or outputs in the logs.

2. **CodeBuild Logs**:
   - In the AWS Management Console, navigate to **CodeBuild**.
   - Check the build history and logs for detailed execution status.

---

## **5. Troubleshooting Common Issues**

1. **Webhook Not Triggering**:
   - Ensure the webhook is active in GitHub under **Settings** → **Webhooks**.
   - Confirm that the event type (e.g., `WORKFLOW_JOB_QUEUED`) is correctly set in CodeBuild.

2. **Workflow Fails**:
   - Verify the GitHub Action YAML file for any misconfigurations.
   - Check resource limits and permissions in CodeBuild.

3. **Logs Are Incomplete**:
   - Ensure proper logging is configured in both GitHub Actions and CodeBuild.

---

This guide provides the basic steps to create, start, and monitor a GitHub Action workflow using AWS CodeBuild. For advanced configurations, refer to the official [AWS CodeBuild Documentation](https://docs.aws.amazon.com/codebuild/latest/userguide/welcome.html).
