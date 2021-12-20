chcp 437
net share temp=c:\Users\frost\ITMO-OS\OS-labs\lab6\shared
::schtasks /create /tn "lab6_copy" /tr c:\Users\frost\ITMO-OS\OS-labse\lab6\2.1.bat /sc minute /mo 1
::schtasks /delete /tn lab6_copy
fc /b c:\Users\frost\ITMO-OS\OS-labs\lab6\shared\explorer.exe c:\Windows\explorer.exe