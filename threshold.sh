#!/bin/bash
     
#Copyright Elvis Ibrahimi 
#Free to use, not to sell :)

#Grep some informations from top command


#echo CPU: `top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'` %   

#CPU=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' | bc -l)

#CPU1= echo print `top -n 1 | tr -s " " | cut -d$" " -f10 | tail -n +8 | head -n -1 | paste -sd+ | bc`/ `nproc` | python

CPUSPEED=`grep ^proc /proc/cpuinfo | wc -l`; FIRST=`cat /proc/stat | awk '/^cpu / {print $5}'`; sleep 1; SECOND=`cat /proc/stat | awk '/^cpu / {print $5}'`; USED=`echo 2 k 100 $SECOND $FIRST - $NUMCPUS / - p | dc`; echo ${USED} CPU Usage

#echo CPU2= ps -A -o pcpu | tail -n+2 | paste -sd+ | bc -l

#Grep Ram usage
MEM=`free -m | grep Mem` 
MEMUSED=`echo $MEM | cut -f3 -d' '`
TOTAL=`echo $MEM | cut -f2 -d' '`

#echo $CPU1
#echo $CPU2


#How many users are online
USERSON='who'
echo Online Users: `$USERSON | wc -l`



#Disk usage grep only (WORK ON THE FUTURE)




# Read TOTAL RAM on the system and average  memory usage
echo RAM Total: $TOTAL MB
echo RAM Used: $MEMUSED MB 

#Check if MAX RAM is reached
MAXRAM="268";

echo

if (( "$MEMUSED" > "$MAXRAM" )); then 
echo "**** System RAM Threshhold Reached! ****"
echo
echo
fi 


#Check if MAX CPU is reached (Threshhold)
MAXCPU="1.2"
#if (($(echo "$CPU1  $MAXCPU"  | awk '{print ($CPU > $MAXCPU)}') )); then
if ($( "$CPUSPEED" -gt "$MAXCPU" ) | bc -l); then
echo "**** CPU Threshhold is reached!!!****"
echo
echo	 

exit
fi 