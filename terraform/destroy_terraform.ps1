param (
    [string]
    $appName = "automation",
    [string]
    $resouceGroupName = "terraform-rg"
)

az group delete --name $resouceGroupName

$appId = $(az ad sp list --display-name $appName --query [0].appId -o tsv)
az ad sp delete --id $appId
az ad app delete --id $appId 
