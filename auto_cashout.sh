#!/bin/bash
set -e

myFile="result.txt"
myLog="cashout.log"

if [ ! -f "$myFile" ]; then
    touch "$myFile"
fi

if [ ! -f "$myLog" ]; then
    touch "$myLog"
fi


echo "init..." > result.txt

./../cashout/cashout.sh > result.txt

#curl localhost:1635/chequebook/address > result.txt

resultStr=$(cat result.txt)

dateDIR=$(date "+%Y-%m-%d %H:%M:%S")

if [[ -z $resultStr ]];
then
    echo $dateDIR >> cashout.log
    echo "There are no redeemable checks, sleeping ..." >> cashout.log
    echo "There are no redeemable checks, sleeping ..."
else
    echo $dateDIR >> cashout.log
    echo $resultStr >> cashout.log
    ./../cashout/cashout.sh cashout-all 5 >> cashout.log
    echo "The check is cashed, sleeping..."
    echo "The check is cashed, sleeping..." >> cashout.log
fi
exit 1

