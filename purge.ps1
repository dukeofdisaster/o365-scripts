connect-ippssession
$name = read-host -Prompt "[-] Enter the job name to start....: " 
write-host "[+] You entered: $($name)" 
get-compliancesearch -identity $name | fl runby,contentmatchquery,jobstarttime,jobendtime,status,jobid,items
$results = get-compliancesearch -identity $name | fl successresults | findstr /V /C:"count: 0" 

write-host $results 

write-host "

================================

" 
$purge = read-host -prompt "[-] Do you want to issue a purge for the item/s found above?  y/n" 

If ($purge -eq 'Y') {i
	$confirm = read-host -prompt "[-] Hit enter to confirm purge, else CTRL-C to terminate
	new-compliancesearchaction -searchname $name -purge -purgetype harddelete
} ElseIf ($purge -eq 'y') {
	$confirm = read-host -prompt "[-] Hit enter to confirm purge, else CTRL-C to terminate
	new-compliancesearchaction -searchname $name -purge -purgetype harddelete
}
Else {
	write-host "Restart script to try and execute purge again
}
$terminate = 1
Do
{
	get-compliancesearchaction -identity $name"_Purge"
	$terminate = read-host -prompt "Enter 0 to exit the job; any other button to check job status"
} While ($terminate -ne 0)
