<#

.SYNOPSIS
Removes email addresses from relevant domains so that the domains may be moved over to the new Office 365 tenant.

.DESCRIPTION


.EXAMPLE


.LINK


.NOTES
Version: 1.0
Date: 03/30/2017
Authors: Michael Epping (mepping@concurrency.com)

Wishlist
    - Better error checking and handling

/#>

#Inputs



#Define functions


#Execute script


#Create Output File
$LogFileName = "Remove-EmailAddresses-$(Get-date -f yyyy-MM-dd-ss).log"
New-Item -Path $LogFileName
Start-Transcript -Path $LogFileName


#Check for Exchange PowerShell
$ExchangePowerShell = Get-Mailbox | Select-Object -First 1
if ($ExchangePowerShell -eq $null) {
    Write-Host "ERROR: This script must be run from the on-premises Exchange Management Shell." -Foreground Red
    Exit(1)
}

#Remove email addresses from domains that are not supported

    #Put domains to remove in an array

    #Gather data
    $remotemailboxes = @()
    $remotemailboxes = Get-RemoteMailbox -ResultSize Unlimited

    #Remove email addresses for each domain
    foreach ($object in $remotemailboxes) {
        for ($i=0; $i -lt $emailaddresses.count; $i++) {
        
            # Change the domain name below to what you want to remove
            if ($emailaddresses[$i].smtpaddress -like "*go-ac.com*") {
     
                # Remove the unwanted email address
                $badaddress = $emailaddresses[$i];
                $emailaddresses = $emailaddresses - $badaddress;
                $object | set-remotemailbox -emailaddresses $emailaddresses;
    }

Stop-Transcript