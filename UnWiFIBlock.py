import os
import shutil

def update_hosts_file():
    hosts_file_path = r"C:\Windows\System32\drivers\etc\hosts"
    backup_hosts_file_path = hosts_file_path + ".bak"
    
    # Content to be written to the hosts file
    new_content = """# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host
#
# localhost name resolution is handled within DNS itself.
#    127.0.0.1       localhost
#    ::1             localhost
"""

    try:
        # Check if the hosts file exists
        if os.path.exists(hosts_file_path):
            # Backup the current hosts file
            shutil.copy(hosts_file_path, backup_hosts_file_path)
            print(f"Backup of the hosts file created at {backup_hosts_file_path}")
            
            # Write the new content to the hosts file
            with open(hosts_file_path, "w") as hosts_file:
                hosts_file.write(new_content)
            print("Hosts file has been updated successfully.")
        else:
            print("Hosts file not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    update_hosts_file()
    input("Press Enter to exit...") 
