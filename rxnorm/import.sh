#!/bin/bash

#unzip rxnorm.zip

git clone http://github.com/chb/py-umls && cd py-umls
sh databases/rxnorm.sh  ..
EXPORT_TYPE=csv DID_SOURCE_FOR_SETUP=did python2 rxnorm_link_run.py
