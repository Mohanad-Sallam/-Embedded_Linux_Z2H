#!/bin/sh
buttonmanager(){
next=$1
prev=$2
play=$3
stop=$4

if [ ! -d /sys/class/gpio/gpio$next ] ; then

echo "$next" >/sys/class/gpio/export
echo "in" >/sys/class/gpio/gpio$next/direction

fi

if [ ! -d /sys/class/gpio/gpio$prev ] ; then
                                 
echo "$prev" >/sys/class/gpio/export
echo "in" >/sys/class/gpio/gpio$prev/direction
                                 
fi

if [ ! -d /sys/class/gpio/gpio$play ] ; then
                                 
echo "$play" >/sys/class/gpio/export
echo "in" >/sys/class/gpio/gpio$play/direction
                                 
fi

if [ ! -d /sys/class/gpio/gpio$stop ] ; then
                                 
echo "$stop" >/sys/class/gpio/export
echo "in" >/sys/class/gpio/gpio$stop/direction                                 
fi

if [ ! -d /sys/class/gpio/gpio18 ] ; then

echo "18" >/sys/class/gpio/export        
echo "out" >/sys/class/gpio/gpio18/direction
fi

if [ ! -d /sys/class/gpio/gpio23 ] ; then
echo "23" >/sys/class/gpio/export             
echo "out" >/sys/class/gpio/gpio23/direction 
fi

if [ ! -d /sys/class/gpio/gpio24 ] ; then

echo "24" >/sys/class/gpio/export             
echo "out" >/sys/class/gpio/gpio24/direction 
fi

if [ ! -d /sys/class/gpio/gpio25 ] ; then
echo "25" >/sys/class/gpio/export             
echo "out" >/sys/class/gpio/gpio25/direction
fi 
while :
do
cat  /sys/class/gpio/gpio$next/value > /sys/class/gpio/gpio18/value
cat  /sys/class/gpio/gpio$prev/value > /sys/class/gpio/gpio23/value  
cat  /sys/class/gpio/gpio$play/value > /sys/class/gpio/gpio24/value  
cat  /sys/class/gpio/gpio$stop/value > /sys/class/gpio/gpio25/value   
done
}
buttonmanager $1 $2 $3 $4 
