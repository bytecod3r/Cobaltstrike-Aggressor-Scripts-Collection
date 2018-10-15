
function Get-LHSAntiVirusProduct { 
 
[CmdletBinding()] 
[OutputType('PSobject')] 
 
param ( 
    [parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)] 
    [Alias('CN')] 
    [String[]]$ComputerName=$env:computername 
) 
 
BEGIN { 
 
    Set-StrictMode -Version Latest 
 
    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name 
    Write-Verbose -Message "${CmdletName}: Starting Begin Block"  
    Write-Debug -Message "${CmdletName}: Starting Begin Block"   
 
} # end BEGIN 
 
PROCESS { 
    Write-Verbose "${CmdletName}: Starting Process Block" 
    Write-Debug ("PROCESS:`n{0}" -f ($PSBoundParameters | Out-String)) 
     
    ForEach ($Computer in $computerName) { 
        Write-Debug "`$Computer contains $Computer" 
         
        IF (Test-Connection -ComputerName $Computer -count 2 -quiet) {  
            $OSVersion = (Get-WmiObject win32_operatingsystem -computername $Computer).version 
            $OS = $OSVersion.split(".") 
            Write-Debug "`$OS[0]: $($OS[0])" 
 
            IF ($OS[0] -eq "5") { 
                Write-Verbose "Windows 2000, 2003, XP"  
                Try { 
                    $AntiVirusProduct = Get-WmiObject -Namespace root\SecurityCenter -Class AntiVirusProduct  -ComputerName $Computer -ErrorAction Stop 
                } Catch { 
                    Write-Error "$Computer : WMI Error" 
                    Write-Error $_ 
                    Continue 
                }     
                # Output PSCustom Object 
                $AV = $Null 
                $AV = New-Object PSObject -Property @{ 
              
                    ComputerName = $AntiVirusProduct.__Server; 
                    Name = $AntiVirusProduct.displayName; 
                    versionNumber = $AntiVirusProduct.versionNumber; 
                    onAccessScanningEnabled = $AntiVirusProduct.onAccessScanningEnabled; 
                    productUptoDate = $AntiVirusProduct.productUptoDate; 
                 
                } | Select-Object ComputerName,Name,versionNumber,onAccessScanningEnabled,productUptoDate 
                $AV  
 
            } ElseIF ($OS[0] -eq "6") { 
                Write-Verbose "Windows Vista, 7, 2008, 2008R2" 
                Try { 
                    $AntiVirusProduct = Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct  -ComputerName $Computer -ErrorAction Stop 
                } Catch { 
                    Write-Error "$Computer : WMI Error" 
                    Write-Error $_ 
                }                 
   
                # Switch to determine the status of antivirus definitions and real-time protection. 
                # The values in this switch-statement are retrieved from the following website: http://community.kaseya.com/resources/m/knowexch/1020.aspx 
                switch ($AntiVirusProduct.productState) { 
                     "262144" {$defstatus = "Up to date" ;$rtstatus = "Disabled"} 
                     "262160" {$defstatus = "Out of date" ;$rtstatus = "Disabled"} 
                     "266240" {$defstatus = "Up to date" ;$rtstatus = "Enabled"} 
                     "266256" {$defstatus = "Out of date" ;$rtstatus = "Enabled"} 
                     "393216" {$defstatus = "Up to date" ;$rtstatus = "Disabled"} 
                     "393232" {$defstatus = "Out of date" ;$rtstatus = "Disabled"} 
                     "393488" {$defstatus = "Out of date" ;$rtstatus = "Disabled"} 
                     "397312" {$defstatus = "Up to date" ;$rtstatus = "Enabled"} 
                     "397328" {$defstatus = "Out of date" ;$rtstatus = "Enabled"} 
                     "397584" {$defstatus = "Out of date" ;$rtstatus = "Enabled"} 
                     default {$defstatus = "Unknown" ;$rtstatus = "Unknown"} 
                } 
               
                # Output PSCustom Object 
                $AV = $Null 
                $AV = New-Object -TypeName PSobject -Property @{ 
              
                    ComputerName = $AntiVirusProduct.__Server; 
                    Name = $AntiVirusProduct.displayName; 
                    ProductExecutable = $AntiVirusProduct.pathToSignedProductExe; 
                    DefinitionStatus = $defstatus; 
                    RealTimeProtectionStatus = $rtstatus 
                 
                } | Select-Object ComputerName,Name,ProductExecutable,DefinitionStatus,RealTimeProtectionStatus   
                $AV  
 
            } Else { 
                Write-Error "\\$Computer : Unknown OS Version" 
                Exit 
            } # end If $OS 
             
             
        } Else { 
            Write-Warning "\\$computer DO NOT reply to ping" 
        } # end IF (Test-Connection -ComputerName $Computer -count 2 -quiet) 
        
    } # end ForEach ($Computer in $computerName) 
 
} # end PROCESS 
 
END { Write-Verbose "Function Get-LHSAntiVirusProduct finished." }  
} # end function Get-LHSAntiVirusProduct 


