## dmv appointment script
## date: 5/18/21

#init empty variable
$curler = ''

#will run loop every 30 sec until $curler length , which will be an available appt time
while ($curler.length -le 4) {
    
    #location 1 - decatur
    Write-Host 'Checking Decatur DMV...'
    $curler = Invoke-Webrequest 'https://dmvapp.nv.gov/qmaticwebbooking/rest/schedule/branches/29492a011eb6b5e1df1a1305049bf54615342fd03be179c47ee4d47fe7116409/dates/2021-05-18/times;servicePublicId=cf8b8007166313cc8952c9c5a2dfbeed9875666caf43c9acdb675a1cbb16e598;customSlotLength=15' | Select-Object -Expand Content
    Start-Sleep 10

    #location 2 - flamingo
    Write-Host 'Checking Flamingo DMV...'
    $curler = Invoke-Webrequest 'https://dmvapp.nv.gov/qmaticwebbooking/rest/schedule/branches/289537bba97afd8bf69f4a3a727f52ad31d0c95ccba0e6d8140c4f1dfc582fca/dates/2021-05-18/times;servicePublicId=cf8b8007166313cc8952c9c5a2dfbeed9875666caf43c9acdb675a1cbb16e598;customSlotLength=15' | Select-Object -Expand Content
    Start-Sleep 10

    #location 3 - henderson
    Write-Host 'Checking Henderson DMV...'
    $curler = Invoke-Webrequest 'https://dmvapp.nv.gov/qmaticwebbooking/rest/schedule/branches/12b6540fc956ac653afc530cb78d9211be3f32cda84b216b6198d18f72da5dc9/dates/2021-05-18/times;servicePublicId=cf8b8007166313cc8952c9c5a2dfbeed9875666caf43c9acdb675a1cbb16e598;customSlotLength=15' | Select-Object -Expand Content
    Start-Sleep 10
    
    #location 4 - sahara
    Write-Host 'Checking Sahara DMV...'
    $curler = Invoke-Webrequest 'https://dmvapp.nv.gov/qmaticwebbooking/rest/schedule/branches/b3a3c4a7d0eab805cbc9bb3ac1419daca1a901995be4fc96085411df29a15099/dates/2021-05-18/times;servicePublicId=cf8b8007166313cc8952c9c5a2dfbeed9875666caf43c9acdb675a1cbb16e598;customSlotLength=15' | Select-Object -Expand Content
    Start-Sleep 10
} 

#if $curler was filled with data it will alert the user and print out the data (date/time of appt)
if ($curler.length -ge 4) {
    Write-Host "DING DING DING"
    [System.Console]::Beep()
    Write-Host "Available appointment time @ " $curler 
}
