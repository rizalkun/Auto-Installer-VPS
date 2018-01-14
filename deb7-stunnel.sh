#!/bin/bash
# Stunnel installer for Debian, Ubuntu and CentOS
# original creator / modifikasi by rzengineer

if [[ "$USER" != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

#memeriksa port yang sedang berjalan

	echo "-------------------- Stunnel Installer untuk debian dan ubuntu -------------------"
	echo ""
	echo "Mohon tunggu sebentar.. sedang memeriksa port yang berjalan"
	sleep 2
	port=2133
if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null ; then
    echo "Telah terdeteksi port $port sedang berjalan/aktif"
	sleep 2
	break
	clear
	echo "mohon untuk menonaktifkan/mematikan/merubah port $port"
	echo "jika sudah silakan mulai install dari awal"
else
    echo ""
fi

#update repository
apt-get update
apt-get install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
client = no

[dropbear]
accept = 2133
connect = 127.0.0.1:443
cert = /etc/stunnel/stunnel.pem
END

#membuat sertifikat
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

#konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

#informasi
clear
	echo "------------------------- Informasi ------------------------"
	echo ""
	echo "Installer ini secara default stunnel berjalan pada port 2133"
	echo ""
	echo "Source by Rzengineer"
	echo "Github https://github.com/rzengineer"
	