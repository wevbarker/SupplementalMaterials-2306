#!/bin/bash

#============================#
#  This is the synchroniser  #
#============================#


if [ "$1" = "--newton" ]; then
	rsync -avh -e 'ssh -A -J appcs' --force --exclude '.git' ./ newton:~/xPlain/ --delete
elif [ "$1" = "--green" ]; then
	rsync -avh --force ./ green:~/Documents/xPlain/ --delete
elif [ "$1" = "--red" ]; then
	rsync -avh --force --exclude '.git' ./ red:~/Documents/xPlain/ --delete
elif [ "$1" = "--Cumulus" ]; then
	rsync -avh --force --exclude '.git' ./ Cumulus:~/Documents/xPlain/ --delete
else
	echo "can you please specify a remote location from newton, green, red or Cumulus?"	
fi

exit 0
