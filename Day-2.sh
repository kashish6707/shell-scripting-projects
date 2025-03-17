#!/bin/bash
echo "All files and directory in $PWD"
touch file1.txt
ls -l > file1.txt
name= awk '{ print $9 "\t" "(" $5 "KB" ")" }' file1.txt
echo $name


#COUNT CHARACTER
read -p "Enter sentence seperated by space:" sent
echo "character count:" ${#sent} 
