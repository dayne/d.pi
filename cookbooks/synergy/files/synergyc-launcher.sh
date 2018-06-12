#!/bin/bash

SBN=Synergy  # switch to Barrier if needed
CFGDIR=${HOME}/.${SBN,,} # downcase

function synergyGenPem
{
  if [ ! -d $CFGDIR/SSL/Fingerprints ]; then
  	mkdir -p $CFGDIR/SSL/Fingerprints
  fi
  if [ ! -f $CFGDIR/SSL/${SBN}.pem ]; then
    openssl req -x509 -nodes -days 365 -subj /CN=${SBN} -newkey rsa:1024 -keyout $CFGDIR/SSL/${SBN}.pem -out $CFGDIR/SSL/${SBN}.pem
  fi
  if [ ! -f $CFGDIR/SSL/Fingerprints/Local.txt ]; then
    openssl x509 -fingerprint -sha1 -noout -in $CFGDIR/SSL/${SBN}.pem > $CFGDIR/SSL/Fingerprints/Local.txt
    sed -e "s/.*=//" -i $CFGDIR/SSL/Fingerprints/Local.txt	
  fi
}

function synergyFirstStart 
{
	mkdir $CFGDIR
	chown 700 $CFGDIR
	cd $CFGDIR
	mkdir SSL
	chown 700 SSL
	synergyGenPem
}

if [ ! -d $CFGDIR ]; then
	echo "synergy initalizization not done"
	synergyFirstStart
fi

while( true ); do
  echo "killing all synergyc"
  killall synergyc
  synergyc -f --no-tray --debug INFO --name `hostname` --enable-crypto gilbert.lan:24800
  echo 'synergyc crashed ... launching in 3'
  sleep 5
done
