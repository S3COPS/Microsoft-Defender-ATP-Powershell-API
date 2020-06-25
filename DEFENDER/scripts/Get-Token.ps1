# That code gets the App Context Token and save it to a file named "Latest-token.txt" under the current directory
# UPDATE ANY PATHS TO MATCH YOUR ENVIRONMENT

Get-Content "D:\DEFENDER\scripts\client.properties" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }
$tenantId = $h.tenantId
$appId = $h.appId
$appSecret = $h.appSecret

$resourceAppIdUri = 'https://api.securitycenter.windows.com'
$oAuthUri = "https://login.windows.net/$TenantId/oauth2/token"

$authBody = [Ordered] @{
    resource = "$resourceAppIdUri"
    client_id = "$appId"
    client_secret = "$appSecret"
    grant_type = 'client_credentials'
}

$authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
$token = $authResponse.access_token
Out-File -FilePath "D:\DEFENDER\scripts\Latest-token.txt" -InputObject $token
return $token
