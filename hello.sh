#! /bin/bash




for i in {1..5}
do 
	read -p "Enter  number: " num1
	sum=$((i + num1))
	echo $sum
done

