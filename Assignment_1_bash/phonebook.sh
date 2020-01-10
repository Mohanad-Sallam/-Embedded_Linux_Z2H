#! /bin/bash --login
clear
sudo chmod g+w /etc/phonebook
#creating Database file if it wasnot exist
if [ ! -e /etc/phonebook/.phonebookDB.txt ]
then
echo "Creating database file ..."
touch /etc/phonebook/.phonebookDB.txt
fi
sudo chmod g+w /etc/phonebook/.phonebookDB.txt
#--------------------------------------------------------------------------------------
if [ ! $1 ] #no input parameters : display all available opions
then
echo "-i : Insert new contact"
echo "-v : view available contacts"
echo "-s : Search by name for contact"
echo "-e : Delete all records"
echo "-d : Delete only one contact name"
#----------------------------------------------------------------------------------------
elif [ $1 = '-i' ] #first option: insert new contact
then
 name=0
 phone=0
 num=1
 read -p "enter contact name: " name
 read -p "enter number of available phones for $name: " num
 if [ "$num" -eq "$num" ] 2>/dev/null #checks that the i/p is integer
 then
 echo -n "$name"":" >>/etc/phonebook/.phonebookDB.txt
 echo -n "$num:" >>/etc/phonebook/.phonebookDB.txt
 for i in $( seq 1 $num )
 do
 read -p "Enter phone #$i: " phone
 if [ "$phone" -eq "$phone" ] 2>/dev/null #checks that the i/p phone number is valid number
 then
 echo -n "$phone:" >>/etc/phonebook/.phonebookDB.txt
 else
 echo "Error: phone should consists only from integers!!"
 grep -v "$name" /etc/phonebook/.phonebookDB.txt>t; mv t /etc/phonebook/.phonebookDB.txt
 sudo chmod g-w /etc/phonebook/.phonebookDB.txt
 sudo chmod g-w /etc/phonebook
 exit 1
 fi
 done
 echo "">>/etc/phonebook/.phonebookDB.txt
 else
 echo "Error : you must enter a valid integer!!"
 sudo chmod g-w /etc/phonebook/.phonebookDB.txt
 sudo chmod g-w /etc/phonebook
 exit 1
 fi
#-------------------------------------------------------------------------------------------------
elif [ $1 = '-v' ] #second option: view all available contacts
then
echo "Available contact list:"
read -r test </etc/phonebook/.phonebookDB.txt #read line from database to check that it is not empty
if [  ! $test ] #if file is empty
then
echo "None" #no available contacts -Empty database-
else #there is available contacts
while IFS= read -r line
do
IFS=':'
words=( $line )
echo "Name: ""${words[0]}"
echo "Available Contacts: ""${words[1]}"
x=${words[1]}
for ((j=1;j<=x;j++));
do
echo "phone #$j: ""${words[1+$j]}"
done
done </etc/phonebook/.phonebookDB.txt
fi
#------------------------------------------------------------------------------------------------------
elif [ $1 = '-s' ] #Third option: Search by contact name
then
key=0
match=0
read -p "please enter contact name you are searching for: " key
while IFS= read -r line
do
IFS=':'
words=( $line )
if [ $key = ${words[0]} ]
then
match=1
echo "Name: ""${words[0]}"
echo "Available Contacts: ""${words[1]}"
x=${words[1]}
for ((j=1;j<=x;j++));
do
echo "phone #$j: ""${words[1+$j]}"
done
fi
done </etc/phonebook/.phonebookDB.txt
if [ $match == 0 ]
then
echo "No matches!!"
fi
#-----------------------------------------------------------------------------------------------------
elif [ $1 = '-e' ] #fourth option: Delete all records
then
rm /etc/phonebook/.phonebookDB.txt
touch /etc/phonebook/.phonebookDB.txt
echo "All records deleted successfully!!"
#-----------------------------------------------------------------------------------------------------
elif [ $1 = '-d' ] #fifth option: Delete only one contact name
then
key=0
match=0
read -p "please enter contact name you want to delete: " key
touch temp.txt
while IFS= read -r line
do
IFS=':'
words=( $line )
if [ $key != ${words[0]} ]
then
for i in ${words[*]}
do
echo -n "$i:" >>temp.txt
done
echo"">>temp.txt
else
match=1
fi
done </etc/phonebook/.phonebookDB.txt
if [ $match == 0 ]
then
echo "No matches!!"
else
echo "Deleted successfully!!"
fi
rm /etc/phonebook/.phonebookDB.txt
mv temp.txt /etc/phonebook/.phonebookDB.txt
#-----------------------------------------------------------------------------------------------------
else
echo " Invalid Option!!"
fi
sudo chmod g-w /etc/phonebook/.phonebookDB.txt
sudo chmod g-w /etc/phonebook

