# Microsoft-Defender-ATP-Powershell-API
## References
Based on the code samples https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/run-advanced-query-sample-powershell

## Pre-Requisites
Defender ATP API Setup (Application Context) as per:
* https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/apis-intro 
* https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/exposed-apis-create-app-webapp

## Purpose
To use native PowerShell tools to connect to Microsoft Defender ATP API, retrieve a token, download events since the last connection for SIEM or other tooling ingestion

## Output
The script outputs files as JSON and / or CSV for further ingestion

## Usage
Schedule a regular task to run (every 5 minutes?)
* Action = Start a program
* Program / Script = Powershell.exe
* Add arguments = -ExecutionPolicy Bypass "<PATH_TO_FILE>\Get-Events.ps1"
* Start in = <PATH_TO_FILE>
