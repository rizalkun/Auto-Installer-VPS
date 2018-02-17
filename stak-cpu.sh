#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

if [[ -e ~/xmr-stak-cpu ]]; then
read -p "Sepertinya xmr-stak-cpu telah terpasang, apakah anda ingin menghapusnya?[y/n] " -e -i n already
	if [ "$already" = "y" ]; then
rm -rf ~/xmr-stak-cpu
	fi
exit
fi

echo "======== Auto install xmr-stak-cpu for ubuntu 16.04 ========="
echo ""
echo "Harap diperhatikan saat mengisi informasi yang dibutuhkan karena proses 1x"
echo "jika terjadi kesalahan silakan jalankan ulang file ini untuk menghapus kemuadian mulai dari awal"
echo ""
read -p "Masukan mata uang (monero or aeon): " -e currency
read -p "Masukan pool address (Example: pool.supportxmr.com:3333): " -e pooladdress
read -p "Masukan wallet address: " -e wallet
read -p "Masukan static diff jika ada jika tidak langsung enter(Example: 3000): " -e diff
read -p "Masukan pool password (biasanya x atau kosong): " -e -i x poolpass
echo ""
echo "Installing ..."
sleep 2
clear
#update repositori
apt-get --assume-yes update

#install package yang dibutuhkan
apt-get --assume-yes install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev screen git nano cpulimit

#setup xmr-stak-cpu mining
git clone https://github.com/fireice-uk/xmr-stak-cpu.git
cd xmr-stak-cpu
cmake .
sleep 1
make install
cd bin/
chmod +x xmr-stak-cpu
sysctl -w vm.nr_hugepages=128


sed -i -e 's/"pool_address" : "pool.usxmrpool.com:3333",/"pool_address" : "'"$pooladdress"'",/g' config.txt

if [ $diff ]; then

sed -i -e 's/"wallet_address" : "",/"wallet_address" : "'"$wallet"."$diff"'",/g' config.txt

else
sed -i -e 's/"wallet_address" : "",/"wallet_address" : "'"$wallet"'",/g' config.txt
fi

sed -i -e 's/"pool_password" : "",/"pool_password" : "'"$poolpass"'",/g' config.txt

sleep 1
clear
echo "tahap installasi selesai, beberapa pertanyaan terakhir"
echo ""
echo "beberapa provider terkadang suspend vps jadi misal core vps ada 6 silakan input 4 (just saran)"
echo ""
read -p "Masukan core vps (1-6): " -e corevps
read -p "Apakah anda ingin langsung menjalankan mining? [y/n]: " -e -i n mining

if [[ "$corevps" = '1' ]]; then
sed -i 's/null,/[ \n { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 }, \n ],/g' config.txt
fi

if [[ "$corevps" = '2' ]]; then
sed -i 's/null,/[ \n { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 1 }, \n ],/g' config.txt
fi

if [[ "$corevps" = '3' ]]; then
sed -i 's/null,/[ \n { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 1 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 2 }, \n ],/g' config.txt
fi

if [[ "$corevps" = '4' ]]; then
sed -i 's/null,/[ \n { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 1 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 2 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 3 }, \n ],/g' config.txt
fi

if [[ "$corevps" = '5' ]]; then
sed -i 's/null,/[ \n { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 1 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 2 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 3 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 4 }, \n ],/g' config.txt
fi

if [[ "$corevps" = '6' ]]; then
sed -i 's/null,/[ \n { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 1 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 2 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 3 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 4 }, \n { "low_power_mode" : false, "no_prefetch" : true, "affine_to_cpu" : 5 }, \n ],/g' config.txt
fi

if [[ "$mining" = 'y' ]]; then
cd ~/xmr-stak-cpu/bin
screen -dmS mining ./xmr-stak-cpu
clear
echo "script mining telah dijalankan"
echo ""
echo "untuk melihat cpu usage gunakan perintah top"
echo "untuk melihat aktifitas mining dan  hashrate gunakan perintah screen -r kemudian tekan h"
echo "untuk menutup ctrl+a+d agar tetap jalan miningnya ^_^"
echo ""
echo "siap grak terima gaji ^_^"

else
clear
echo "script berhasil terinstall untuk menjalankan gunakan perintah screen kemudian ./xmr-stak-cpu"
echo ""
echo "siap grak terima gaji ^_^"
fi
