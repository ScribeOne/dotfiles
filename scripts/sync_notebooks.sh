#!/bin/sh


remote_uni=/home/michi/uni/WS2020_2021
local_uni=/home/scribe/Documents/WS2020_2021/


remote_notebooks=/home/michi/Notebookstest
local_notebooks=/home/scribe/Notebookstest/


cerebro_ip=10.1.1.23

now=`date "+%F-%H-%M-%S"`

#TODAY=`date +'%D'`
#TODAY=`date +'$Y%m%d'`


LOG=/home/scribe/rsynclogs

# rync flags:
#   -a Archive, preserve all file attributes and permissions
#   -v verbose
#   -z enable gzip compression
#   -h human readable
#   -e enable ssh protocol
#   --numeric-ids needed if user ids don't match between the source and
#       destination servers
#   --delete -r Deletes files from $DESTINATION that are not present on the $SOURCE


rsync --progress --delete -avzh -e 'ssh -p22' $local_notebooks michi@$cerebro_ip:$remote_notebooks 

echo -e "\nNotebooks synced from $(hostname) to server - $now" >> $LOG


#rsync --progress --delete -avzh -e 'ssh -p22' michi@$cerebro_ip:~/Notebookstest/ ~/Notebookstest 

#echo -e "\nNotebooks synced from $(hostname) to server - $now" >> $LOG





