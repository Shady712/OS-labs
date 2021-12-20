chcp 437
sc queryex type=service state=all > services_before.txt
::sc stop Dnscache
sleep 1
sc queryex type=service state=all > services_after.txt
fc services_before.txt services_after.txt
::sc start Dnscache