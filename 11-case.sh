#!/bin/bash

#	Syntax
#	case $var in
#		opt1) command1 ;;

#		opt2) command2 ;;

#	esac

ACTION=$1
case $ACTION in
	start)
		echo -e "\e[32mStarting the server\e[0m"
		exit 0
	;;
	stop)
		echo -e "\e[31mStopping the server\e[0m"
		exit 1
	;;
	restart)
		echo -e "\e[33mRestarting the server\e[0m"
	;;
	*)
		echo -e "\e[36mPlease choose start|stop|restart\e[0m"
	;;
esac