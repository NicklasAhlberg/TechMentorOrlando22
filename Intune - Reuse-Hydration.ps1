# Get started by providing your Tenant and client ID

$connectionDetails = @{
    'TenantID' = ''
    'ClientID' = ''
}

$MSALToken = Get-MsalToken @connectionDetails -ForceRefresh
$token = $MSALToken.AccessToken

$tenantId = $connectionDetails.tenantid

########################################## Windows 10/11
######################## Endpoint Security
# Microsoft Edge Security Baseline
$body = @"
{
    "displayName": "W10/11 - Microsoft Edge Security Baseline",
    "description": "",
    "settingsDelta": [
        {
            "id": "aa6e4219-055b-47ae-96da-d72718d6a82d",
            "definitionId": "admx--microsoftedge_ExtensionInstallBlocklist",
            "@odata.type": "#microsoft.graph.deviceManagementStringSettingInstance",
            "value": "notConfigured"
        }
    ],
    "roleScopeTagIds": [
        "0"
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri 'https://graph.microsoft.com/beta/deviceManagement/templates/a8d6fa0e-1e66-455b-bb51-8ce0dde1559e/createInstance' -Method 'POST' -Body $body -ContentType 'application/json'

# Windows Security Baseline
$body = @"
{
    "displayName": "W10/11 - Windows Security Baseline",
    "description": "",
    "settingsDelta": [
        {
            "id": "ed70ea1b-7f30-4a78-995e-8b4282d5d11b",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerRemovableDrivePolicy",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"requireEncryptionForWriteAccess\":false}"
        },
        {
            "id": "4e08ec79-eda9-4dfb-abb6-93426d30bae0",
            "definitionId": "deviceConfiguration--windows10GeneralConfiguration_edgeBlockPasswordManager",
            "@odata.type": "#microsoft.graph.deviceManagementBooleanSettingInstance",
            "value": false
        },
        {
            "id": "bd19b9ed-c726-4370-b0a0-6b1c1dce2ba1",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_firewallProfileDomain",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"inboundConnectionsBlocked\":false,\"outboundConnectionsRequired\":false,\"inboundNotificationsBlocked\":false,\"firewallEnabled\":\"notConfigured\"}"
        },
        {
            "id": "1c20003e-2030-4802-a705-70546711a5cb",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_firewallProfilePrivate",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"inboundConnectionsBlocked\":false,\"outboundConnectionsRequired\":false,\"inboundNotificationsBlocked\":false,\"firewallEnabled\":\"notConfigured\"}"
        },
        {
            "id": "9d00ffe1-e3ee-4437-a567-6b456e4153d5",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_firewallProfilePublic",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"inboundConnectionsBlocked\":false,\"outboundConnectionsRequired\":false,\"inboundNotificationsBlocked\":false,\"firewallEnabled\":\"notConfigured\",\"connectionSecurityRulesFromGroupPolicyNotMerged\":false,\"policyRulesFromGroupPolicyNotMerged\":false}"
        },
        {
            "id": "f0f58aeb-27da-40f5-a39a-bf89b7c038e1",
            "definitionId": "deviceConfiguration--windows10GeneralConfiguration_defenderCloudBlockLevel",
            "@odata.type": "#microsoft.graph.deviceManagementStringSettingInstance",
            "value": "high"
        }
    ],
    "roleScopeTagIds": [
        "0"
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri 'https://graph.microsoft.com/beta/deviceManagement/templates/034ccd46-190c-4afc-adf1-ad7cc11262eb/createInstance' -Method 'POST' -Body $body -ContentType 'application/json'

# Windows 365 Security Baseline
$body = @"
{
    "displayName": "W365 - Security baseline",
    "description": "",
    "settingsDelta": [
        {
            "id": "7225dabf-b58e-4a46-a537-37650a3fa460",
            "definitionId": "deviceConfiguration--windows10GeneralConfiguration_appsMicrosoftAccountsOptional",
            "@odata.type": "#microsoft.graph.deviceManagementStringSettingInstance",
            "value": "notConfigured"
        }
    ],
    "roleScopeTagIds": [
        "0"
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri 'https://graph.microsoft.com/beta/deviceManagement/templates/cef15778-c3b9-4d53-a00a-042929f0aad0/createInstance' -Method 'POST' -Body $body -ContentType 'application/json'

# Bitlocker
$body = @"
{
    "displayName": "W10/W11 - Bitlocker",
    "description": "",
    "settingsDelta": [
        {
            "id": "d172cbcc-030f-4b78-af35-c0791f584b1d",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerFixedDrivePolicy",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"encryptionMethod\":null,\"requireEncryptionForWriteAccess\":false,\"recoveryOptions\":null}"
        },
        {
            "id": "ed70ea1b-7f30-4a78-995e-8b4282d5d11b",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerRemovableDrivePolicy",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"encryptionMethod\":null,\"requireEncryptionForWriteAccess\":false,\"blockCrossOrganizationWriteAccess\":false}"
        },
        {
            "id": "7913db8e-8358-458a-b025-d45857dbe16b",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerSystemDrivePolicy",
            "@odata.type": "#microsoft.graph.deviceManagementComplexSettingInstance",
            "valueJson": "{\"startupAuthenticationRequired\":true,\"startupAuthenticationTpmUsage\":\"allowed\",\"startupAuthenticationTpmPinUsage\":\"allowed\",\"startupAuthenticationTpmKeyUsage\":null,\"startupAuthenticationTpmPinAndKeyUsage\":null,\"startupAuthenticationBlockWithoutTpmChip\":true,\"prebootRecoveryEnableMessageAndUrl\":false,\"prebootRecoveryMessage\":null,\"prebootRecoveryUrl\":null,\"recoveryOptions\":null,\"encryptionMethod\":null,\"minimumPinLength\":8}"
        },
        {
            "id": "20ae0332-89a4-4429-aeaa-0af332837aff",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerEncryptDevice",
            "@odata.type": "#microsoft.graph.deviceManagementBooleanSettingInstance",
            "value": true
        },
        {
            "id": "f4e6b4ea-579a-45e0-9aa0-5705ca646b0c",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerDisableWarningForOtherDiskEncryption",
            "@odata.type": "#microsoft.graph.deviceManagementBooleanSettingInstance",
            "value": true
        },
        {
            "id": "5282a74a-1e48-4b34-a4e5-4ab2e0f7049b",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerAllowStandardUserEncryption",
            "@odata.type": "#microsoft.graph.deviceManagementBooleanSettingInstance",
            "value": true
        },
        {
            "id": "9e9775ea-bbf0-47a4-bf8a-c27f63b983ef",
            "definitionId": "deviceConfiguration--windows10EndpointProtectionConfiguration_bitLockerRecoveryPasswordRotation",
            "@odata.type": "#microsoft.graph.deviceManagementStringSettingInstance",
            "value": "enabledForAzureAd"
        }
    ],
    "roleScopeTagIds": [
        "0"
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri 'https://graph.microsoft.com/beta/deviceManagement/templates/d1174162-1dd2-4976-affc-6667049ab0ae/createInstance' -Method 'POST' -Body $body -ContentType 'application/json'

<#
## Microsoft Defender Antivirus
$body = @"
{
    "name": "W10/W11 - Microsoft Defender",
    "description": "",
    "platforms": "windows10",
    "technologies": "mdm,microsoftSense",
    "roleScopeTagIds": [
        "0"
    ],
    "settings": [
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowarchivescanning",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowarchivescanning_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "9ead75d4-6f30-4bc5-8cc5-ab0f999d79f0"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "7c5c9cde-f74d-4d11-904f-de4c27f72d89"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowbehaviormonitoring",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowbehaviormonitoring_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "905921da-95e2-4a10-9e30-fe5540002ce1"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "8eef615a-1aa0-46f4-a25a-12cbe65de5ab"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowcloudprotection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowcloudprotection_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "16fe8afd-67be-4c50-8619-d535451a500c"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "7da139f1-9b7e-407d-853a-c2e5037cdc70"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowfullscanonmappednetworkdrives",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowfullscanonmappednetworkdrives_0",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "3e920b10-3773-4ac5-957e-e5573aec6d04"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "dac47505-f072-48d6-9f23-8d93262d58ed"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowfullscanremovabledrivescanning",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowfullscanremovabledrivescanning_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "366c5727-629b-4a81-b50b-52f90282fa2c"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "fb36e70b-5bc9-488a-a949-8ea3ac1634d5"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowintrusionpreventionsystem",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowintrusionpreventionsystem_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "03738a99-7065-44cb-ba1e-93530ed906a7"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "d47f06e2-5378-43f2-adbc-e924538f1512"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowioavprotection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowioavprotection_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "df4e6cbd-f7ff-41c8-88cd-fa25264a237e"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "fa06231d-aed4-4601-b631-3a37e85b62a0"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowrealtimemonitoring",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowrealtimemonitoring_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "0492c452-1069-4b91-9363-93b8e006ab12"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "f0790e28-9231-4d37-8f44-84bb47ca1b3e"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowscanningnetworkfiles",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowscanningnetworkfiles_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "7b8c858c-a17d-4623-9e20-f34b851670ce"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "f8f28442-0a6b-4b52-b42c-d31d9687c1cf"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowscriptscanning",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowscriptscanning_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "ab9e4320-c953-4067-ac9a-be2becd06b4a"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "000cf176-949c-4c08-a5d4-90ed43718db7"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_allowuseruiaccess",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_allowuseruiaccess_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "4b6c9739-4449-4006-8e5f-3049136470ea"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "0170a900-b0bc-4ccc-b7ce-dda9be49189b"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_checkforsignaturesbeforerunningscan",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_checkforsignaturesbeforerunningscan_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "010779d1-edd4-441d-8034-89ad57a863fe"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "4fea56e3-7bb6-4ad3-88c6-e364dd2f97b9"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_cloudblocklevel",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_cloudblocklevel_2",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "517b4e84-e933-42b9-b92f-00e640b1a82d"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "c7a37009-c16e-4145-84c8-89a8c121fb15"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_cloudextendedtimeout",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 50,
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "608f1561-b603-46bd-bf5f-0b9872002f75"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "f61c2788-14e4-4e80-a5a7-bf2ff5052f63"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_daystoretaincleanedmalware",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 15,
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "214b6feb-c9b2-4a17-af54-d51c805473e4"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "6f6d741c-1186-42e2-b2f2-8582febcfd60"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_enablenetworkprotection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_enablenetworkprotection_2",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "ee58fb51-9ae5-408b-9406-b92b643f388a"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "f53ab20e-8af6-48f5-9fa1-46863e1e517e"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_puaprotection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_puaprotection_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "2d790211-18cb-4e32-b8cc-97407e2c0b45"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "c0135c2a-f802-44f4-9b71-b0b976411b8c"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_realtimescandirection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_realtimescandirection_0",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "6b4e3497-cfbb-4761-a152-de935bbf3f07"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "f5ff00a4-e5c7-44cf-a650-9c7619ff1561"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_scanparameter",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_scanparameter_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "70c8f42e-ee6a-4ef1-a070-cb0e9d472581"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "27ca2652-46f3-4cc7-83f2-bf85ff722d84"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_schedulequickscantime",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 120,
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "5d5c55c8-1a4e-4272-830d-8dc64cd3ac03"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "784a4af1-33fa-45f2-b945-138b7ff3bcb6"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_schedulescanday",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_schedulescanday_0",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "7f4d9dda-6d48-4353-90ca-9fa7164c7215"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "087d3362-7e78-4983-96bc-1f4ea183f0e4"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_schedulescantime",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 240,
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "a204c511-6130-473a-b05f-93bda521aba9"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "66d36baa-74ee-498d-958a-af477008c850"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_signatureupdateinterval",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 8,
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "0af6bbed-a74a-4d08-8587-b16b10b774cb"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "89879f27-6b7d-44d4-a08e-0a0de3e9663d"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_submitsamplesconsent",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_defender_submitsamplesconsent_1",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "826ed4b6-e04f-4975-9d23-6f0904b0d87e"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "bc47ce7d-a251-4cae-a8a2-6e8384904ab7"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction",
                "groupSettingCollectionValue": [
                    {
                        "children": [
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_severethreats",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_severethreats_remove",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_moderateseveritythreats",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_moderateseveritythreats_quarantine",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_lowseveritythreats",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_lowseveritythreats_quarantine",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_highseveritythreats",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_policy_config_defender_threatseveritydefaultaction_highseveritythreats_remove",
                                    "children": []
                                }
                            }
                        ]
                    }
                ],
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "f6394bc5-6486-4728-b510-555f5c161f2b"
                }
            }
        }
    ],
    "templateReference": {
        "templateId": "804339ad-1553-4478-a742-138fb5807418_1"
    }
}
#"@
#Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri $deviceConfigurationParameter.apiURL -Method $deviceConfigurationParameter.method -Body $body -ContentType 'application/json'

# Microsoft Defender Firewall
$body = @"
{
    "name": "W10/W11 - Microsoft Defender Firewall",
    "description": "",
    "platforms": "windows10",
    "technologies": "mdm,microsoftSense",
    "roleScopeTagIds": [
        "0"
    ],
    "settings": [
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "vendor_msft_firewall_mdmstore_domainprofile_enablefirewall",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "vendor_msft_firewall_mdmstore_domainprofile_enablefirewall_true",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "120c5dbe-0c88-46f0-b897-2c996d3e5277"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "7714c373-a19a-4b64-ba6d-2e9db04a7684"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "vendor_msft_firewall_mdmstore_privateprofile_enablefirewall",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "vendor_msft_firewall_mdmstore_privateprofile_enablefirewall_true",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "9d55dfae-d55f-4f2a-af03-9a9524f61e76"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "1c14f914-69bb-49f8-af5b-e29173a6ee95"
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "vendor_msft_firewall_mdmstore_publicprofile_enablefirewall",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "vendor_msft_firewall_mdmstore_publicprofile_enablefirewall_true",
                    "children": [],
                    "settingValueTemplateReference": {
                        "settingValueTemplateId": "c38694c7-51a4-4a35-8f64-b10866a04776"
                    }
                },
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "e2714734-708e-4286-8ae9-d56821e306a3"
                }
            }
        }
    ],
    "templateReference": {
        "templateId": "6078910e-d808-4a9f-a51d-1b8a7bacb7c0_1"
    }
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } -Uri $deviceConfigurationParameter.apiURL -Method $deviceConfigurationParameter.method -Body $body -ContentType 'application/json'
#>

$body = ''
$bodies = @()

######################## Configuration Profiles
$deviceConfigurationPoliciesParameter = @{
    "uri" = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies"
    "method" = "POST"
    "ContentType" = "application/json"
    "body" = ''
}

# Microsoft Defender Firewall rules
$bodies += @"
{
    "name": "W10/W11 - Microsoft Defender Firewall rules",
    "description": "",
    "platforms": "windows10",
    "technologies": "mdm,microsoftSense",
    "roleScopeTagIds": [
        "0"
    ],
    "settings": [
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance",
                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}",
                "groupSettingCollectionValue": [
                    {
                        "children": [
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_enabled",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_enabled_1",
                                    "children": [],
                                    "settingValueTemplateReference": {
                                        "settingValueTemplateId": "7562f243-f281-4f6f-b7e6-ecdb76dc1f1b"
                                    }
                                },
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "4e150e1a-6a10-49b2-a20c-911bf44ea767"
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_name",
                                "simpleSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                    "value": "Allow Microsoft Teams",
                                    "settingValueTemplateReference": {
                                        "settingValueTemplateId": "12994a33-6185-4c3d-a0e8-69316f6293ea"
                                    }
                                },
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "116a696a-3270-493e-9938-c336cf05ea98"
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_interfacetypes",
                                "choiceSettingCollectionValue": [
                                    {
                                        "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                        "value": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_interfacetypes_all",
                                        "children": []
                                    }
                                ],
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "406b5410-e52e-4df3-933f-1ee6e550a5c8"
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_app_filepath",
                                "simpleSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                    "value": "%localappdata%\\microsoft\\teams\\current\\Teams.exe",
                                    "settingValueTemplateReference": {
                                        "settingValueTemplateId": "8c94fefa-67e5-40b5-8d97-6fca4f0c1e98"
                                    }
                                },
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "dd825fa0-961b-4fcc-a6b3-4d2dc0419d4e"
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingCollectionInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_profiles",
                                "choiceSettingCollectionValue": [
                                    {
                                        "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                        "value": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_profiles_2147483647",
                                        "children": []
                                    }
                                ],
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "7dc9b243-cdd2-4359-b5f5-0c48edb8fd34"
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_direction",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_direction_in",
                                    "children": [],
                                    "settingValueTemplateReference": {
                                        "settingValueTemplateId": "8b45e13b-952d-4164-bbac-37f4e97b7985"
                                    }
                                },
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "2114ad3d-157c-47d3-b646-60fcf50949c7"
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_action_type",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "vendor_msft_firewall_mdmstore_firewallrules_{firewallrulename}_action_type_1",
                                    "children": [],
                                    "settingValueTemplateReference": {
                                        "settingValueTemplateId": "419773d8-bffe-4d6f-a91f-286871963f5c"
                                    }
                                },
                                "settingInstanceTemplateReference": {
                                    "settingInstanceTemplateId": "0565cfd1-21c2-4965-b87f-6bde2b8d2cbd"
                                }
                            }
                        ]
                    }
                ],
                "settingInstanceTemplateReference": {
                    "settingInstanceTemplateId": "76c7a8be-67d2-44bf-81a5-38c94926b1a1"
                }
            }
        }
    ],
    "templateReference": {
        "templateId": "19c8aa67-f286-4861-9aa0-f23541d31680_1"
    }
}
"@

# Microsoft 365 Apps - Update
$bodies += @"
{
    "name": "W10/11 - Microsoft 365 Apps - Update",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_office16v5~policy~l_microsoftofficemachine~l_updates_l_preventbinginstall",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_office16v5~policy~l_microsoftofficemachine~l_updates_l_preventbinginstall_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_enableautomaticupdates",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_enableautomaticupdates_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_hideenabledisableupdates",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_hideenabledisableupdates_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_officemgmtcom",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_officemgmtcom_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "pdates~policy~l_microsoftofficemachine~l_updates_l_updatebranch",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "pdates~policy~l_microsoftofficemachine~l_updates_l_updatebranch_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "pdates~policy~l_microsoftofficemachine~l_updates_l_updatebranch_l_updatebranchid",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "pdates~policy~l_microsoftofficemachine~l_updates_l_updatebranch_l_updatebranchid_monthlyenterprise",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_updatedeadline",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_office16v2~policy~l_microsoftofficemachine~l_updates_l_updatedeadline_0",
                    "children": []
                }
            }
        }
    ]
}
"@

# Microsoft 365 Apps - Telemetry
$bodies += @"
{
    "name": "W10/11 - Microsoft 365 Apps - Telemetry",
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
                "settingDefinitionId": "user_vendor_msft_policy_config_office16v2~policy~l_microsoftofficesystem~l_privacy~l_trustcenter_l_sendtelemetry",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "user_vendor_msft_policy_config_office16v2~policy~l_microsoftofficesystem~l_privacy~l_trustcenter_l_sendtelemetry_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "user_vendor_msft_policy_config_office16v2~policy~l_microsoftofficesystem~l_privacy~l_trustcenter_l_sendtelemetry_l_sendtelemetrydropid",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "user_vendor_msft_policy_config_office16v2~policy~l_microsoftofficesystem~l_privacy~l_trustcenter_l_sendtelemetry_l_sendtelemetrydropid_2",
                                "children": []
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Microsoft 365 Apps - OneDrive
$bodies += @"
{
    "name": "W10/11 - Microsoft 365 Apps - OneDrive",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_allowtenantlist",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_allowtenantlist_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_allowtenantlist_allowtenantlistbox",
                            "simpleSettingCollectionValue": [
                                {
                                    "value": "$tenantId",
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                                }
                            ]
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "user_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_enableholdthefile",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "user_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_enableholdthefile_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "user_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_disablefretutorial",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "user_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_disablefretutorial_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv4~policy~onedrivengsc_disablefirstdeletedialog",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv4~policy~onedrivengsc_disablefirstdeletedialog_0",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_blockknownfoldermove",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_blockknownfoldermove_0",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmblockoptout",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmblockoptout_0",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_blockexternalsync",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_blockexternalsync_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "user_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_disablepersonalsync",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "user_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_disablepersonalsync_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv3~policy~onedrivengsc_localmassdeletefiledeletethreshold",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv3~policy~onedrivengsc_localmassdeletefiledeletethreshold_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv3~policy~onedrivengsc_localmassdeletefiledeletethreshold_lmdfiledeletethresholdbox",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 50
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_forcedlocalmassdeletedetection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_forcedlocalmassdeletedetection_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_gposetupdatering",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_gposetupdatering_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_gposetupdatering_gposetupdatering_dropdown",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_gposetupdatering_gposetupdatering_dropdown_5",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmoptinnowizard",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmoptinnowizard_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmoptinnowizard_kfmoptinnowizard_dropdown",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmoptinnowizard_kfmoptinnowizard_dropdown_0",
                                "children": []
                            }
                        },
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_kfmoptinnowizard_kfmoptinnowizard_textbox",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "$tenantId"
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_silentaccountconfig",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_silentaccountconfig_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_filesondemandenabled",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv2~policy~onedrivengsc_filesondemandenabled_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv3~policy~onedrivengsc_warningmindiskspacelimitinmb",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_onedrivengscv3~policy~onedrivengsc_warningmindiskspacelimitinmb_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_onedrivengscv3~policy~onedrivengsc_warningmindiskspacelimitinmb_warningmindiskspacemb",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 2000
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Microsoft Edge - Settings
$bodies += @"
{
    "name": "W10/11 - Microsoft Edge - Settings",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edgev78diff~policy~microsoft_edge_importbrowsersettings",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edgev78diff~policy~microsoft_edge_importbrowsersettings_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge_importfavorites",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge_importfavorites_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge_importsavedpasswords",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge_importsavedpasswords_0",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~googlecast_enablemediarouter",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~googlecast_enablemediarouter_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~googlecast_showcasticonintoolbar",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~googlecast_showcasticonintoolbar_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edgev85diff~policy~microsoft_edge~defaultsearchprovider_newtabpagesearchbox",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edgev85diff~policy~microsoft_edge~defaultsearchprovider_newtabpagesearchbox_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edgev85diff~policy~microsoft_edge~defaultsearchprovider_newtabpagesearchbox_newtabpagesearchbox",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_microsoft_edgev85diff~policy~microsoft_edge~defaultsearchprovider_newtabpagesearchbox_newtabpagesearchbox_bing",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchprovidersearchurl",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchprovidersearchurl_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchprovidersearchurl_defaultsearchprovidersearchurl",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "{google:baseURL}search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:searchClient}{google:sourceId}ie={inputEncoding}"
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchprovidersuggesturl",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchprovidersuggesturl_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchprovidersuggesturl_defaultsearchprovidersuggesturl",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "{google:baseURL}complete/search?output=chrome&q={searchTerms}"
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchproviderenabled",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchproviderenabled_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchproviderimageurlpostparams",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchproviderimageurlpostparams_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~defaultsearchprovider_defaultsearchproviderimageurlpostparams_defaultsearchproviderimageurlpostparams",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "encoded_image={google:imageThumbnail},image_url={google:imageURL},sbisrc={google:imageSearchSource},original_width={google:imageOriginalWidth},original_height={google:imageOriginalHeight}"
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_updateupdates.1~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_allowinstallationmicrosoftedge",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_updateupdates.1~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_allowinstallationmicrosoftedge_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_updateupdates.1~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_allowinstallationmicrosoftedge_part_installpolicy",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_updateupdates.1~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_allowinstallationmicrosoftedge_part_installpolicy_1",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_updatev95~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_targetchannelmicrosoftedge",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_updatev95~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_targetchannelmicrosoftedge_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_updatev95~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_targetchannelmicrosoftedge_part_targetchannel",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_updatev95~policy~cat_edgeupdate~cat_applications~cat_microsoftedge_pol_targetchannelmicrosoftedge_part_targetchannel_stable",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_update~policy~cat_google~cat_googleupdate~cat_applications~cat_microsoftedge_pol_updatepolicymicrosoftedge",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_update~policy~cat_google~cat_googleupdate~cat_applications~cat_microsoftedge_pol_updatepolicymicrosoftedge_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_update~policy~cat_google~cat_googleupdate~cat_applications~cat_microsoftedge_pol_updatepolicymicrosoftedge_part_updatepolicy",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_update~policy~cat_google~cat_googleupdate~cat_applications~cat_microsoftedge_pol_updatepolicymicrosoftedge_part_updatepolicy_1",
                                "children": []
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Microsoft Edge - Sleeping tabs
$bodies += @"
{
    "name": "W10/11 - Microsoft Edge - Sleeping Tabs",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edgev88~policy~microsoft_edge~sleepingtabs_sleepingtabsenabled",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edgev88~policy~microsoft_edge~sleepingtabs_sleepingtabsenabled_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edgev88~policy~microsoft_edge~sleepingtabs_sleepingtabstimeout",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edgev88~policy~microsoft_edge~sleepingtabs_sleepingtabstimeout_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edgev88~policy~microsoft_edge~sleepingtabs_sleepingtabstimeout_sleepingtabstimeout",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_microsoft_edgev88~policy~microsoft_edge~sleepingtabs_sleepingtabstimeout_sleepingtabstimeout_300",
                                "children": []
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Microsoft Edge - Extensions - Block All - Install Outlook
$bodies += @"
{
    "name": "W10/11 - Microsoft Edge - Extensions",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallallowlist",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallallowlist_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallallowlist_extensioninstallallowlistdesc",
                            "simpleSettingCollectionValue": [
                                {
                                    "value": "*",
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                                }
                            ]
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallforcelist",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallforcelist_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallforcelist_extensioninstallforcelistdesc",
                            "simpleSettingCollectionValue": [
                                {
                                    "value": "kkpalkknhlklpbflpcpkepmmbnmfailf",
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                                }
                            ]
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallblocklist",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallblocklist_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_microsoft_edge~policy~microsoft_edge~extensions_extensioninstallblocklist_extensioninstallblocklistdesc",
                            "simpleSettingCollectionValue": [
                                {
                                    "value": "kkpalkknhlklpbflpcpkepmmbnmfailf",
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                                }
                            ]
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Windows - Set Time Zone
$bodies += @"
{
    "name": "W10/11 - Time Zone",
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
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_timelanguagesettings_configuretimezone",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                    "value": "W. Europe Standard Time"
                }
            }
        }
    ]
}
"@

# Windows - Allow workplace - Block
$bodies += @"
{
    "name": "W10/11 - Allow Workplace - Block",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_settings_allowworkplace",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_settings_allowworkplace_0",
                    "children": []
                }
            }
        }
    ]
}
"@

# Windows - News and Interests - Disable
$bodies += @"
{
    "name": "W10/11 - News and Interests - Disable",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_feeds_feedsenabled",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_feeds_feedsenabled_0",
                    "children": []
                }
            }
        }
    ]
}
"@

# Windows - MDM Wins over GP
$bodies += @"
{
    "name": "W10/11 - MDM Wins over GP",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_controlpolicyconflict_mdmwinsovergp",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_controlpolicyconflict_mdmwinsovergp_1",
                    "children": []
                }
            }
        }
    ]
}
"@

# Windows - Power Settings
$bodies += @"
{
    "name": "W10/11 - Power Settings",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_power_allowhibernate",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_allowhibernate_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_energysaverbatterythresholdonbattery",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 15
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_energysaverbatterythresholdpluggedin",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 20
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_selectlidcloseactiononbattery",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_selectlidcloseactiononbattery_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_selectlidcloseactionpluggedin",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_selectlidcloseactionpluggedin_0",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_selectpowerbuttonactiononbattery",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_selectpowerbuttonactiononbattery_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_selectpowerbuttonactionpluggedin",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_selectpowerbuttonactionpluggedin_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_selectsleepbuttonactiononbattery",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_selectsleepbuttonactiononbattery_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_selectsleepbuttonactionpluggedin",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_power_selectsleepbuttonactionpluggedin_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_unattendedsleeptimeoutonbattery",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 300
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_power_unattendedsleeptimeoutpluggedin",
                "simpleSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                    "value": 300
                }
            }
        }
    ]
}
"@

# Windows - Windows Hello for Business
$bodies += @"
{
    "name": "W10/11 - Windows Hello for Business",
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
                "settingDefinitionId": "device_vendor_msft_passportforwork_biometrics_usebiometrics",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_passportforwork_biometrics_usebiometrics_true",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_passportforwork_biometrics_facialfeaturesuseenhancedantispoofing",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_passportforwork_biometrics_facialfeaturesuseenhancedantispoofing_false",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationGroupSettingCollectionInstance",
                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}",
                "groupSettingCollectionValue": [
                    {
                        "children": [
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_digits",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_digits_0",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_enablepinrecovery",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_enablepinrecovery_true",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_expiration",
                                "simpleSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                    "value": 0
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_lowercaseletters",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_lowercaseletters_0",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_maximumpinlength",
                                "simpleSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                    "value": 127
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_minimumpinlength",
                                "simpleSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                    "value": 4
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_history",
                                "simpleSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                    "value": 1
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_requiresecuritydevice",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_requiresecuritydevice_true",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_specialcharacters",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_specialcharacters_0",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_uppercaseletters",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_pincomplexity_uppercaseletters_0",
                                    "children": []
                                }
                            },
                            {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                                "settingDefinitionId": "device_vendor_msft_passportforwork_{tenantid}_policies_usepassportforwork",
                                "choiceSettingValue": {
                                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                    "value": "device_vendor_msft_passportforwork_{tenantid}_policies_usepassportforwork_true",
                                    "children": []
                                }
                            }
                        ]
                    }
                ]
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_passportforwork_securitykey_usesecuritykeyforsignin",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_passportforwork_securitykey_usesecuritykeyforsignin_1",
                    "children": []
                }
            }
        }
    ]
}
"@

# Windows - Widgets - Disable
$bodies += @"
{
    "name": "W10/11 - Widgets - Disable",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_newsandinterests_allownewsandinterests",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_newsandinterests_allownewsandinterests_0",
                    "children": []
                }
            }
        }
    ]
}
"@

# Windows - Remote Desktop Client - Connection URL
$bodies += @"
{
    "name": "W10/11 - Remote Desktop Client - Connection URL",
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
                "settingDefinitionId": "user_vendor_msft_policy_config_admx_terminalserver_ts_radc_defaultconnection",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "user_vendor_msft_policy_config_admx_terminalserver_ts_radc_defaultconnection_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "user_vendor_msft_policy_config_admx_terminalserver_ts_radc_defaultconnection_ts_radc_defaultconnectionurl",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "https://rdweb.wvd.microsoft.com"
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Windows - Camera and Microphone - Allow Edge
$bodies += @"
{
    "name": "W10/11 - Camera and Microphone - Allow Edge",
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
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_privacy_letappsaccesscamera_forceallowtheseapps",
                "simpleSettingCollectionValue": [
                    {
                        "value": "\"C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe\"",
                        "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                    }
                ]
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingCollectionInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_privacy_letappsaccessmicrophone_forceallowtheseapps",
                "simpleSettingCollectionValue": [
                    {
                        "value": "\"C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe\"",
                        "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                    }
                ]
            }
        }
    ]
}
"@

# Windows - Find My Device - Allow
$bodies += @"
{
    "name": "W10/11 - Find My Device - Allow",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_experience_allowfindmydevice",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_experience_allowfindmydevice_1",
                    "children": []
                }
            }
        }
    ]
}
"@

# Windows 11 - Dark mode - User
$bodies += @"
{
    "name": "W11 - Dark mode - User",
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
                "settingDefinitionId": "user_vendor_msft_policy_config_admx_controlpaneldisplay_cpl_personalization_settheme",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "user_vendor_msft_policy_config_admx_controlpaneldisplay_cpl_personalization_settheme_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "user_vendor_msft_policy_config_admx_controlpaneldisplay_cpl_personalization_settheme_themefilename",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "%windir%\\Resources\\Themes\\dark.theme"
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

# Windows 11 - Chat icon - Disable
$bodies += @"
{
    "name": "W11 - Chat icon - Disable",
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
                "settingDefinitionId": "device_vendor_msft_policy_config_experience_configurechaticon",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_experience_configurechaticon_3",
                    "children": []
                }
            }
        }
    ]
}
"@

foreach ($body in $bodies) # foreach body, create a configuration profile (policy)
{
    $deviceConfigurationPoliciesParameter.body = $body
    Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @deviceConfigurationPoliciesParameter
}


$deviceConfigurationParameter = @{
    'uri' = 'https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations'
    'method' = 'post'
    'contentType' = 'application/json'
}

# Windows Update for Business - Retail
$body = @"
{
    "@odata.type": "#microsoft.graph.windowsUpdateForBusinessConfiguration",
    "id": "",
    "displayName": "W10/11 - Windows Update for Business - Retail",
    "description": "",
    "roleScopeTagIds": [],
    "microsoftUpdateServiceAllowed": true,
    "driversExcluded": false,
    "qualityUpdatesDeferralPeriodInDays": 0,
    "featureUpdatesDeferralPeriodInDays": 0,
    "allowWindows11Upgrade": false,
    "qualityUpdatesPaused": false,
    "featureUpdatesPaused": false,
    "businessReadyUpdatesOnly": "userDefined",
    "skipChecksBeforeRestart": false,
    "automaticUpdateMode": "autoInstallAndRebootAtScheduledTime",
    "installationSchedule": {
        "@odata.type": "#microsoft.graph.windowsUpdateScheduledInstall",
        "scheduledInstallDay": "everyday",
        "scheduledInstallTime": "11:00:00.0000000"
    },
    "userPauseAccess": "disabled",
    "userWindowsUpdateScanAccess": "enabled",
    "updateNotificationLevel": "defaultNotifications",
    "updateWeeks": "everyWeek",
    "featureUpdatesRollbackWindowInDays": 10,
    "deadlineForFeatureUpdatesInDays": 2,
    "deadlineForQualityUpdatesInDays": 2,
    "deadlineGracePeriodInDays": 2,
    "postponeRebootUntilAfterDeadline": false,
    "engagedRestartDeadlineInDays": null,
    "engagedRestartSnoozeScheduleInDays": null,
    "engagedRestartTransitionScheduleInDays": null,
    "engagedRestartSnoozeScheduleForFeatureUpdatesInDays": null,
    "engagedRestartTransitionScheduleForFeatureUpdatesInDays": null,
    "autoRestartNotificationDismissal": "notConfigured",
    "scheduleRestartWarningInHours": null,
    "scheduleImminentRestartWarningInMinutes": null
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @deviceConfigurationParameter -Body $body

# Windows - Azure AD Password Reset - Allow
$body = @"
{
    "id": "00000000-0000-0000-0000-000000000000",
    "displayName": "W10/11 - Azure AD Password Reset - Allow",
    "roleScopeTagIds": [
        "0"
    ],
    "@odata.type": "#microsoft.graph.windows10CustomConfiguration",
    "omaSettings": [
        {
            "displayName": "AllowAadPasswordReset",
            "omaUri": "./Vendor/MSFT/Policy/Config/Authentication/AllowAadPasswordReset",
            "@odata.type": "#microsoft.graph.omaSettingInteger",
            "value": 1
        }
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @deviceConfigurationParameter -Body $body
# Windows - Windows Hello for Business - Hybrid Cloud Trust
$body = @"
{
    "id": "00000000-0000-0000-0000-000000000000",
    "displayName": "W10/11 - Windows Hello for Business - Hybrid Cloud Trust",
    "roleScopeTagIds": [
        "0"
    ],
    "@odata.type": "#microsoft.graph.windows10CustomConfiguration",
    "omaSettings": [
        {
            "displayName": "WHFB Hybrid Cloud Trust",
            "description": "Enable Windows Hello for Business cloud trust for sign-in and on-premises SSO",
            "omaUri": "./Device/Vendor/MSFT/PassportForWork/$tenantId/Policies/UseCloudTrustForOnPremAuth",
            "@odata.type": "#microsoft.graph.omaSettingBoolean",
            "value": "true"
        }
    ]
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @deviceConfigurationParameter -Body $body

############## Windows Update for Business
$windowsFeatureUpdateProfilesParameters = @{
    'uri' = 'https://graph.microsoft.com/beta/deviceManagement/windowsFeatureUpdateProfiles'
    'method' = 'post'
    'contentType' = 'application/json'
}
# Windows Update for Business - W11 Feature update - Pilots
$body = @"
{
    "displayName": "W11 - Feature Update - Pilots",
    "description": "",
    "featureUpdateVersion": "Windows 11, version 22H2",
    "roleScopeTagIds": [],
    "rolloutSettings": {
        "offerStartDateTimeInUTC": null,
        "offerEndDateTimeInUTC": null,
        "offerIntervalInDays": null
    }
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @windowsFeatureUpdateProfilesParameters -Body $body

# Windows Update for Business - W11 Feature update
$body = @"
{
    "displayName": "W11 - Feature Update",
    "description": "",
    "featureUpdateVersion": "Windows 11, version 22H2",
    "roleScopeTagIds": [],
    "rolloutSettings": {
        "offerStartDateTimeInUTC": null,
        "offerEndDateTimeInUTC": null,
        "offerIntervalInDays": null
    }
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @windowsFeatureUpdateProfilesParameters -Body $body

############## Compliance Policy
$deviceComplianceParameter = @{
    "uri" = "https://graph.microsoft.com/beta/deviceManagement/deviceCompliancePolicies"
    "method" = "post"
    "contentType" = 'application/json'
}
# Windows - Compliance Policy
$body = @"
{
    "id": "00000000-0000-0000-0000-000000000000",
    "displayName": "W10/11 - Compliance Policy",
    "roleScopeTagIds": [
        "0"
    ],
    "@odata.type": "#microsoft.graph.windows10CompliancePolicy",
    "scheduledActionsForRule": [
        {
            "ruleName": "PasswordRequired",
            "scheduledActionConfigurations": [
                {
                    "actionType": "block",
                    "gracePeriodHours": 360,
                    "notificationTemplateId": "",
                    "notificationMessageCCList": []
                }
            ]
        }
    ],
    "deviceThreatProtectionRequiredSecurityLevel": "medium",
    "passwordRequiredType": "deviceDefault",
    "bitLockerEnabled": true,
    "secureBootEnabled": true,
    "codeIntegrityEnabled": true,
    "osMinimumVersion": "10.0.18363",
    "antivirusRequired": true,
    "activeFirewallRequired": true,
    "antiSpywareRequired": true,
    "defenderEnabled": true,
    "rtpEnabled": true,
    "deviceThreatProtectionEnabled": true
}
"@
Invoke-RestMethod -Headers @{ Authorization = "Bearer $($token)" } @deviceComplianceParameter -Body $body