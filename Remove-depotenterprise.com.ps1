#Remove email addresses from domains that are not supported

    #Put domains to remove in an array

    #Gather data
    $remotemailboxes = @()
    $remotemailboxes = Get-RemoteMailbox -ResultSize Unlimited

    #Remove email addresses for each domain
    foreach ($object in $remotemailboxes) {
        for ($i=0; $i -lt $emailaddresses.count; $i++) {
        
            # Change the domain name below to what you want to remove
            if ($emailaddresses[$i].smtpaddress -like "*depotenterprise.com*") {
     
                # Remove the unwanted email address
                $badaddress = $emailaddresses[$i];
                $emailaddresses = $emailaddresses - $badaddress;
                $object | set-remotemailbox -emailaddresses $emailaddresses;
    }
