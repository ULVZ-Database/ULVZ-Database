#!/bin/bash

c++ PutModel.cpp

for Res in yes no may
do
	PointFile=${Res}.txt
	AzFile=${Res}_ForAzimuthCalc.txt

	./a.out ${PointFile} ${AzFile} Data.PKP.CP.${Res}.line
done


exit 0
