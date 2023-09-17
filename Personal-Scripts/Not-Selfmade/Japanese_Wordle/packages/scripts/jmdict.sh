#!/bin/bash

curl ftp://ftp.edrdg.org/pub/Nihongo//JMdict_e.gz | gunzip > cache/JMdict_e.xml
yarn
yarn ts scripts/make-jmdict.ts
