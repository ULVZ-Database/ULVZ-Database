#!/bin/bash

# Stations:

OUTFILE=tmp.ps

PLOT=15
LOMIN=-130
LOMAX=-90
LAMIN=10
LAMAX=50

REG="-R${LOMIN}/${LOMAX}/${LAMIN}/${LAMAX}"
xscale=`echo "${PLOT}/(${LOMAX} - ${LOMIN})" | bc -l`
yscale=`echo "${PLOT}/(${LAMAX} - ${LAMIN})" | bc -l`
PROJ="-Jx${xscale}d/${yscale}d"

pscoast ${REG} ${PROJ} -Dl -A10000 -W2p,black -P -K > ${OUTFILE}
psbasemap ${REG} ${PROJ} -Ba10g10/a10g10 -O -K >> ${OUTFILE}
psxy ${REG} ${PROJ} -W1p,red -SE -O -K >> ${OUTFILE} << EOF
-119.5 40.5 342 1550 500
EOF
psxy ${REG} ${PROJ} -O >> ${OUTFILE} << EOF
EOF

ps2pdf tmp.ps

exit 0
