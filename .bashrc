# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
     . /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
     . /etc/bash.bashrc
fi

# Grab smart autocompletion functions
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# For each file in the autocompletion directory
for filename in /etc/bash_completion.d/*
do
	# Source the file (add the autocompletion scheme to bash "complete")
	. $filename
done;

# User specific aliases and functions
umask 002;
