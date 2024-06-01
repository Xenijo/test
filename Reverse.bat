@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Path to the hosts file
set HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts

:: Backup the current hosts file
copy "%HOSTS_FILE%" "%HOSTS_FILE%.bak"

:: Set the new content for the hosts file
(
echo # Copyright (c) 1993-2009 Microsoft Corp.
echo #
echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
echo #
echo # This file contains the mappings of IP addresses to host names. Each
echo # entry should be kept on an individual line. The IP address should
echo # be placed in the first column followed by the corresponding host name.
echo # The IP address and the host name should be separated by at least one
echo # space.
echo #
echo # Additionally, comments (such as these) may be inserted on individual
echo # lines or following the machine name denoted by a '#' symbol.
echo #
echo # For example:
echo #
echo #      102.54.94.97     rhino.acme.com          # source server
echo #       38.25.63.10     x.acme.com              # x client host
echo #
echo # localhost name resolution is handled within DNS itself.
echo #    127.0.0.1       localhost
echo #    ::1             localhost
) > "%HOSTS_FILE%"

echo Hosts file has been updated successfully.

ENDLOCAL
pause
