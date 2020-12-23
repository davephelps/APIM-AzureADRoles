$subs="My Subscription"
#Connect-AzAccount
#az account set --subscription $subs

'.\App Role Functions.ps1'

# Create the Service App Registration
$serviceAppName = "Contoso Retail API"
$applicationIdentifier = "https://contoso.com/retail"
CreateServiceAppRegistration -serviceAppName $serviceAppName -applicationIdentifier $applicationIdentifier

# Now create the app roles
$serviceAppRoleName = "sales.read"
$serviceAppRoleDescription = "Sales API read access"
CreateAppRoles  -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName -serviceAppRoleDescription $serviceAppRoleDescription

$serviceAppRoleName = "sales.write"
$serviceAppRoleDescription = "Sales API write access"
CreateAppRoles  -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName -serviceAppRoleDescription $serviceAppRoleDescription


$serviceAppRoleName = "returns.write"
$serviceAppRoleDescription = "Returns API write access"
CreateAppRoles  -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName -serviceAppRoleDescription $serviceAppRoleDescription

$serviceAppRoleName = "returns.read"
$serviceAppRoleDescription = "Returns API read access"
CreateAppRoles  -serviceAppName $serviceAppName -serviceAppRoleName $serviceAppRoleName -serviceAppRoleDescription $serviceAppRoleDescription
