#! /bin/bash
if [ ! -e ~/TRASH ] #checks if TRASH folder exists
then
echo "creating TRASH folder..."
mkdir ~/TRASH
fi
type=0
for i in $@ #loop over the passed fils / dirs
do
if [ -d $i ] #checks if its a directory
then
echo "Compressing the directory to $i"".gz"
tar -czf $i.gz $i
mv $i.gz ~/TRASH
rm -r $i
elif [ -e $i ] #check if the passed filename actually exists
then
type=$(file -b $i)
IFS=' '
check=( $type )
if [ ${check[0]} = 'gzip' ]
then
echo "no need for compressing file is already GZip compressed!"
else
echo "compressing file .."
tar czf $i $i
fi
mv $i ~/TRASH
else
echo "File doesnot exist!!"
fi
done
find ~/TRASH -mtime +2 -type f -exec rm {} \;
