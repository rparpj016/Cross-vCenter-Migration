<#
.SYNOPSIS

    This is a Module get user credentials

.DESCRIPTION

    This script will perform the following steps:

	  - Get user credentials and log user to one or Multiple Virtual Centers 

	  

.EXAMPLE
   Get-MyCredentials.PS1


.INPUTS
   - You are required to select the Virual Centre One or multiple Virtual Centers 

   - 

   - 

   - 

.OUTPUTS
   
.FUNCTIONALITY
   This script gather credential and Virtual Center information  information .
   
 
     
 
.NOTES
    Version history
    
    Version:        1.0
	Author:         Roshan Joseph
	Creation Date:  15th March 2021
    Purpose/Change: Initial script creation
    Updated         15th Mar [RJ]

    
 
#>

## Requires -Module VMware.VimAutomation.Core



####################################################################################################################################
# Disconnect all Virtual centers
####################################################################################################################################
Clear-Host

Write-Host " YOU WILL NOW BE DISCONNECTED FROM VIRTUAL CENTRE " -ForegroundColor Magenta

try     {
                Disconnect-VIServer -Server $global:DefaultVIServers  -Confirm:$false   -Force -ErrorAction Stop

                Write-Warning -Message " All Virtual Center connections are Disconnected " 
        }


Catch   {
           
            Write-host  "Administrator Message : There are no existing Virtual centre connection we are good to proceed " -ForegroundColor Green

        }



####################################################################################################################################
#                                      END OF SCRIPT
####################################################################################################################################




########################################################################################################################################################
# Connect to Virtual Center ( connect to Source and destination Virtual Centers
# 
########################################################################################################################################################


$cred=get-credential Rabobank\$env:UserName   -Message "Enter Virtual Center Credentials" 

#$user = $env:USERNAME+"$"

  ### Replace location of CSV file with the list of vCenters in your environment 
  $selectedVCnew= Import-Csv -Path '\\XXXXXX\project$\Scripts\ps1\vcenters.csv' `
  |Select-Object VCenters | Out-GridView  -OutputMode Multiple  -Title " SELECT MULTIPLE  VIRTUAL CENTERS FROM THE  LIST BELOW"     # VCenters


Clear-Host

Try     {

           
           ## Connect-VIServer -Server $selectedVCnew.VCenters -Credential (Import-Clixml -Path '\\cphs\my_cloud$\AdminUsers\AdminJosephR\My-Projects\Director-To-Advisor\Cred\AdminJosephr.xml' )  -ErrorAction Stop 
            
            Connect-VIServer -Server $selectedVCnew.VCenters -Credential $Cred -ErrorAction Stop 


            Write-Host " You are now connected to above  Virtual center " -ForegroundColor Blue -BackgroundColor White
         }

Catch    {

            Write-Host " Incorrect User Name or Bad Password : Try Again " -ForegroundColor Red -BackgroundColor Yellow
Break
       }




########################################################################################################################################################
#                                      END OF SCRIPT
#
########################################################################################################################################################


