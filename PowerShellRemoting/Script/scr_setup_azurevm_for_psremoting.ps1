
# https://securitytidbits.wordpress.com/2017/05/05/powershell-http-listener/

netsh http show iplist

netsh http delete iplisten ipaddress=127.0.0.1

Set-WSManQuickConfig


<#
Blog on setting up remoting on Azure VM

   https://blogs.technet.microsoft.com/rohit-minni/2017/01/18/remoting-into-azure-arm-virtual-machines-using-powershell/

Code...
   https://gallery.technet.microsoft.com/Remoting-into-Azure-ARM-ebcec7c3
#>

#POWERSHELL TO EXECUTE ON REMOTE SERVER BEGINS HERE  
$DNSName = $env:COMPUTERNAME 
#Ensure PS remoting is enabled, although this is enabled by default for Azure VMs 
Enable-PSRemoting -Force   
#Create rule in Windows Firewall 
New-NetFirewallRule -Name "WinRM HTTPS" -DisplayName "WinRM HTTPS" -Enabled True -Profile "Any" -Action "Allow" -Direction "Inbound" -LocalPort 5986 -Protocol "TCP"    
#Create Self Signed certificate and store thumbprint 
$thumbprint = (New-SelfSignedCertificate -DnsName $DNSName -CertStoreLocation Cert:\LocalMachine\My).Thumbprint   
#Run WinRM configuration on command line. DNS name set to computer hostname, you may wish to use a FQDN 
$cmd = "winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname=""$DNSName""; CertificateThumbprint=""$thumbprint""}" 
cmd.exe /C $cmd   
#POWERSHELL TO EXECUTE ON REMOTE SERVER ENDS HERE

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting?view=powershell-6
# Allow access from outside the subnet... Warning: Not recommended but doing for demo.  Check with you companies security policies.

Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any