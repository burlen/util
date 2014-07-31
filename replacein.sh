#!/bin/bash

if [[ $# < 1 ]]
then
  echo "usage: replacein.sh wordToReplace withWord grepArgs"
fi

if [ -z "$2" ]
then
  echo -n "\$2 is not set to a replace term. Contuinue (y/n)?"
  read PMT;
  case "$PMT" in
    "y" )
    echo "Ok.";
    ;;

    * )
      echo "Stop.";
      exit
      ;;
   esac
fi

WTR=$1
WW=$2

shift 1
shift 1

OPTS=$*

echo "Replace $WTR with $WW"
echo "extra grep opts are $OPTS"

for f in `grep "$WTR" ./ -rInl --exclude-dir=.svn --exclude=\*~ $OPTS`;
do
  echo -n "in $f (y,a,n,q)?";

  if [ -z "$ALL" ]
  then
    read PMT;
  else
    echo
  fi

  case "$PMT" in
    "y" )
      sed -i "s/$WTR/$WW/g" $f
      ;;

   "a" )
      ALL="1"
      PMT="y"
      sed -i "s/$WTR/$WW/g" $f
      ;;

    * )
      echo  skip;
      ;;

  esac;
done

