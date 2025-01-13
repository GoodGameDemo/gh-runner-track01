param (
    [string]$NAMESPACE = "gh-runner-demo-workshop2"
)

$resources = kubectl api-resources --verbs=list --namespaced -o name

foreach ($resource in $resources) {
    $items = kubectl get $resource -n $NAMESPACE -o json | ConvertFrom-Json
    foreach ($item in $items.items) {
        $name = $item.metadata.name
        kubectl patch $resource $name -n $NAMESPACE -p '{"metadata":{"finalizers":[]}}' --type=merge
    }
}