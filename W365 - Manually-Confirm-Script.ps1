#region WriteHost
# Hash table
$hashtable = @{
'object' = 'Hi everyone! Glad you are all here!'
'foregroundcolor' = 'blue'
}
Write-Host @hashtable

write-Host -object "Hi everyone! Glad you are all here!" -foregroundcolor Blue

#endregion

#region MSALToken
# MSAL token (demo tenant)
$connectionDetails = @{
    'TenantID' = 'yourTenantIDgoesHere'
    'ClientID' = 'yourClientIDGoesHere'
}
$MSALToken = Get-MsalToken @connectionDetails
$token = $MSALToken.AccessToken
#endregion

#region NewPolicy
# New policy
$parameterHashtable = @{
    'uri' = 'https://graph.microsoft.com/beta/deviceManagement/configurationPolicies'
    'method' = 'post'
    'ContentType' = 'application/json'
    'body' = ''
}

$parameterHashtable.body = @"
{
    "name": "W10/11 - allow camera - PowerShell",
    "description": "",
    "platforms": "windows10",
    "technologies": "mdm",
    "roleScopeTagIds": [
        "0"
    ],
    "settings": [
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_camera_allowcamera",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_camera_allowcamera_1",
                    "children": []
                }
            }
        }
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @parameterHashtable
#endregion

# Existing policy