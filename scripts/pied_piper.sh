#!/bin/sh
local_uni=/home/scribe/Documents/WS2020_2021
remote_uni=/home/michi/uni/WS2020_2021

local_notebooks=/home/scribe/Notebooks
remote_notebooks=/home/michi/Notebooks

local_vivaldi=/home/scribe/.config/vivaldi/Default
remote_vivaldi=/home/michi/backup/Default

local_backup=/home/scribe/backup
remote_backup=/home/michi/backup/browser_files

log_path=/home/scribe/rsync.log

cerebro_ip=10.1.1.23
now=`date "+%F-%H-%M-%S"`

source="source path not set"
destination="destination path not set"


pull_files(){
    echo -e "\n---------------- Job started ----------------" | tee -a $log_path
    echo -e "\n$now - Sync files from server to $(hostname)"  | tee -a  $log_path
    rsync --progress --delete -avzh -e 'ssh -p22' michi@$cerebro_ip:$source/ $destination | tee -a $log_path
}


push_files(){
    echo -e "\n---------------- Job started ----------------" | tee -a $log_path
    echo -e "\n$now - Sync files from $(hostname) to server" | tee -a  $log_path
    rsync --progress --delete -avzh -e 'ssh -p22' $source/ michi@$cerebro_ip:$destination | tee -a $log_path
}


while getopts uUrnNvVbB option
do
case "${option}"
in
# Uni local -> cerebro
u)  source=$local_uni
    destination=$remote_uni
    push_files
    ;;

# Uni cerebro -> local
U)  source=$remote_uni
    destination=$local_uni
    pull_files
    ;;

# push notebooks
n)  source=$local_notebooks
    destination=$remote_notebooks
    push_files
    ;;

#pull notebooks
N)  source=$remote_notebooks
    destination=$local_notebooks
    pull_files
    ;;


# push vivaldi
v)  source=$local_vivaldi
    destination=$remote_vivaldi
    push_files
    ;;

#pull vivaldi
V)  source=$remote_vivaldi
    destination=$local_vivaldi
    pull_files
    ;;

# push backup
b)  source=$local_backup
    destination=$remote_backup
    push_files
    ;;

#pull backup
B)  source=$remote_backup
    destination=$local_backup
    pull_files
    ;;



*) echo "No se"
esac
done





