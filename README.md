# Ninite Repository
This is my collection of scripts and other tools for working with Ninite, espically the free version. 

# RunNanite.ps1
Nanite is very useful for keeping a personal computer up to date, but the free version creates shortcuts on the desktop. I despise application shortcuts on the desktop, I use the desktop for works in progress before filing it away. A clean desktop is a product desktop. 

This script is intended to be run as a Schedule Task to periodicly update software installed by Ninite. After Ninite has been run, the script deletes all shortcuts created in the system wide profile. Running the script with elevated privliges or modifying the permissions of $env:PUBLIC\Desktop to allow Users modify (or just Delete if you want to go that far) access is required. 
