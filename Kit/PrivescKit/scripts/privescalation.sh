#!/bin/bash
###############################################################################################################
#    Enumeration is the key......
#    Information and commands provided by http://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation.html
#    Scripted by eXpl0i13r
################################################################################################################

echo "--------------"
echo "OS Information"
echo "--------------"
uname -a
echo ""

if [ -f /etc/issue ]
then
	echo "/etc/issue : `cat /etc/issue`"
fi
echo ""
echo "---------------------"
echo "OS Distro Information"
echo "---------------------"
cat /etc/*-release
echo ""
echo "---------------------"
echo "Kernel Information"				
echo "---------------------"

cat /proc/version 
uname -mrs
	
which rpm
OUT=$?
if [ $OUT -eq 0 ];then
   rpm -q kernel
fi
echo ""
echo "--------------------------"
echo "dmesg Kernel Information :"
echo "--------------------------"
dmesg | grep Linux
ls /boot | grep vmlinuz-

echo ""
echo "--------------------------"
echo "Environment Variables :   "
echo "--------------------------"

if [ -f /etc/profile ]
then
	echo "----------"
	echo "Profiles: " 
	echo "----------"      
	echo ""
	cat /etc/profile
	echo ""
fi

if [ -f /etc/bashrc ]
then
	echo "----------"
	echo "bashrc  : " 
	echo "----------"      
	echo ""
	cat /etc/bashrc
	echo ""
fi

if [ -f ~/.bash_profile ]
then
	echo "-----------------"
	echo ".bash_profile  : " 
	echo "-----------------"      
	echo ""
	cat ~/.bash_profile
	echo ""
fi

if [ -f ~/.bash_logout ]
then
	echo "-----------------"
	echo ".bash_logout   : " 
	echo "-----------------"      
	echo ""
	cat ~/.bash_logout
	echo ""
fi

echo "-----------------"
echo ".bash_logout   : " 
echo "-----------------"  
cat ~/.bash_logout
echo ""

echo "-----------------"
echo "env :	       " 
echo "-----------------"  
env
echo ""

echo "-----------------"
echo "set :	       " 
echo "-----------------"  
set
echo ""

echo "-------------------------" >> running_processes
echo "Services :               " >> running_processes
echo "-------------------------" >> running_processes 
ps -aux >> running_processes
echo "" >> running_processes
echo "Running Processes Dumped :)"


echo "---------------" >> binaries
echo "User Binaries :" >> binaries
echo "---------------" >> binaries
ls -alh /usr/bin/ >> binaries
echo "" >> binaries
echo "User Binaries Dumped :)"

echo "-----------------" >> binaries
echo "System Binaries :" >> binaries
echo "-----------------" >> binaries
ls -alh /sbin/ >> binaries
echo "" >> binaries
echo "System Binaries Dumped :)"


echo "------------------------" >> installed_apps
echo "Installed Applications :" >> installed_apps
echo "------------------------" >> installed_apps
which dpkg
OUT=$?
if [ $OUT -eq 0 ];then
   dpkg -l >> installed_apps
fi

echo "" >> installed_apps

which rpm
OUT=$?
if [ $OUT -eq 0 ];then
   rpm -qa >> installed_apps 
fi

echo "" >> installed_apps

echo "-------------"
echo "MYSql Version"
echo "-------------"
which mysql
OUT=$?
if [ $OUT -eq 0 ];then
   mysql -V
fi
echo ""

echo "----------------"
echo "apache2 Version "
echo "----------------"
which apache2
OUT=$?
if [ $OUT -eq 0 ];then
   apache2 -v
fi
echo "'"

echo "------------------------"
echo "Config Dump:      "
echo "------------------------"
if [ -f /etc/syslog.conf ]
then
	echo "---------------------" >> config_dump
	echo "/etc/syslog.conf   : " >> config_dump
	echo "---------------------" >> config_dump     
	echo ""  >> config_dump
	cat /etc/syslog.conf >> config_dump
	echo "" >> config_dump
	echo "syslog.conf Dumped....:)"
fi

if [ -f /etc/chttp.conf ]
then
	echo "---------------------" >> config_dump
	echo "/etc/chttp.conf   : " >> config_dump 
	echo "---------------------"   >> config_dump    
	echo "" >> config_dump
	cat /etc/chttp.conf >> config_dump >> config_dump
	echo "" >> config_dump
	echo "chttp.conf Dumped....:)"
fi

if [ -f /etc/lighttpd.conf ]
then
	echo "---------------------" >> config_dump
	echo "/etc/lighttpd.conf   : "  >> config_dump
	echo "---------------------"  >> config_dump     
	echo "" >> config_dump
	cat /etc/lighttpd.conf >> config_dump
	echo "" >> config_dump
	echo "lighttpd.conf Dumped....:)"
fi

if [ -f /etc/cups/cupsd.conf ]
then
	echo "---------------------" >> config_dump
	echo "/etc/cups/cupsd.conf   : "  >> config_dump
	echo "---------------------"  >> config_dump     
	echo "" >> config_dump
	cat /etc/cups/cupsd.conf >> config_dump
	echo "" >> config_dump
	echo "cupsd.conf Dumped....:)"
fi

if [ -f /etc/inetd.conf ]
then
	echo "---------------------" >> config_dump
	echo "/etc/inetd.conf   : "  >> config_dump
	echo "---------------------"   >> config_dump    
	echo "" >> config_dump
	cat /etc/inetd.conf >> config_dump
	echo "" >> config_dump
	echo "inetd.conf Dumped....:)"
	
fi

if [ -f /etc/apache2/apache2.conf ]
then
	echo "------------------------------" >> config_dump
	echo "/etc/apache2/apache2.conf   : "  >> config_dump
	echo "------------------------------"  >> config_dump     
	echo "" >> config_dump
	cat /etc/apache2/apache2.conf >> config_dump
	echo "" >> config_dump
	echo "apache2.conf Dumped....:)"
fi

if [ -f /etc/my.conf ]
then
	echo "------------------------------" >> config_dump
	echo "/etc/my.conf   : "  >> config_dump
	echo "------------------------------"     >> config_dump  
	echo "" >> config_dump
	cat /etc/my.conf >> config_dump 
	echo "" >> config_dump
fi

if [ -f /etc/httpd/conf/httpd.conf ]
then
	echo "------------------------------" >> config_dump
	echo "/etc/httpd/conf/httpd.conf  : "  >> config_dump
	echo "------------------------------"  >> config_dump     
	echo "" >> config_dump
	cat /etc/httpd/conf/httpd.conf >> config_dump
	echo "" >> config_dump
	echo "httpd.conf Dumped....:)"
fi

if [ -f /opt/lampp/etc/httpd.conf ]
then
	echo "------------------------------" >> config_dump
	echo "/opt/lampp/etc/httpd.conf  : "  >> config_dump
	echo "------------------------------"  >> config_dump     
	echo "" >> config_dump
	cat /opt/lampp/etc/httpd.conf >> config_dump
	echo "" >> config_dump
	echo "lampp httpd.conf Dumped....:)"
fi

echo "--------------"
echo "Cron Jobs :   "
echo "--------------"
crontab -l
echo ""

echo "--------------"
echo "Confidential :   "
echo "--------------"
id
who
last

if [ -f /etc/passwd ]
then
	echo "------------------------------" >> sensitive
	echo "/etc/passwd : "   >> sensitive
	echo "------------------------------"  >> sensitive
	cat /etc/passwd >> sensitive
	echo "" >> sensitive
	
fi

if [ -f /etc/group ]
then
	echo "------------------------------" >> sensitive
	echo "cat /etc/group : "   >> sensitive
	echo "------------------------------"  >> sensitive
	cat /etc/group >> sensitive
	echo "" >> sensitive
	echo "group file Dumped....:)"	
fi

if [ -f /etc/shadow ]
then
	echo "------------------------------" >> sensitive
	echo "/etc/shadow : "  >> sensitive
	echo "------------------------------"  >> sensitive
	cat /etc/shadow >> sensitive
	echo "" >> sensitive
	echo "shadow file Dumped....:)"	
fi


if [ -f /var/apache2/config.inc ]
then
	echo "------------------------------" >> sensitive
	echo "/var/apache2/config.inc : "  >> sensitive 
	echo "------------------------------"  >> sensitive
	cat  /var/apache2/config.inc >> sensitive
	echo "" >> sensitive
	echo "config.inc file Dumped....:)"	
fi


if [ -f /var/lib/mysql/mysql/user.MYD ]
then
	echo "------------------------------" >> sensitive
	echo "/var/lib/mysql/mysql/user.MYD : "  >> sensitive 
	echo "------------------------------"  >> sensitive
	cat  /var/lib/mysql/mysql/user.MYD >> sensitive
	echo "" >> sensitive
	echo "MYD file Dumped....:)"	
fi

if [ -f /root/anaconda-ks.cfg ]
then
	echo "------------------------------" >> sensitive
	echo "/root/anaconda-ks.cfg : "   >> sensitive
	echo "------------------------------"  >> sensitive
	cat  /root/anaconda-ks.cfg >> sensitive
	echo "" >> sensitive
	echo "anaconda-ks.cfg file Dumped....:)"	
fi

if [ -f /etc/sudoers ]
then
	echo "------------------------------" >> sensitive
	echo "/etc/sudoers : "   >> sensitive
	echo "------------------------------"  >> sensitive
	cat /etc/sudoers >> sensitive
	sudo -l
	echo "" >> sensitive
	echo "sudoers file Dumped....:)"	
fi



if [ -f ~/.ssh/authorized_keys ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/authorized_keys : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/authorized_keys  >> sshinfo
	echo ""  >> sshinfo
	echo "authorized_keys file Dumped....:)"	
fi

if [ -f ~/.ssh/identity.pub ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/identity.pub : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/identity.pub  >> sshinfo
	echo ""  >> sshinfo
	echo "identity.pub file Dumped....:)"	
fi

if [ -f ~/.ssh/identity ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/identity : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/identity  >> sshinfo
	echo ""  >> sshinfo
	echo "identity file Dumped....:)"	
fi


if [ -f ~/.ssh/id_rsa.pub ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/id_rsa.pub : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/id_rsa.pub  >> sshinfo
	echo ""  >> sshinfo
	echo "id_rsa.pub file Dumped....:)"	
fi

if [ -f ~/.ssh/id_rsa ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/id_rsa : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/id_rsa  >> sshinfo
	echo ""  >> sshinfo
	echo "id_rsa file Dumped....:)"	
fi


if [ -f ~/.ssh/id_dsa.pub ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/id_dsa.pub : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/id_dsa.pub >> sshinfo
	echo ""  >> sshinfo
	echo "id_dsa.pub file Dumped....:)"	
fi


if [ -f ~/.ssh/id_dsa ]
then
	echo "------------------------------" >> sshinfo
	echo "~/.ssh/id_dsa : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat ~/.ssh/id_dsa >> sshinfo
	echo ""  >> sshinfo
	echo "id_dsa.pub file Dumped....:)"	
fi



if [ -f /etc/ssh/ssh_config ]
then
	echo "------------------------------" >> sshinfo
	echo "/etc/ssh/ssh_config : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat /etc/ssh/ssh_config >> sshinfo
	echo ""  >> sshinfo
	echo "ssh_config file Dumped....:)"	
fi

if [ -f /etc/ssh/ssh_config ]
then
	echo "------------------------------" >> sshinfo
	echo "/etc/ssh/sshd_config : "    >> sshinfo
	echo "------------------------------"   >> sshinfo
	cat /etc/ssh/sshd_config >> sshinfo
	echo ""  >> sshinfo
	echo "sshd_config file Dumped....:)"	
fi


echo "------------------------------"  >> writable_configs
echo "Writable Configuration Files : "  >> writable_configs
echo "------------------------------"  >> writable_configs

echo "---------------">> writable_configs
echo "Writable by ALL">> writable_configs
echo "---------------">> writable_configs
echo `ls -aRl /etc/ | awk '$1 ~ /^.*w.*/' 2>/dev/null` >> writable_configs
echo "">> writable_configs

echo "------------------">> writable_configs
echo "Writable by Owner">> writable_configs
echo "------------------">> writable_configs
echo `ls -aRl /etc/ | awk '$1 ~ /^..w/' 2>/dev/null`  >> writable_configs
echo "">> writable_configs


echo "-----------------">> writable_configs
echo "Writable by Group">> writable_configs
echo "------------------">> writable_configs
echo `ls -aRl /etc/ | awk '$1 ~ /^.....w/' 2>/dev/null`  >> writable_configs
echo "">> writable_configs


echo "-----------------" >> writable_configs
echo "Writable by Other" >> writable_configs
echo "------------------" >> writable_configs
echo `ls -aRl /etc/ | awk '$1 ~ /w.$/' 2>/dev/null`   >> writable_configs
echo "">> writable_configs


echo "-----------------" >> writable_configs
echo "Readable by ALL" >> writable_configs
echo "------------------" >> writable_configs
find /etc/ -readable -type f 2>/dev/null   >> writable_configs
echo "">> writable_configs
  
echo "-----------------------" >> writable_configs
echo "World Writable Folders:" >> writable_configs
echo "------------------------" >> writable_configs
find / -writable -type d 2>/dev/null   >> writable_configs
echo "">> writable_configs

echo "-------------------------" >> writable_configs
echo "World Executabke Folders:" >> writable_configs
echo "--------------------------" >> writable_configs
find / -perm -o+x -type d 2>/dev/null   >> writable_configs
echo "">> writable_configs



echo "-----------------"
echo "File System"
echo "------------------"
mount 
echo ""
df -h
echo ""

echo "-----------------"
echo "/etc/fstab"
echo "------------------"
cat /etc/fstab 
echo ""

echo "------------------------" >> exploits
echo "Sticky bits">> exploits
echo "------------------------">> exploits
find / -perm -1000 -type d 2>/dev/null>> exploits
echo "">> exploits


echo "------------------------">> exploits
echo "SUID">> exploits
echo "------------------------">> exploits
find / -perm -u=s -type f 2>/dev/null>> exploits
echo ""

echo "------------------------">> exploits
echo "SGUID">> exploits
echo "------------------------">> exploits
find / -perm -g=s -type f 2>/dev/null>> exploits
echo "">> exploits

echo "---------------------------">> exploits
echo "which exploits can work?">> exploits
echo "---------------------------">> exploits

echo "---------------------------">> exploits
echo "Python:			">> exploits
echo "---------------------------">> exploits
python -V>> exploits
echo "">> exploits
echo "---------------------------">> exploits
echo "Perl:			">> exploits
echo "---------------------------">> exploits
perl -v>> exploits
echo "">> exploits
echo "---------------------------">> exploits
echo "gcc:			">> exploits
echo "---------------------------">> exploits
gcc -v>> exploits
echo "">> exploits
echo "---------------------------">> exploits
echo "cc:			">> exploits
echo "---------------------------">> exploits
cc -v>> exploits
echo "">> exploits


echo "---------------------------">> network
echo "Network Information:	 ">> network
echo "---------------------------">> network
/sbin/ifconfig -a >> network

echo "---------------------------">> network
echo "Network Interfaces:	 ">> network
echo "---------------------------">> network
cat /etc/network/interfaces >> network
echo "" >> network

echo "---------------------------">> network
echo "/etc/sysconfig/network:	 ">> network
echo "---------------------------">> network
cat /etc/sysconfig/network >>network
echo "" >> network

echo "---------------------------">> network
echo "/etc/resolv.conf:	 ">> network
echo "---------------------------">> network
cat /etc/resolv.conf>> network
echo "" >>network

echo "---------------------------">> network
echo "IPTABLES:	 ">> network
echo "---------------------------">> network

iptables -L
echo "" >> network

echo "---------------------------">> network
echo "Hosts communicating with:	 ">> network
echo "---------------------------">> network

lsof -i >> network
echo "" >> network

echo "---------------------------">> network
echo "Netstat O/p:	 " >> network
echo "---------------------------">> network

netstat -antup
echo ""


echo "---------------------------">> network
echo "Route Information:	 ">> network
echo "---------------------------">> network
route >> network
echo "">> network



