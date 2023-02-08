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

az ad app permission add --id $credentials["appId"] --api 00000003-0000-0000-c000-000000000000 --api-permissions 741f803b-c850-494e-b5df-cde7c675a1ca=Role 1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9=Role 62a82d76-70ea-41e2-9197-370581804d09=Role
az ad app permission admin-consent --id $credentials["appId"]

az group create --name $resouceGroupName --location $location -o none
az storage account create --name $storageAccountName --resource-group $resouceGroupName -o none 
az storage container create --name $containerName --account-name $storageAccountName --auth-mode login -o none

Write-Output "credentials:"
Write-Output $credentials
Write-Output "resouce group name: $resouceGroupName"
Write-Output "storage account name: $storageAccountName"
Write-Output "container name: $containerName"
