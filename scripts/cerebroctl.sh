#!/bin/bash

p_sicherung=/mnt/sicherung
p_public=/mnt/stuff
source_sicherung=//10.1.1.23/sicherung
source_stuff=//10.1.1.23/stuff
smb_options='username=alex,uid=1000,rw'
welcome_string='cerebroctl v1.0'
cerebro_ip='10.1.1.23'
cerebro_mac='d0:50:99:86:59:d7'


# Define functions
obey_orders() {
  echo ''
  echo 'I obey your orders master ...'
  echo ''
}

cerebro_online() {
  nc -z $cerebro_ip 22
}

sicherung_is_mounted() {
  mount | grep /mnt/sicherung
}

stuff_is_mounted() {
   mount | grep /mnt/stuff
}

print_status(){  
echo -e "Check if Mastermind is reachable at $cerebro_ip... "

if cerebro_online >/dev/null; then
    echo -e "Cerebro is \e[32monline ✓\e[39m\n"
else
    echo -e "Cerebro \e[31moffline ✗\e[39m\n"
fi

echo "Check for mounted shares ..."

echo "* Stuff:"
echo -e "   local path \t $p_public"
echo -e "   remote path \t $source_stuff"
if stuff_is_mounted > /dev/null; then
    echo -e "   Status \t \e[32mmounted ✓\e[39m"
    # df -H | grep //10.1.1.23/stuff | awk '{ print $3"/"$2 " ("$5")"}'
else
    echo -e "   Status \t \e[31mnot mounted ✗\e[39m\n"
fi

echo "* Sicherung:"
echo -e "   local path \t $p_sicherung"
echo -e "   remote path \t $source_sicherung"
if sicherung_is_mounted > /dev/null; then
    echo -e "   Status \t \e[32mmounted ✓\e[39m"
else
    echo -e "   Status \t \e[31mnot mounted ✗\e[39m\n"
fi
}


# Start of the script

# Say Hello
if type -P figlet > /dev/null; then
    figlet $welcome_string
else
    echo $welcome_string
    echo 'Note: Install figlet you lazy ass!' 
fi

# Check the status
print_status


# Main menu
while [ true ]
do
  echo ''
  echo 'Available commands:'
  echo ''
  echo '  1.  WAKE UP!!11'
  echo '  2.  Ping'
  echo '  3.  Funny sounds'
  echo ''

  echo "Mount Options:"
  echo "  5.  Mount public to stuff"
  echo "  6.  Mount sicherung"
  echo "  7.  Umount public"
  echo "  8.  Umount sicherung"
  echo "  9.  Status"
  echo "  12. Exit"

  read option

  case "$option" in

  1) wol $cerebro_mac
  ;;

  2) ping -c 3 $cerebro_ip
  ;;

  3) ssh alex@$cerebro_ip 'beep -f 165.4064 -l 100 -n -f 130.813 -l 100 -n -f 261.626 -l 100 -n -f 523.251 -l 100 -n -f 1046.50 -l 100 -n -f 2093.00 -l 100 -n -f 4186.01 -l 100'
  ;;

  5) if stuff_is_mounted > /dev/null; then
      echo ''
      echo 'Stuff is already mounted' 
      echo 'Nothing to do ...'    
    else 
       if sudo mount -t cifs -o $smb_options $source_stuff $p_public ; then
        echo -e "mount public to /mnt/stuff \e[32mdone \e[39m "
      else
        echo -e "mount public to /mnt/stuff \e[31mERROR \e[39m "
      fi
    fi
  ;;

  6) if sicherung_is_mounted > /dev/null; then
      echo ''
      echo 'Sicherung already mounted' 
      echo 'Nothing to do ...'    
    else 
       if sudo mount -t cifs -o $smb_options $source_sicherung $p_sicherung ; then
        echo -e "Mount Sicherung to /mnt/sicherung \e[32mdone \e[39m "
      else
        echo -e "Mount Sicherung to /mnt/sicherung \e[31mERROR \e[39m "
      fi
    fi
  ;;

  7) if sudo umount $p_public ; then
      echo -e 'Unmount public \e[32mOK ✓\e[39m'
    else 
      echo -e 'Unmount public \e[31mERROR\e[39m'
    fi
  ;;

  8) if sudo umount $p_sicherung ; then
      echo -e 'Unmount sicherung \e[32mOK ✓\e[39m'
    else 
      echo -e 'Unmount sicherung \e[31mERROR\e[39m'
    fi
  ;; 

  9) print_status
  ;; 

  12|q|exit) echo 'Goodbye ...'  
  exit
  ;;

  *) echo "not configured"
  ;;

esac

done

exit $?
