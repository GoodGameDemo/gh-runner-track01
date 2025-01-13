param (
    [string]$NAMESPACE = "gh-runner-demo-workshop2",
    [string]$INSTALLATION_NAME = "arc-runner-demo-workshop2",
    [string]$CONTROLLER_NAME = "$INSTALLATION_NAME-ctrl",
    [string]$PAT = "<personal-access-token>"
)
kubectl create namespace $NAMESPACE

kubectl create secret generic gh-runner-secret-pat --namespace=$NAMESPACE --from-literal=github_token=$PAT
kubectl create sa $serviceAccount -n $NAMESPACE
kubectl label serviceaccount $serviceAccount -n $NAMESPACE app.kubernetes.io/managed-by=Helm --overwrite

kubectl annotate serviceaccount $serviceAccount -n $NAMESPACE meta.helm.sh/release-name=$CONTROLLER_NAME --overwrite
kubectl annotate serviceaccount $serviceAccount -n $NAMESPACE meta.helm.sh/release-namespace=$NAMESPACE --overwrite


kubectl create rolebinding sa-action-runner-rolebinding --clusterrole=admin --serviceaccount="$($NAMESPACE):$serviceAccount"  --namespace=$NAMESPACE


helm install $CONTROLLER_NAME --namespace $NAMESPACE -f controller.yaml oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller
helm install $INSTALLATION_NAME --namespace $NAMESPACE -f listener.yaml oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

