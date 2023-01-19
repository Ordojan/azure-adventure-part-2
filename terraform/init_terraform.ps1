param (
    [string]
    $appName = "automation",
    [string]
    $resouceGroupName = "terraform",
    [string]
    $location = "northeurope",
    [string]
    $storageAccountName = "terraformstate$(Get-Random -Minimum 1000 -Maximum 9999)",
    [string]
    $containerName = "tfstate"
)

$subscription = $(az account show --query id -o tsv)
$credentials = $(az ad sp create-for-rbac -n $appName --role Contributor --scopes /subscriptions/$subscription)

az group create --name $resouceGroupName --location $location -o none
az storage account create --name $storageAccountName --resource-group $resouceGroupName --auth-mode login -o none 
az storage container create --name $containerName --account-name $storageAccountName -o none

Write-Output "credentials:"
Write-Output $credentials
Write-Output "resouce group name: $resouceGroupName"
Write-Output "storage account name: $storageAccountName"
Write-Output "container name: $containerName"
