#!/bin/bash

# Script to search genealodzy.pl for surnames in all districts and in births, marriages and deaths.
# Usage: genealogy.sh exact 1=yes, 0=no, surname, name
# Example ./genealogy.sh 1 smith john

echo "Searching for $2 and $3..."

districts=(01ds 02kp 03lb 04ls 05ld 06mp 07mz 71wa 08op 09pk 10pl 11pm 12sl 13sk 14wm 15wp 16zp 21uk 22br 23lt 25po)

for i in "${districts[@]}"
do
echo "┌─────────────────────────────────────────"
echo "|Births of $2 in $i"
echo "└─────────────────────────────────────────"
curl -sS 'http://geneteka.genealodzy.pl/api/getAct.php?op=gt&lang=pol&bdm=B&w='"${i}"'&rid=B&search_lastname='"$2"'&search_name='"$3"'&search_lastname2=&search_name2=&from_date=&to_date=&exac='"$1" -H 'Referer: http://geneteka.genealodzy.pl/index.php?op=gt&lang=pol&bdm=B&w='"${i}"'&rid=B&search_lastname='"$2"'&search_name='"$3"'&search_lastname2=&search_name2=&from_date=&to_date=&exac='"$1" --compressed --insecure | jq -r '.data[] | @csv' >> $2_births.csv

echo "┌─────────────────────────────────────────"
echo "|Marriages of $2 in $i"
echo "└─────────────────────────────────────────"
curl -sS 'http://geneteka.genealodzy.pl/api/getAct.php?op=gt&lang=pol&bdm=S&w='"${i}"'&rid=S&search_lastname='"$2"'&search_name='"$3"'&search_lastname2=&search_name2=&from_date=&to_date=&exac='"$1" -H 'Referer: http://geneteka.genealodzy.pl/index.php?op=gt&lang=pol&bdm=S&w='"${i}"'&rid=S&search_lastname='"$2"'&search_name='"$3"'&search_lastname2=&search_name2=&from_date=&to_date=&exac='"$1" --compressed --insecure | jq -r '.data[] | @csv' >> $2_marriages.csv

echo "┌─────────────────────────────────────────"
echo "|Deaths of $2 in $i"
echo "└─────────────────────────────────────────"
curl -sS 'http://geneteka.genealodzy.pl/api/getAct.php?op=gt&lang=pol&bdm=D&w='"${i}"'&rid=D&search_lastname='"$2"'&search_name='"$3"'&search_lastname2=&search_name2=&from_date=&to_date=&exac='"$1" -H 'Referer: http://geneteka.genealodzy.pl/index.php?op=gt&lang=pol&bdm=D&w='"${i}"'&rid=D&search_lastname='"$2"'&search_name='"$3"'&search_lastname2=&search_name2=&from_date=&to_date=&exac='"$1" --compressed --insecure | jq -r '.data[] | @csv' >> $2_deaths.csv

done

