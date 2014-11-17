#!/bin/bash

#unzip rxnorm.zip

cd prescribe/rrf

sed "s/^\(.*\)|$/\1/" RXNREL.RRF   > RXNREL.RRF.sl
sed "s/^\(.*\)|$/\1/" RXNCONSO.RRF   > RXNCONSO.RRF.sl
sed "s/^\(.*\)|$/\1/" RXNSAT.RRF   > RXNSAT.RRF.sl

sqlite3 ../../rxnorm.sqlite <  ../scripts/mysql/Table_scripts_mysql_rxn.sql
sqlite3 ../../rxnorm.sqlite <  ../../import.sql
