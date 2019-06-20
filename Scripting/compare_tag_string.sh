#!/bin/bash
# Nagios Plugin Bash Script - compare_tag_string.sh
# This script checks if two strings from two different files in two different repos are the same.
# Helps to check if prod and dev yaml tag files are the same, especially if deployed by helm.
# It needs a lot of improvments especially when handling username and apppassword
###################
# Replace ALL <> !#
###################

if [[ -z "$1" ]]
then
        echo "Missing Service Name! Usage: ./compare_tag_string.sh service_name"
        exit 3
fi

curl -s -S --user username:apppassword -L -o $1_values-dev.yaml https://api.bitbucket.org/2.0/repositories/<ORGANISATION>/<REPO>/src/master/$1/values-dev.yaml
curl -s -S --user username:apppassword -L -o $1_values-prod.yaml https://api.bitbucket.org/2.0/repositories/<ORGANISATION>/<REPO>/src/master/$1/values-prod.yaml

if ! grep -q -E -i -w "tag|imagetag" "$1_values-dev.yaml" || ! grep -q -E -i -w "tag|imagetag" "$1_values-prod.yaml"; 
    then
        echo "CRITICAL, TAG in value file does not exist."
        exit 2
    else
        devtag=$(cat $1_values-dev.yaml | grep -i "tag:")
        prodtag=$(cat $1_values-prod.yaml | grep -i "tag:")
        rm -f $1_values-dev.yaml
        rm -f $1_values-prod.yaml
            if [ "$devtag" == "$prodtag" ]
                then
                    echo "OK, $1 Dev and Prod tags are the same."
                        exit 0
                else
                    echo "CRITICAL, $1 Dev and Prod tags are not the same."
                        exit 2
                fi
fi

