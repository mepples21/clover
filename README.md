# Clover Tenant to Tenant Migration Steps

## Andrew, do this stuff:

1. Identify the OU or OUs the user accounts reside in.

2. Validate that the OUs ONLY contain users who are being migrated.

3. Create a new email address policy (or policies if multiple OUs are in play) that applies to the OU with the relevant mailboxes. This email address policy should set the primary SMTP address for the relevant users to clovertech.com. There should be no secondary addresses, or at least no secondary addresses from the domains that are being removed.

4. Run the following command against each OU:

`Get-RemoteMailbox -Resultsize Unlimited -OnPremisesOrganizationalUnit "CN=Users,DC=example,DC=com" | Set-RemoteMailbox -EmailAddressPolicyEnabled $true`

5. Run the following scripts:

`.\Remove-americancommunications.com.ps1`
`.\Remove-depotenterprise.com.ps1`
`.\Remove-go-ac.com`

6. Perform a delta synchronization on Azure AD Connect.

7. Validate that the relevant domains no longer appear on mailboxes in Exchange Online.

8. Attempt to remove the relevant domains from the source tenant.