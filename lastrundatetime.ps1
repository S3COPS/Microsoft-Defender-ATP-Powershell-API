## UPDATE FILE PATH TO SUIT YOUR ENVIRONMENT

$LastRunDateTime = (Get-Date).ToUniversalTime().AddMinutes(0).ToString("o")
Out-File -FilePath "D:\DEFENDER\scripts\LastRunDateTime.txt" -InputObject $LastRunDateTime
return $LastRunDateTime


# $dateTime = (Get-Date).ToUniversalTime().AddMinutes(-5).ToString("o")      

$dateTime = Get-Content -Path "D:\DEFENDER\scripts\LastRunDateTime.txt" -Tail 1
return $dateTime
