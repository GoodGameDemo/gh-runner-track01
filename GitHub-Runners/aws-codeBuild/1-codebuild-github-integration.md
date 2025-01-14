# Exercise 1.1  Setting Up GitHub & AWS CodeBuild Integration

## **Steps to Set Up CodeBuild with GitHub Integration**

### **1. Create a CodeBuild Project**

1. **Log in to AWS**:
   - Access the [AWS Management Console](https://aws.amazon.com/console/) and navigate to **CodeBuild**.

2. **Create Build Project**:
   - Click **Create build project** and fill in the **Project name** field.

3. **Source Configuration**:
   - Set the following for your source repository:
     - **Source provider**: Select **GitHub**.
     - **Credential**: Choose **Custom source credential**.
     - **Credential type**: Select **GitHub App**.
     - **Connection**: Click **Create a new GitHub connection** (only one group member needs to perform this step):
       - Enter a **Connection Name** (e.g., `gh-runner-connection`) and click **Connect to GitHub**.
       - Authenticate with GitHub and complete the connection setup.
       - Select the newly created connection in the **Connection** dropdown.

4. **Repository Options**:
   - Choose one of the following:
     - **GitHub Scoped Webhook** (required for organization-level runners). This requires specifying the organization name (Step #5).
     - **Repository in my GitHub account** for repository-level runners. Set the repository name in the **GitHub repository** field.

5. **Primary Source Webhook Events**:
   - Define how and where the webhook will be registered (Step #):
     - Set **Organization** as `GoodGameDemo` (only visible if `GitHub Scoped Webhook` is selected). Try changing the value to observe how it updates dynamically.

6. **Filter Group Configuration**:
   - 🚨 Expand **Filter group 1** and set **Event type** to `WORKFLOW_JOB_QUEUED`.🚨
   - Note: The `Buildspec` option is disabled when this selection is made. Without this, CodeBuild will look for a `buildspec.yml` file in your repository and will not execute the GitHub Actions workflow.

7. **Environment Configuration**:
   - Set the runner compute resources as needed in the **Environment** section. 
   - The underlying infrastructure is EC2-based, with Lambda used in specific cases.
   - Additional details and pricing can be found in the [CodeBuild Pricing](https://aws.amazon.com/codebuild/pricing/) page.

8. **Create the Build Project**:
   - Once all configurations are complete, click **Create build project**.

---

## **Validation Steps**

After configuration, validate the integration on GitHub:

1. **GitHub App**:
   - Verify the creation of a GitHub App named **AWS Connector for GitHub** in:
     - **Settings** → **Third-party Access** → **GitHub Apps**.

2. **Webhook**:
   - Check the creation of the webhook in:
     - **Settings** → **Code, planning, and automation** → **Webhooks**.

---

Extra:
 - Change Region to `eu-east-1` and notice the differinces .

This setup enables seamless integration of AWS CodeBuild with your GitHub repository for efficient CI/CD workflows.