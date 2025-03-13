#!/bin/bash
#Day1
echo "Kashish"
comp="LTI"
#built in variable
echo "$comp"


#wildcard to copy files
cd /var/www
cp *.html /var/www-just-html

# For loop
cd /var/www
for file in *.html
do
echo "copying $file"
cp $file /var/www-just-html
done
