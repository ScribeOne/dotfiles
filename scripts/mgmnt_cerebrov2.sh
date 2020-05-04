
#!/bin/bash 
#

p_sicherung=/media/sicherung
p_public=/media/stuff
smb_options='username=alex,uid=1000,rw'

while [ true ]
do

echo "v1.RemoteControlCerebro\n"

echo "1.Timer"
echo "2.Shutdown Now" 
echo "3.Suspend - Ruhemodus" 
echo "4.Hibernate - Energie sparen"
echo "5.WOL"
echo "6.Funny Sounds"
echo "11. Ping "
echo " "
echo "Mount Options: "
echo "7.Mount public"
echo "8.Mount sicherung"
echo "9.Umount public"
echo "10.Umount sicherung"
echo " "
echo "12. Exit"

read option

case "$option" in 
	1) echo "Set Minutes"
	   read minutes 
           ssh -t alex@192.168.178.13 'sudo sbin/shutdown -h $minutes'
	;;	

	2) echo "Cerebro shutdown"
	   ssh alex@192.168.178.13 'sudo /sbin/shutdown -h now'
	;;
	3) echo "Cerebro suspend"
 	ssh alex@192.168.178.13 'sudo /usr/sbin/pm-suspend'
	;;
	
	4) echo "Cerebro hibernate"
	   ssh alex@192.168.178.13 'sudo /usr/sbin/pm-hibernate'
	;;

	5) wol d0:50:99:86:59:d7 
	;;
        11) ping 192.168.178.13
	;;
	6) ssh alex@192.168.178.13 'beep -f 165.4064 -l 100 -n -f 130.813 -l 100 -n -f 261.626 -l 100 -n -f 523.251 -l 100 -n -f 1046.50 -l 100 -n -f 2093.00 -l 100 -n -f 4186.01 -l 100'
	#exit
	;;
	7) sudo mount -t cifs -o $smb_options //cerebro/stuff $p_public
	   echo "#########################"
	   echo " Mounted public stuff  "	
	   echo "#########################"
	;;
	# credentials=/home/ali/.smbcred,rw 
	8) sudo mount -t cifs -o $smb_options //cerebro/sicherung $p_sicherung
           echo "#########################"
	   echo " Mounted sicherung  "	
	   echo "#########################"
	;;
	9) sudo umount $p_public 
	   echo "#########################"
	   echo " Unmounted public   "
	   echo "#########################"
	;;
	10) sudo umount $p_sicherung
	   echo "#########################"
	   echo " Unmounted sicherung  "	
	;;
	12) exit
	;;
	*) echo "not configured"
	;;
esac

done

exit $?




