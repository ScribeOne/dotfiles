#!/bin/zsh

SESSIONNAME="base"
WINDOW_1='main'
WINDOW_2="otter stuff"
WINDOW_3="logs"

tmux has-session -t $SESSIONNAME &> /dev/null


# C-m means pressing Enter


if [ $? != 0 ] 
     then
         # new session
	 tmux new-session -s $SESSIONNAME  -d

	 # first window 
	 tmux rename-window -t 1 $WINDOW_1 
         #tmux send-keys -t $WINDOW_1 'cd ~' C-m
         #tmux send-keys -t $WINDOW_1 'clear' C-m
	 #tmux split-window -h
	 #tmux send-keys -t $WINDOW_1 'htop' C-m
	 #tmux split-window -v
	 #tmux send-keys -t $WINDOW_1 'cd ~/workspace' C-m
         #tmux send-keys -t $WINDOW_1 'clear' C-m
	 #tmux send-keys -t $WINDOW_1 ll C-m

	 # second window
	 tmux new-window -t $SESSIONNAME:2 -n $WINDOW_2
	 #tmux split-window -h


	 # third window
	 #tmux new-window -t $SESSIONNAME:3 -n $WINDOW_3
	 #tmux split-window -h
	 #tmux split-window -v

	 # Switch to first window
	 tmux select-window -t $SESSIONNAME:1
	 tmux select-pane -t 0
fi


tmux attach -t $SESSIONNAME
