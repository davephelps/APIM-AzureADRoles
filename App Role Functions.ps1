

Function CreateClientApplication ([string] $clientAppName)
{
    $app=Get-AzureADApplication -Filter "DisplayName eq '$clientAppName'"

    if( $null -eq $app)
    {
        $app=New-AzureADApplication -DisplayName $clientAppName

        # Crete new Service Principal and assign to the Application Registration
        $sp=New-AzureADServicePrincipal -AppId $app.AppId
    }
}

Function CreateServiceAppRegistration([string] $serviceAppName, [string] $applicationIdentifier)
{
    $app=Get-AzureADApplication -Filter "DisplayName eq '$serviceAppName'"

    if( $null -eq $app)
    {
        # Create a new Application Registration
        $uris = New-Object System.Collections.Generic.List[string]
        $uris.Add($applicationIdentifier)
        $app=New-AzureADApplication -DisplayName $serviceAppName -IdentifierUris $uris
        # Crete new Service Principal and assign to the Application Registration
        New-AzureADServicePrincipal -AppId $app.AppId
    }
}

Function CreateAppRole([string] $Name, [string] $Description)
{
    $appRole = New-Object Microsoft.Open.AzureAD.Model.AppRole
    $appRole.AllowedMemberTypes = New-Object System.Collections.Generic.List[string]
    $appRole.AllowedMemberTypes.Add("Application");
    $appRole.DisplayName = $Name
    $appRole.Id = New-Guid
    $appRole.IsEnabled = $true
    $appRole.Description = $Description
    $appRole.Value = $Name;
    return $appRole
}

Function CreateAppRoles([string] $serviceAppName, [string] $serviceAppRoleName, [string] $serviceAppRoleDescription)
{
    $appRole=CreateAppRole -Name  $serviceAppRoleName -Description $serviceAppRoleDescription

    # Create a new Application
    $app=Get-AzureADApplication -Filter "DisplayName eq '$serviceAppName'"
    $serviceSP = Get-AzureADServicePrincipal -Filter "displayName eq '$serviceAppName'"
    echo "serviceSP " $serviceSP
    $roles = $app.appRoles
    $roles.Add($appRole)

    Set-AzureADApplication -ObjectId $app.ObjectId -AppRoles $roles
}

Function AssignAppRolesToPrincipal([string] $serviceAppName, [string] $serviceAppRoleName, [string]$$clientSP)
{
    echo "Client " $clientSP
    # Get the Service Service Principal
    $serviceSP = Get-AzureADServicePrincipal -Filter "displayName eq '$serviceAppName'"
    echo $serviceSP
    # Find the Service Application Role
    $appRole = $serviceSP.appRoles | Where-Object { $_.DisplayName -eq $serviceAppRoleName }

    # Now apply the permissions to the client
    New-AzureADServiceAppRoleAssignment -ObjectId $clientSP.ObjectId -PrincipalId $clientSP.ObjectId -Id $appRole.Id  -ResourceId $serviceSP.ObjectId
}

Function AssignAppRolesToApp([string] $serviceAppName, [string] $serviceAppRoleName, [string]$clientAppName)
{
    echo "Start"
    # Get the Client Service Principal
    $clientSP = Get-AzureADServicePrincipal -Filter "displayName eq '$clientAppName'"
    echo "Client " $clientSP
    # Get the Service Service Principal
    $serviceSP = Get-AzureADServicePrincipal -Filter "displayName eq '$serviceAppName'"
    echo $serviceSP
    # Find the Service Application Role
    $appRole = $serviceSP.appRoles | Where-Object { $_.DisplayName -eq $serviceAppRoleName }

    # Now apply the permissions to the client
    New-AzureADServiceAppRoleAssignment -ObjectId $clientSP.ObjectId -PrincipalId $clientSP.ObjectId -Id $appRole.Id  -ResourceId $serviceSP.ObjectId
}
