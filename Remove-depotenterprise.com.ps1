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
    $domainstoremove = @()
    $domainstoremove = "depotenterprise.com"

    #Gather data
    $remotemailboxes = @()
    $remotemailboxes = Get-RemoteMailbox -ResultSize Unlimited

    #Remove email addresses for each domain

        $remotemailboxes | ForEach-Object {
            for ($i=0;$i -lt $_.EmailAddresses.Count; $i++)
            {
                $address = $_.EmailAddresses[$i]
                if ($address.IsPrimaryAddress -eq $false -and $address.SmtpAddress -like $domain )
                {
                    Write-host($address.AddressString.ToString() | out-file c:\addressesRemoved.txt -append )
                    $_.EmailAddresses.RemoveAt($i)
                    $i--
                }
            }
            Set-RemoteMailbox -Identity $_.Identity -EmailAddresses $_.EmailAddresses
        }

Stop-Transcript