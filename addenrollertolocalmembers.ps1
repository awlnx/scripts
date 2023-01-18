$ErrorActionPreference = "stop"
try {
    $EnrollerSID = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\Autopilot\EnrollmentStatusTracking\" | Where-Object { $_.PSChildName -match ".*\S-1-[0-59]" } | Select-Object -ExpandProperty PSChildName
    $EnrollerSID = New-Object System.Security.Principal.SecurityIdentifier($EnrollerSID)
    $UserName = $EnrollerSID.Translate([System.Security.Principal.NTAccount]).Value
    Add-LocalGroupMember -Group "Network Configuration Operators" -Member $UserName
}
Catch [Microsoft.PowerShell.Commands.MemberExistsException] {
    Write-Host "Member is already in Group!"
}