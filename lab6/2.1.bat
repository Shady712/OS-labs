forfiles /P C:\Windows /M *.* /C "CMD /C if @fsize gtr 2097152 copy @PATH c:\Users\frost\ITMO-OS\OS-labs\lab6\shared /z /y"