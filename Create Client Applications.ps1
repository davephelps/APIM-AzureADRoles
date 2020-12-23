'.\App Role Functions.ps1'
$subs="My Subscription"
#Connect-AzAccount
#az account set --subscription $subs

# This is the client Application Registration we want to give permission to in order to access a role on the service API
$serviceAppName = "Contoso Retail API"
$clientAppName = "Contoso Client 3"
CreateClientApplication  -clientAppName $clientAppName

$serviceAppName = "Contoso Retail API"
$clientAppName = "Contoso Client 3"

$serviceAppRoleName = "sales.read"
$serviceAppRoleDescription = "Sales API read access"
AssignAppRolesToApp -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName  -clientAppName $clientAppName

$clientAppName = "Contoso Client 3"
$serviceAppRoleName = "sales.write"
$serviceAppRoleDescription = "Sales API write access"
AssignAppRolesToApp -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName  -clientAppName $clientAppName

$serviceAppName = "Contoso Retail API"
$clientAppName = "Contoso Client 4"
AssignAppRolesToApp  -clientAppName $clientAppName

$clientAppName = "Contoso Client 4"
$serviceAppRoleName = "returns.read"
$serviceAppRoleDescription = "Returns API read access"
AssignAppRolesToApp -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName -clientAppName $clientAppName

$clientAppName = "Contoso Client 4"
$serviceAppRoleName = "sales.read"
$serviceAppRoleDescription = "Sales API read access"
AssignAppRolesToApp -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName -clientAppName $clientAppName

