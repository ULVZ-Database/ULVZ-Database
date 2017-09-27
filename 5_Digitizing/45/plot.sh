#!/bin/bash

CLON=-167.5
CLAT=17.5
Radius=7.491

c++ --std=c++14 MakeCircle.cpp -lm
./a.out ${CLON} ${CLAT} ${Radius} > Data.Sdiff.ZF2.yes.area

OUTFILE=tmp.ps

PROJ="-JB215/90/20/30/6i"
REG="-R140/292.5/-30/80"

pscoast ${REG} ${PROJ} -Dl -A40000 -Ba30g30/a20g20 -W1p,green -P -K > ${OUTFILE}
# In Illustrator:
# X: -0.0617 in
# Y: 4.102 in
# W: 8.7 in

# Area.
psxy Data.Sdiff.ZF2.yes.area ${REG} ${PROJ} -W1p,blue -O >> ${OUTFILE}



exit 0
