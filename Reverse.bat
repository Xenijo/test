@echo off
SETLOCAL

:: Path to the hosts file
set HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts

:: Backup the current hosts file
copy "%HOSTS_FILE%" "%HOSTS_FILE%.bak"

:: Set the new content for the hosts file
set "HOSTS_CONTENT=# Copyright (c) 1993-2009 Microsoft Corp.%newline%
#%newline%
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.%newline%
#%newline%
# This file contains the mappings of IP addresses to host names. Each%newline%
# entry should be kept on an individual line. The IP address should%newline%
# be placed in the first column followed by the corresponding host name.%newline%
# The IP address and the host name should be separated by at least one%newline%
# space.%newline%
#%newline%
# Additionally, comments (such as these) may be inserted on individual%newline%
# lines or following the machine name denoted by a '#' symbol.%newline%
#%newline%
# For example:%newline%
#%newline%
#      102.54.94.97     rhino.acme.com          # source server%newline%
#       38.25.63.10     x.acme.com              # x client host%newline%
#%newline%
# localhost name resolution is handled within DNS itself.%newline%
#    127.0.0.1       localhost%newline%
#    ::1             localhost"

:: Write the new content to the hosts file
(
    echo %HOSTS_CONTENT%
) > "%HOSTS_FILE%"

echo Hosts file has been updated successfully.

ENDLOCAL
pause
