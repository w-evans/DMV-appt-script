## dmv appointment script
## date: 5/18/21

#init empty variable for curls
$curler = ''
#host input to manipulate web app data
$userdate = Read-Host 'Enter current date format: YYYY-MM-DD' #needs error checking in future
$date = '/dates/' + $userdate

#breaking down our url into readable chunks
$decatur_ID = 'branches/29492a011eb6b5e1df1a1305049bf54615342fd03be179c47ee4d47fe7116409'
$flamingo_ID = 'branches/289537bba97afd8bf69f4a3a727f52ad31d0c95ccba0e6d8140c4f1dfc582fca'
$henderson_ID = 'branches/12b6540fc956ac653afc530cb78d9211be3f32cda84b216b6198d18f72da5dc9'
$sahara_ID = 'branches/b3a3c4a7d0eab805cbc9bb3ac1419daca1a901995be4fc96085411df29a15099'
$public_ID = '/times;servicePublicId=cf8b8007166313cc8952c9c5a2dfbeed9875666caf43c9acdb675a1cbb16e598;customSlotLength=15'
$webapp = 'https://dmvapp.nv.gov/qmaticwebbooking/rest/schedule/'

#dmv locations
$decatur_curl = $webapp + $decatur_ID + $date + $public_ID
$flamingo_curl = $webapp + $flamingo_ID + $date + $public_ID
$henderson_curl = $webapp + $henderson_ID + $date + $public_ID
$sahara_curl = $webapp + $sahara_ID + $date + $public_ID

#will run loop every 10 sec at a different DMV location until $curler is filled with data, which will be an available appt time
while ($curler.length -le 4) {
    
    #location 1 - decatur
    Write-Host 'Checking Decatur DMV...'
    Invoke-Webrequest $decatur_curl.ToString() | Select-Object -Expand Content
    Start-Sleep 10

    #location 2 - flamingo
    Write-Host 'Checking Flamingo DMV...'
    $curler = Invoke-Webrequest $flamingo_curl.ToString() | Select-Object -Expand Content
    Start-Sleep 10

    #location 3 - henderson
    Write-Host 'Checking Henderson DMV...'
    $curler = Invoke-Webrequest $henderson_curl.ToString() | Select-Object -Expand Content
    Start-Sleep 10
    
    #location 4 - sahara
    Write-Host 'Checking Sahara DMV...'
    $curler = Invoke-Webrequest $sahara_curl.ToString() | Select-Object -Expand Content
    Start-Sleep 10
} 

#if $curler was filled with data it will alert the user and print out the data (date/time of appt)
if ($curler.length -ge 4) {
    Write-Host "DING DING DING"
    [System.Console]::Beep()
    Write-Host "Available appointment time @ " $curler 
}
