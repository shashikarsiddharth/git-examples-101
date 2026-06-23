#! /bin/bash

#Write a program that takes 5 input params from the user, and prints them one by one

VAR=$@

for n in $VAR
do
	echo $n
done


