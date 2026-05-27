#! /bin/bash


read number1

forloop() {

for i in $(seq $number1)
do 
	echo $i
done
}

whileloop() {

i=1
while [[ $i -le $number1 ]]
do
	echo $i
	i=$(expr $i + 1)
	
done
}

forloop




