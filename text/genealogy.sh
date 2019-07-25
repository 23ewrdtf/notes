#!/bin/bash

# Script to search genealodzy.pl for surnames in all districts
# Usage: genealogy.sh surname name

echo "Searching for $1 and $2..."

surname=$1
name=$2
# uncomment this to search in all districts districts=(01ds 02kp 03lb 04ls 05ld 06mp 07mz 71wa 08op 09pk 10pl 11pm 12sl 13sk 14wm 15wp 16zp 21uk 22br 23lt 25po)
districts=(71wa)

for i in "${districts[@]}"
do
echo "┌─────────────────────────────────────────"
echo "|Birth..."
echo "└─────────────────────────────────────────"
curl -sS 'http://geneteka.genealodzy.pl/api/getAct.php?op=gt&lang=pol&bdm=B&w='"${i}"'&rid=B&search_lastname='"$1"'&search_name='"$2"'&search_lastname2=&search_name2=&from_date=&to_date=&exac=1' -H 'Referer: http://geneteka.genealodzy.pl/index.php?op=gt&lang=pol&bdm=B&w='"${i}"'&rid=B&search_lastname='"$1"'&search_name='"$2"'&search_lastname2=&search_name2=&from_date=&to_date=&exac=1' --compressed --insecure | jq

echo "┌─────────────────────────────────────────"
echo "|Marriage..."
echo "└─────────────────────────────────────────"
#curl -sS 'http://geneteka.genealodzy.pl/api/getAct.php?op=gt&lang=pol&bdm=S&w='"${i}"'&rid=S&search_lastname='"$1"'&search_name='"$2"'&search_lastname2=&search_name2=&from_date=&to_date=&exac=1' -H 'Referer: http://geneteka.genealodzy.pl/index.php?op=gt&lang=pol&bdm=S&w='"${i}"'&rid=S&search_lastname='"$1"'&search_name='"$2"'&search_lastname2=&search_name2=&from_date=&to_date=&exac=1' --compressed --insecure | jq

echo "┌─────────────────────────────────────────"
echo "|Deaths..."
echo "└─────────────────────────────────────────"
#curl -sS 'http://geneteka.genealodzy.pl/api/getAct.php?op=gt&lang=pol&bdm=D&w='"${i}"'&rid=D&search_lastname='"$1"'&search_name='"$2"'&search_lastname2=&search_name2=&from_date=&to_date=&exac=1' -H 'Referer: http://geneteka.genealodzy.pl/index.php?op=gt&lang=pol&bdm=D&w='"${i}"'&rid=D&search_lastname='"$1"'&search_name='"$2"'&search_lastname2=&search_name2=&from_date=&to_date=&exac=1' --compressed --insecure | jq

done
