#! /bin/bash


read number

forloop() {

for i in $(seq $number)
do 
	echo $i
done
}

whileloop() {

i=1
while [[ $i -le $number ]]
do
	echo $i
	i=$(expr $i + 1)
	
done
}

forloop




