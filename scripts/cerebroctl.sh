#!/bin/bash


p_sicherung=/mnt/sicherung
p_public=/mnt/stuff
source_sicherung=//10.1.1.23/sicherung
source_stuff=//10.1.1.23/stuff
smb_options='username=alex,uid=1000,rw'
welcome_string='cerebroctl v0.2'
cerebro_ip='10.1.1.23'
cerebro_mac='d0:50:99:86:59:d7'

cerebro_online() {
  nc -z $cerebro_ip 22
}

obey_orders() {
  echo ''
  echo -e 'I obey your orders master ...'
  echo ''
}

# Hello
if type -P figlet >/dev/null; then
    figlet $welcome_string
else
    echo $welcome_string
fi




echo -e "Check if Mastermind is reachable at $cerebro_ip... "

if nc -z $cerebro_ip 22 2>/dev/null; then
    echo -e "Cerebro is \e[32monline ✓\e[39m\n"
else
    echo -e "Cerebro \e[31moffline ✗\e[39m\n"
fi


echo "Check for mounted shares ..."

echo "* Sicherung:"
echo -e "   local path \t $p_sicherung"
echo -e "   remote path \t $source_sicherung"
if [ -d "/mnt/sicherung/backup" ]
then
    echo -e "   Status \t \e[32mmounted ✓\e[39m"
else
    echo -e "   Status \t \e[31mnot mounted ✗\e[39m\n"
fi

echo "* Stuff:"
echo -e "   local path \t $p_public"
echo -e "   remote path \t $source_stuff"
if [ -d "/mnt/stuff/Movies" ]
then
    echo -e "   Status \t \e[32mmounted ✓\e[39m"
else
    echo -e "   Status \t \e[31mnot mounted ✗\e[39m\n"
fi




while [ true ]
do
  echo ''
  echo -e 'Choose wisely..'
  echo ''
  echo '  1. WAKE UP!!11'
  echo '  2. Ping'
  echo '  3. Funny sounds'
  echo ''

  echo -e "Mount Options:"
  echo "  5. Mount public"
  echo "  6. Mount sicherung"
  echo "  7. Umount public"
  echo "  8.Umount sicherung"
  echo "  12.Exit"

  read option

  case "$option" in

  1) wol $cerebro_mac
  ;;

  2) ping $cerebro_ip
  ;;

  3) ssh alex@$cerebro_ip 'beep -f 165.4064 -l 100 -n -f 130.813 -l 100 -n -f 261.626 -l 100 -n -f 523.251 -l 100 -n -f 1046.50 -l 100 -n -f 2093.00 -l 100 -n -f 4186.01 -l 100'
  ;;

  5) sudo mount -t cifs -o $smb_options $source_stuff $p_public
     obey_orders
    if [ -d "/mnt/stuff/Movies" ]
	then
	    echo -e "mount public to /mnt/stuff \e[32mdone \e[39m "
	else
	    echo -e "mount public to /mnt/stuff \e[31mERROR \e[39m "
    fi
  ;;

  6) sudo mount -t cifs -o $smb_options $source_sicherung $p_sicherung
     echo "#########################"
     echo " Mounted sicherung  "
     echo "#########################"
  ;;

  7) sudo umount $p_public
     echo "#########################"
     echo " Unmounted public   "
     echo "#########################"
  ;;

  8) sudo umount $p_sicherung
     echo "#########################"
     echo " Unmounted sicherung  "
  ;;

  12|q|exit) exit
  ;;

  *) echo "not configured"
  ;;

esac

done

exit $?
