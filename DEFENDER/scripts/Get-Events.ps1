# Returns Alerts created in since the last timestamp recorded.
# Update paths for your environment

$token = D:\DEFENDER\scripts\Get-Token.ps1
#run the script Get-Token.ps1  - make sure you are running this script from the same folder of Get-Token.ps1


# $dateTime = (Get-Date).ToUniversalTime().AddMinutes(-5).ToString("o")
# to avoid missing events when a scheduled task fails to run, a record of the last run time is stored in a file.
$dateTime = Get-Content -Path "D:\DEFENDER\scripts\LastRunDateTime.txt" -Tail 1

# The URL contains the type of query and the time filter we create above
# Read more about other query options and filters here
$url = "https://api.securitycenter.windows.com/api/alerts?`$filter=alertCreationTime ge $dateTime"

# Set the WebRequest headers
$headers = @{Authorization = "Bearer $token"}

# Send the webrequest and get the results. 
$response = Invoke-WebRequest -Uri $url -Headers $headers -UseBasicParsing


#Extract the alerts from the results. 
$alerts =  ($response | ConvertFrom-Json).value | ConvertTo-Json

#Get string with the execution time. We concatenate that string to the output file to avoid overwrite the file
$dateTimeForFileName = Get-Date -Format o | foreach {$_ -replace ":", "."}   

#save the result as json and / or as csv (delete as appropriate)
$outputJsonPath = "D:\DEFENDER\EVENTS\DefenderATP_Alerts $dateTimeForFileName.json"    
$outputCsvPath = "D:\DEFENDER\EVENTS\DefenderATP_Latest Alerts $dateTimeForFileName.csv"

Out-File -FilePath $outputJsonPath -InputObject $alerts
($alerts | ConvertFrom-Json) | Export-CSV $outputCsvPath -NoTypeInformation

# Write the last run date to a file to avoid dropping events in the event of a cron or other problem
$LastRunDateTime = (Get-Date).ToUniversalTime().AddMinutes(0).ToString("o")
Out-File -FilePath "D:\DEFENDER\scripts\LastRunDateTime.txt" -InputObject $LastRunDateTime
