#!/bin/bash
# Program:
#	Automation to check if the ilo login is fine.
#	Wiki: https://github.com/weiliy/infra-automation-tools/wiki/ilo-login-check
# History:
# 2014/11/07	Weili	First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


while getopts :u:p: arg
do
	case $arg in
		u)	ilousername=$OPTARG ;;
		p)	ilopassword=$OPTARG ;;
		:)	echo "$0: Must supply an argument to -$OPTARG." >&2
			exit 1 ;;
		\?)	echo "Invalid option -$OPTARG." >&2
			exit 1;;
	esac
done	
shift $(($OPTIND - 1))
ilolist=("$@")

echo username=$ilousername
echo password=$ilopassword
echo serverlist:
echo ${ilolist[@]}

export isLogin=0
checkLogin()
{
	isLogin=`expect -c "
			spawn ssh $ip -l $ilousername
			expect {
				(yes/no) {send \"yes\r\"; exp_continue}
				password: {send \"$ilopassword\r\"; exp_continue}
				> {send \"exit\r\"; exp_continue}
			}
		" | grep "logged" | wc -l`
}
for ip in ${ilolist[@]}
do
	echo Trying to connect to $ip...
	checkLogin()
	case $isLogin in
		0)	echo "Login to $ip failed."
			failedIPs=("$failedIPs[*]" $ip)
			;;
		1)	echo "Login to $ip successfully."
			succIPs=("$succIPs[*]" $ip)
			;;
	esac
	esac
done
