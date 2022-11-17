#region TenantSignin 
$connectionDetails = @{
    'TenantID' = 'yourTenantIDGoesHere'
    'ClientID' = 'yourClientIDgoesHere'
}

$MSALToken = Get-MsalToken @connectionDetails
$token = $MSALToken.AccessToken
#endregion

#region SendEmail
function Send-W365WelcomeEmail {
    $parameters = @{
        "apiURL" = "https://graph.microsoft.com/v1.0/me/microsoft.graph.sendMail"
        "method" = "post"
    }

    $body = @"
{
    "message": {
        "subject": "Your Windows 365 CloudPC is ready for you!",
        "body": {
            "contentType": "Text",
            "content": "Good news! Your Windows 365 CloudPC is ready for you!
            `n Start here: https://Windows365.microsoft.com
            `n Your device name is: $($provisioningStatus.managedDeviceName)"
        },
        "toRecipients": [
            {
                "emailAddress": {
                    "address": "$($provisioningStatus.userPrincipalName)"
                }
            }
        ],
        "ccRecipients": [
            {
                "emailAddress": {
                    "address": "nicklas@nicklasahlberg.se"
                }
            }
        ],
    },
    "saveToSentItems": "false"
}
"@
    Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri $parameters.apiURL -Method $parameters.method -Body $body -ContentType 'application/json'
}
#endregion

#region Get data, provisioning
$parameters = @{
    "uri" = "https://graph.microsoft.com/beta/deviceManagement/virtualEndpoint/cloudPCs"
    "method" = "Get"
}
$data = Invoke-RestMethod -Headers @{ Authorization = "Bearer ${token}" } @parameters
$provisioningDevices = $data.value | Where-Object { $_.Status -eq 'provisioning' }

if ($provisioningDevices) {
    Write-Host "A new W365 cloudPC is being provisioned. We will send an email to $($provisioningDevices.userPrincipalName) when it is ready!" -ForegroundColor Magenta
    Do {
        $provisioningStatus = Invoke-RestMethod -Headers @{ Authorization = "Bearer ${token}" } -Uri "https://graph.microsoft.com/beta/deviceManagement/virtualEndpoint/cloudPCs/$($provisioningDevices.id)" -Method $parameters.method
        Write-Host "Current provisioning status is: $($provisioningStatus.status)" -ForegroundColor Yellow
        if ($provisioningStatus.status -eq 'provisioning') { Start-Sleep -Seconds 300 } # Re-check every 5 min if still provisioning
    } Until ($provisioningStatus.status -eq 'Provisioned')
        
    Write-Host "Provisioning is done, sending email!" -ForegroundColor Green
    Send-W365WelcomeEmail # Send email when done
}

else {
    Write-Host "No cloudPCs are currently being provisioned" -ForegroundColor Magenta
}
#endregion