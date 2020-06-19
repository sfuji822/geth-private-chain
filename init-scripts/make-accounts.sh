#!/bin/sh
for i in 1 2 3 4; do
  geth --nousb --datadir "/datadir" account new --password /dev/null 
done
