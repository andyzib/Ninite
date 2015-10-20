<#
Runs Ninite installer and cleans up unwanted shortcuts.
#>

# Directory where the Ninite-<COMPUTERNAME>.exe and this script live.
$NiniteDir = 'C:\Ninite'

# Setup variables.
$tracking = "$NiniteDir\Ninite-$($env:COMPUTERNAME)-LastRun.txt"
$ninite = "$NiniteDir\Ninite-$($env:COMPUTERNAME).exe"
$deleteThis = $env:Public + '\Desktop\*.lnk'
$DayGap = 7 # Only Run every X days. 

Function Run-Ninite {
    # Run Ninite. 
    Start-Process $ninite -Wait
}

Function Cleanup-Links {
    Remove-Item $deleteThis
}

# If Ninite.exe was run, write results of Get-Date to here. 
Function Post-Run {
    $RunDate = Get-Date
    Set-Content -Path $tracking -Value $RunDate
}

# Should Ninite be run at all? 
Function Pre-Run ($Gap){
    $RunIt = $false
    if(Test-Path -Path $tracking -PathType Leaf) {
        $LastRun = Get-Content -Path $tracking
    }
    else {
        Return # Just do it! 
    }
    # Get the timespan between $LastRun and Now
    $Now = Get-Date
    $timespan = New-TimeSpan -Start $LastRun -End $Now
    if ($timespan.Days -ge $Gap) {
        Return # Run!
    }
    else {
        Exit # End script, don't run Ninite. 
    }
}

Pre-Run $DayGap
Run-Ninite
Cleanup-Links
Post-Run