## dmv appointment script
## date: 5/18/21

#variables initilized
$curler = ''
$userdate = Read-Host 'Enter current date format: YYYY-MM-DD' #needs error checking in future
$date = '/dates/' + $userdate
$public_ID = '/times;servicePublicId=cf8b8007166313cc8952c9c5a2dfbeed9875666caf43c9acdb675a1cbb16e598;customSlotLength=15'
$webapp_var = 'https://dmvapp.nv.gov/qmaticwebbooking/rest/schedule/'

#object constructor
class DMVobject {
    [string]$location_ID
    [string]$pub_ID
    [string]$webapp
    [string]$appt_date
}

#initilizing new objects
$decatur_dmv = [DMVobject]::new(); $decatur_dmv.location_ID = 'branches/29492a011eb6b5e1df1a1305049bf54615342fd03be179c47ee4d47fe7116409'; $decatur_dmv.pub_ID = $public_ID; $decatur_dmv.webapp = $webapp_var; $decatur_dmv.appt_date = $date;
$flamingo_dmv = [DMVobject]::new(); $flamingo_dmv.location_ID = 'branches/289537bba97afd8bf69f4a3a727f52ad31d0c95ccba0e6d8140c4f1dfc582fca'; $flamingo_dmv.pub_ID = $public_ID; $flamingo_dmv.webapp = $webapp_var; $flamingo_dmv.appt_date = $date;
$henderson_dmv = [DMVobject]::new(); $henderson_dmv.location_ID = 'branches/12b6540fc956ac653afc530cb78d9211be3f32cda84b216b6198d18f72da5dc9'; $henderson_dmv.pub_ID = $public_ID; $henderson_dmv.webapp = $webapp_var; $henderson_dmv.appt_date = $date;
$sahara_dmv = [DMVobject]::new(); $sahara_dmv.location_ID = 'branches/b3a3c4a7d0eab805cbc9bb3ac1419daca1a901995be4fc96085411df29a15099'; $sahara_dmv.pub_ID = $public_ID; $sahara_dmv.webapp = $webapp_var; $sahara_dmv.appt_date = $date;

#manages our custom curl requests
function Curler {
    param (
        [object]$dmv_location
    )
    $dmv_curl = $dmv_location.webapp + $dmv_location.location_ID + $dmv_location.appt_date + $dmv_location.pub_ID
    $curler = Invoke-Webrequest $dmv_curl.toString() | Select-Object -Expand Content
    Start-Sleep 10
}

#will run loop every 10 sec at a different DMV location until $curler is filled with data, which will be an available appt time
while ($curler.length -le 4) {
    
    #location 1 - decatur
    Write-Host 'Checking Decatur DMV...'
    Curler -dmv_location $decatur_dmv

    #location 2 - flamingo
    Write-Host 'Checking Flamingo DMV...'
    Curler -dmv_location $flamingo_dmv

    #location 3 - henderson
    Write-Host 'Checking Henderson DMV...'
    Curler -dmv_location $henderson_dmv
    
    #location 4 - sahara
    Write-Host 'Checking Sahara DMV...'
    Curler -dmv_location $sahara_dmv
    
    #console log current date/time for tracking
    $dt = Get-Date -Format 'MM/dd/yy HH:mm'
    $dt_out = Write-Host 'Current Date/Time: '$dt
} 

#if $curler was filled with data it will alert the user and print out the data (date/time of appt)
if ($curler.length -ge 4) {
    Write-Host "DING DING DING"
    [System.Console]::Beep()
    Write-Host "Available appointment time @ " $curler 
}
