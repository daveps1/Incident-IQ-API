function Get-IIQAssetTag {

$AssetTag = Read-Host -Prompt "Enter Device Asset Tag"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$headers.Add("Authorization", "Bearer api-token-goes-here")
$response = Invoke-RestMethod "https://your-site.incidentiq.com/api/v1.0/assets/assettag/search/$AssetTag" -Method 'GET' -Headers $headers

# Used for testing and finding odata objects
#$response.items | select AssetTag,SerialNumber,Name,Owner,Location,WarrantyExpirationDate
#$response | ConvertTo-Json

if ($response.items.model.modelname -eq 'Lenovo L13 Yoga') { $ModelType = '20R6S0T500' }
if ($response.items.model.modelname -eq 'Lenovo L13 Yoga (Gen 2)') { $ModelType = '20VLS0Y700' }
if ($response.items.model.modelname -eq '13W (AMD R3)') { $ModelType = '82S2' }
if ($response.items.model.modelname -eq '13W (AMD R5)') { $ModelType = '82S2' }


[PSCustomObject][ordered]@{
Owner = $response.items.owner.name
Location = $response.items.location.name
#Name = $response.items.name
ModelName = $response.items.model.modelname
ModelType = $ModelType
SerialNumber = $response.items.serialnumber
AssetTag = $response.items.assettag
WarrantyExpirationDate = $response.items.warrantyexpirationdate
DeviceName = $response.items.CustomFieldValues.value
}

}
Get-IIQAssetTag
