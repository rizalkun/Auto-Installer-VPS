# Auto-Installer-VPS
Melakukan install service seperti SSH,VPN,Dropbear dll dengan script auto installer yang sangat mudah.<br>
Caranya:<br>
1. Login VPS<br>
2. # wget https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/debian7-32.sh <br>
3. # chmod +x debian7-32.sh <br>
4. # ./debian7-32.sh <br>
5. tunggu sampai proses selesai > reboot vps anda<br>
<br>
# Service
OpenVPN  : TCP 1194 <br>
OpenSSH  : 22, 143<br>
Dropbear : 109, 110, 443<br>
Squid3   : 8080 (limit to IP SSH)<br>
badvpn   : badvpn-udpgw port 7300 <br>
Webmin <br>
VNSTAT <br>
MRTG <br>
more cek log install <br>
<br>
# OCS PANEL
Melakukan Install Web Panel SSH Reseller Secara otomatis.<br>
Caranya:<br>
1. Login VPS<br>
2. # wget https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/ocs_panel/ocs-deb7-32.sh <br>
3. # chmod +x ocs-deb7-32.sh
4. # ./ocs-deb7-32.sh
5. Ikuti proses sampai selesai <br>

More Info Cek Blog : www.mastahit.com

@sonedinjector
