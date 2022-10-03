$ErrorActionPreference = "SilentlyContinue"

$__scriptStart=(GET-DATE)

Write-Output "Welcome to Chrome Fixer 0.02"
$oldPath = $(get-location).Path;


###########
#settings
##########
$chrome_path = "$Env:Programfiles\Google\Chrome\Application" #Default Location: "C:\Program Files\Google\Chrome\Application";
$chrome_binary = "chrome.exe";
$chrome_renamed = "__"+$chrome_binary;
$chrome_full_path = $chrome_path+"\"+$chrome_binary;
$chrome_renamed_full_path = $chrome_path+"\"+$chrome_renamed;

$__v1=0
$__v2=0



if((get-childItem $chrome_full_path).Mode.SubString(0,1) -eq "l" )
{
    Write-Output "Nothing to Fix. Exiting."
    Exit
}

#########################################################################################################
#                                                                                                       #
#                                        The steps to fix chrome                                        #
#              -----------------------------------------------------------------------                  #   
#               - Trigger script after chrome is automatically updated.                                 #
#               - check to see if the chrome.exe file has changed by comparing file versions.           #
#               - If the version is different, rename chrome.exe to __chrome.exe.                       #
#               - Then create a symbolic link to the new filename chrome.exe ==> __chrome.exe           #
#                                                                                                       #
#                                               Enjoy.                                                  #
#                                                                                                       #
#########################################################################################################

try{
    $__v1=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($chrome_renamed_full_path).FileVersion
    Write-Output "$chrome_renamed Version $__v1"
}catch{}

try{
    $__v2=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($chrome_full_path).FileVersion
    Write-Output "$chrome_binary Version $__v2"
}catch{}


if($__v1 -ne $__v2 -or $__v1 -eq 0 ){
    #fix it up!
    
    
    #delete old renamed file.
   
    if(test-path $chrome_renamed_full_path){
        remove-item $chrome_renamed_full_path -Force -ErrorAction Continue
        Write-Output "$chrome_renamed removed."
    }
    else{
        Write-Output "$chrome_renamed not found. Skipping."
    }

    
    #rename chrome.exe
    Write-Output "renaming $chrome_binary  ==>  $chrome_renamed"
    Move-Item -Path $chrome_full_path -Destination $chrome_renamed_full_path -Force -ErrorAction Continue
    #create symbolic link
    if(test-path "$chrome_renamed_full_path"){
        Write-Output "creating symbolic link..."
        New-Item -ItemType SymbolicLink -Path "$chrome_full_path" -Target "$chrome_renamed_full_path"  -ErrorAction Continue
    }


    
}else{
    Write-Output "Nothing to Fix."
}

##########
#clean-up
#########
Remove-variable chrome_path 
Remove-variable chrome_binary 
Remove-variable chrome_renamed 
Remove-variable chrome_full_path 
Remove-variable chrome_renamed_full_path 


#Set the path back to the original path just in case.
set-location $oldPath


$__scriptEnd=(GET-DATE)

$__ts = (NEW-TIMESPAN –Start $__scriptStart –End $__scriptEnd).Milliseconds


Write-Output "Chrome fix complete. (elasped: $__ts ms)"

$ErrorActionPreference = "Continue"