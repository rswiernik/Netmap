# Written by Reed Swiernik
# Used to connect to Cylon or Colonial

# ======== PLEASE READ =========
# On most systems powershell will prevent you from
# running unsigned scripts. Since it is unreasonable
# to have a self signed cert and install that on every
# time you come to lab, you'll have to enable this
# option yourself. Simply 

write-host '== DRIVE MOUNT ==

This script will assist in automatically
mapping your network drive to your local machine.

Note: Drive will be mounted at Z:\

'

# Read in the Username and password
# Uncomment the lines in between and
# sub in your credentials is you do
# not want to have to type every time
# you want to connect.
$user = Read-Host 'enter username'
# $user = 'YOUR USERNAME'
$pass = Read-Host 'enter password' -AsSecureString
# $pass = 'YOUR PASSWORD' -AsSecureString

# This is the conveluted securestring to
# string method that powershell uses.
# NOTE : You need to comment out this line
# 		 if you are storing your password
#		 in the script.
$pass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))

# Prompt the use for which share they want to connect to (Default is Cylon)
$prompt = Read-Host "enter host to connect to: [0] Cylon  [1] Colonial (Clyon - default) "
switch ($prompt)
{
	0 {"Mounting drive on Cylon..."; $remote_host = "Cylon"}
	1 {"Mounting drive on Colonial..."; $remote_host = "Colonial"}
	Default {"Mounting drive on Cylon..."; $remote_host = "Cylon"}
}

# Actually run the net use command, clearing the error variable first,
# and making sure to document any errors in the terminal
# "z: \\zarek\$remote_host\$user $pass /USER:istlabs\$user"
net use z: \\zarek\$remote_host\$user $pass /USER:istlabs\$user

Write-Host "Press any key to exit ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")