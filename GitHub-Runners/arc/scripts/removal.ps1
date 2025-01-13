param (
    [string]$NAMESPACE = "gh-runner-demo-workshop2",
    [string]$INSTALLATION_NAME = "arc-runner-demo-workshop2",
    [string]$CONTROLLER_NAME = "$($INSTALLATION_NAME)-ctrl"
)

helm uninstall $CONTROLLER_NAME --namespace $NAMESPACE
helm uninstall $INSTALLATION_NAME --namespace $NAMESPACE


