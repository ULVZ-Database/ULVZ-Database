#!/bin/bash

CLON=-14.8
CLAT=64
Radius=3.60
CMB_400=6.59

c++ --std=c++14 MakeCircle.cpp -lm
./a.out ${CLON} ${CLAT} ${Radius} > circle.txt
./a.out ${CLON} ${CLAT} ${CMB_400} > Data.Sdiff.Iceland.yes.area

OUTFILE=tmp.ps

PROJ="-JG-10/70/6i"
REG="-Rg"

pscoast ${REG} ${PROJ} -Dl -A40000 -W0.5p,green -P -K > ${OUTFILE}
# In Illustrator:
# X: 0.9876 in 
# Y: 5.4983 in
# W: 7.0325 in

psbasemap ${REG} ${PROJ} -B -O -K >> ${OUTFILE}

# Area.
psxy circle.txt ${REG} ${PROJ} -W1p,cyan -m -L -O -K >> ${OUTFILE}
psxy Data.Sdiff.Iceland.yes.area ${REG} ${PROJ} -m -L -W1p,red -O >> ${OUTFILE}

exit 0
