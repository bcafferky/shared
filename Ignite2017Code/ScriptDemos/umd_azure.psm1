<#
      Module:   umd_azure 

      Purpose:  Functions for Azure administration.

      Author:   Bryan Cafferky   2017-04-10

#>

function New-udfCompleteVMDemo 
{ 
<#
        .DESCRIPTION
        Creates a complete Azure VM with all the required resources. Use the Verbose
        parameter to get a lot of information back as the function runs.

        .PARAMETER resourceprefix
        Specifies the prefix to use for all resource names including the VM.
        
        .PARAMETER publisher
        The vendor usually with the product appended like MicrosoftSQLServer.
        
        .PARAMETER offer
        Specific product.

        .PARAMETER skus
        Detail like version.

        .EXAMPLE
        New-udfCompleteVMDemo -resourceprefix "Demo1"

        .NOTES
        Supports PowerShell common parameters such as Verbose. 
#>

 [CmdletBinding()]
        param (
              [string]$resourceprefix,
              [string]$publisher,
              [string]$offer,
              [string]$skus
          )
     <#  
          Create Resources in Azure
     
          https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-ps-sql-create
     
     #>
     
     # Log into the account.  Note:  Alias for Add-AzureRmAccount.
     Login-AzureRmAccount  # Note:  Login properties returned to console.
     
     # Create a credential for the local admin account...
     $cred = Get-Credential -Message "Enter a username and password for the virtual machine."
     
     <# Resource groups let us group resources together which
        reduces the imoact of Azure system maintenance, i.e. will leave one
        VM up while it does maintenance on another.
     #>
     
     # Create Variables for common values.  Note:  single quotes around strings do not expand embedded variables.
     $resourceGroup = $resourceprefix + "RG"
     $location = "EastUS"
     $vmName = $resourceprefix + "VM"

     Write-Verbose "Virtual Machine Being Created..."
     Write-Verbose "--------------------------------"
     Write-Verbose " "
     Write-Verbose "Resource Group Name: $resourceGroup"
     Write-Verbose "Location: $location"
     Write-Verbose "Virtual Machine Name: $vmName"
     Write-Verbose "____________________"
     Write-Verbose "Image Details"
     Write-Verbose "____________________"
     Write-Verbose "Publisher: $publisher"
     Write-Verbose "Offer: $offer"
     Write-Verbose "Skus: $skus"
     
     # Create a new resource group as a container for the resources we're creating.
     New-AzureRmResourceGroup -Name $resourceGroup -Location 'East US 2' -Verbose
     
     <#   
         Create resources first and then the new VM    
     #>
     
     # Create a subnet configuration - Note: Parenthesis below are critical! Using Verbose common parameter.
     $subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name ($resourceprefix + "Subnet1") -AddressPrefix 192.168.1.0/24 -Verbose
     Write-Verbose $subnetConfig
     
     # Create a virtual network
     $vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
       -Name ($resourceprefix + "VNET1") -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig -Verbose
     
     # Create a public IP address and specify a DNS name
     
     #  Let's get a somewhat random IPAddress Name...
     $publicip = $resourceprefix +'publicdns' + $(Get-Random)
     
     $publicIp = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Location $location `
       -Name $publicip -AllocationMethod Static -IdleTimeoutInMinutes 4 -Verbose
     $publicIp | Select-Object Name,IpAddress
     
     # Create an inbound network security group rule for port 3389
     $nsgRuleRDP = New-AzureRmNetworkSecurityRuleConfig -Name ($resourceprefix + 'NetworkSecurityGroupRuleRDP')  -Protocol Tcp `
       -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
       -DestinationPortRange 3389 -Access Allow -Verbose
     Write-Verbose $nsgRuleRDP
     
     # Create a network security group
     $nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location `
       -Name ($resourceprefix + 'NetworkSecurityGroup1') -SecurityRules $nsgRuleRDP -Verbose
     
     # Create a virtual network card and associate with public IP address and NSG
     $nic = New-AzureRmNetworkInterface -Name ($resourceprefix + 'Nic1') -ResourceGroupName $resourceGroup -Location $location `
       -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id -NetworkSecurityGroupId $nsg.Id -Verbose
     
     Write-Verbose "Creating VM Configuration Object..."
     # Create a virtual machine configuration
     $vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize Standard_D1 |
       Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred |
       Set-AzureRmVMSourceImage -PublisherName $publisher -Offer $offer -Skus $skus -Version latest |
       Add-AzureRmVMNetworkInterface -Id $nic.Id -Verbose
     
     Write-Verbose $vmConfig  # Display VM Config Info...
     
     ## Create the VM in Azure
     New-AzureRmVM  -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig -Verbose
     
     Get-AzureRmVM -Name $vmName -ResourceGroupName $resourceGroup
}

# Example Call:
#   New-udfCompleteVMDemo "demo5" -publisher 'MicrosoftSQLServer' -offer 'SQL2016SP1-WS2016' -skus 'SQLDev'
#   Get-Help New-udfCompleteVMDemo

######################################################
#          Create New VM in Batch Mode               #
######################################################
function New-udfCompleteVMinBatch
{ 
[CmdletBinding()]
        param (
              [string]$resourceprefix,
              [string]$publisher,
              [string]$offer,
              [string]$skus
          )
     <#  
          Create Resources in Azure
     
          https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-ps-sql-create
     
     #>
       
     # Create a credential for the local admin account...
     # $cred = Get-Credential -Message "Enter a username and password for the virtual machine."
     
     $secpasswd = ConvertTo-SecureString "Something123?" -AsPlainText -Force
     $cred = New-Object System.Management.Automation.PSCredential ("bcafferky", $secpasswd)

     <# Resource groups let us group resources together which
        reduces the imoact of Azure system maintenance, i.e. will leave one
        VM up while it does maintenance on another.
     #>
     
     # Create Variables for common values.  Note:  single quotes around strings do not expand embedded variables.
     $resourceGroup = $resourceprefix + "RG"
     $location = "EastUS"
     $vmName = $resourceprefix + "VM"

     Write-Verbose "Virtual Machine Being Created..."
     Write-Verbose "--------------------------------"
     Write-Verbose " "
     Write-Verbose "Resource Group Name: $resourceGroup"
     Write-Verbose "Location: $location"
     Write-Verbose "Virtual Machine Name: $vmName"
     Write-Verbose "____________________"
     Write-Verbose "Image Details"
     Write-Verbose "____________________"
     Write-Verbose "Publisher: $publisher"
     Write-Verbose "Offer: $offer"
     Write-Verbose "Skus: $skus"
     
     # Create a new resource group as a container for the resources we're creating.
     New-AzureRmResourceGroup -Name $resourceGroup -Location 'East US 2' -Verbose
     
     <#   
         Create resources first and then the new VM    
     #>
     
     # Create a subnet configuration - Note: Parenthesis below are critical! Using Verbose common parameter.
     $subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name ($resourceprefix + "Subnet1") -AddressPrefix 192.168.1.0/24 -Verbose
     Write-Verbose $subnetConfig
     
     # Create a virtual network
     $vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location `
       -Name ($resourceprefix + "VNET1") -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig -Verbose
     
     # Create a public IP address and specify a DNS name
     
     #  Let's get a somewhat random IPAddress Name...
     $publicip = $resourceprefix +'publicdns' + $(Get-Random)
     
     $publicIp = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Location $location `
       -Name $publicip -AllocationMethod Static -IdleTimeoutInMinutes 4 -Verbose
     $publicIp | Select-Object Name,IpAddress
     
     # Create an inbound network security group rule for port 3389
     $nsgRuleRDP = New-AzureRmNetworkSecurityRuleConfig -Name ($resourceprefix + 'NetworkSecurityGroupRuleRDP')  -Protocol Tcp `
       -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
       -DestinationPortRange 3389 -Access Allow -Verbose
     Write-Verbose $nsgRuleRDP
     
     # Create a network security group
     $nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location `
       -Name ($resourceprefix + 'NetworkSecurityGroup1') -SecurityRules $nsgRuleRDP -Verbose
     
     # Create a virtual network card and associate with public IP address and NSG
     $nic = New-AzureRmNetworkInterface -Name ($resourceprefix + 'Nic1') -ResourceGroupName $resourceGroup -Location $location `
       -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id -NetworkSecurityGroupId $nsg.Id -Verbose
     
     Write-Verbose "Creating VM Configuration Object..."
     # Create a virtual machine configuration
     $vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize Standard_D1 |
       Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred |
       Set-AzureRmVMSourceImage -PublisherName $publisher -Offer $offer -Skus $skus -Version latest |
       Add-AzureRmVMNetworkInterface -Id $nic.Id -Verbose
     
     Write-Verbose $vmConfig  # Display VM Config Info...
     
     ## Create the VM in Azure
     New-AzureRmVM  -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig -Verbose
     
     Get-AzureRmVM -Name $vmName -ResourceGroupName $resourceGroup
}

function Save-UdfEncryptedCredential {
[CmdletBinding()] param ()

   $pw = read-host -Prompt "Enter the password:" -assecurestring 
   
   $pw | convertfrom-securestring | out-file (Invoke-UdfCommonDialogSaveFile  $PSScriptRoot )

}
# Example Call:
#   Save-UdfEncryptedCredential


# Purpose:  Save a file to the folder specified by the user.
Function Invoke-UdfCommonDialogSaveFile($initialDirectory)
{  
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} 

<#

Creating an application service principal...

https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authenticate-service-principal


Find in Portal under Active Directory/App Registrations.

Note:  To use a profile to log in see the link below.

   https://ronbokleman.wordpress.com/2016/04/05/azure-powershell-arm-profile-3/

#>

function New-udfAzureServicePrincipal   
{
   [CmdletBinding()] 
   Param (
   
    # Use to set scope to resource group. If no value is provided, scope is set to subscription.
    [Parameter(Mandatory=$false)]
    [String] $ResourceGroup,
   
    # Use to set subscription. If no value is provided, default subscription is used. 
    [Parameter(Mandatory=$false)]
    [String] $SubscriptionId,
   
    [Parameter(Mandatory=$true)]
    [String] $ApplicationDisplayName,

    [Parameter(Mandatory=$true)]
    [String] $Password

    )

    # Add-AzureRmAccount

    # Save-UdfEncryptedCredentialToFile  # Get the Service Principal Password

    $credspath = $PSScriptRoot + "\"

    # Save the password...
 
   #   $pw = read-host -Prompt "Enter the password:" -assecurestring 
    $pw = ConvertTo-SecureString $Password -AsPlainText -Force 
    $pw | convertfrom-securestring | out-file ($credspath + $ApplicationDisplayName + "_pw.txt"  )

    Import-Module AzureRM.Resources
    
    if ($SubscriptionId -eq "") 
    {
       $SubscriptionId = (Get-AzureRmContext).Subscription.SubscriptionId
    }
    else
    {
       Set-AzureRmContext -SubscriptionId $SubscriptionId
    }
    
    if ($ResourceGroup -eq "")
    {
       $Scope = "/subscriptions/" + $SubscriptionId
    }
    else
    {
       $Scope = (Get-AzureRmResourceGroup -Name $ResourceGroup -ErrorAction Stop).ResourceId
    }
    
    # Create Active Directory application with password
    $Application = New-AzureRmADApplication -DisplayName $ApplicationDisplayName -HomePage ("http://" + $ApplicationDisplayName) -IdentifierUris ("http://" + $ApplicationDisplayName) -Password $Password 
    
    # Create Service Principal for the AD app
    $ServicePrincipal = New-AzureRMADServicePrincipal -ApplicationId $Application.ApplicationId 
    Get-AzureRmADServicePrincipal -ObjectId $ServicePrincipal.Id 
    
    $NewRole = $null
    $Retries = 0;
    While ($NewRole -eq $null -and $Retries -le 6)
    {
       # Sleep here for a few seconds to allow the service principal application to become active (should only take a couple of seconds normally)
       Sleep 20 
       New-AzureRMRoleAssignment -RoleDefinitionName Owner -ServicePrincipalName $Application.ApplicationId -Scope $Scope | Write-Verbose -ErrorAction SilentlyContinue
       $NewRole = Get-AzureRMRoleAssignment -ServicePrincipalName $Application.ApplicationId -ErrorAction SilentlyContinue
       $Retries++;
    }

    <#
        Save the properties needed to connect using the ServicePrinipal...

        ApplicationID
        TenantID

        Note:  Password was already saved.

    #>

    
    # Save the ApplicationID.  Note:  PowerShell bug gives dup rows back.
    $appid = $Application | Select-Object -ExpandProperty ApplicationID -Unique      
    $appid.GUID | out-file ($credspath + $ApplicationDisplayName + "_appid.txt")

    $tenantid = (Get-AzureRmSubscription -SubscriptionID $SubscriptionId).TenantId

    $tenantid | out-file ($credspath + $ApplicationDisplayName + "_tenantid.txt")


    Return $Application

 }

function New-udfAzureRmVMLoginServicePrincipal   
{
   [CmdletBinding()] 
   Param (
   
    # What is the app name?
    [Parameter(Mandatory=$true)]
    [String] $ApplicationDisplayName
          )

#    Add-AzureRmAccount -Credential $creds -ServicePrincipal -TenantId $tenantid
    $credpath = $PSScriptRoot + "\"

    Write-Verbose "Credential Path: $credpath"

    $AppID = Get-Content (Join-Path -Path $credpath -ChildPath ($ApplicationDisplayName + "_appid.txt")) 
    $pw = Get-Content (Join-Path -Path $credpath -ChildPath ($ApplicationDisplayName + "_pw.txt")) | convertto-securestring
    $tenantid = Get-Content (Join-Path -Path $credpath -ChildPath ($ApplicationDisplayName + "_tenantid.txt"))
    
    Write-Verbose $AppID
    Write-Verbose $pw
    Write-Verbose $tenantid

    Write-Verbose "Creating the credential object..."
    $credential = New-Object System.Management.Automation.PSCredential (“$AppID”, $pw)

    Write-Verbose "Logging on to Azure..."
    Add-AzureRmAccount -Credential $credential -ServicePrincipal -TenantId $tenantid

}