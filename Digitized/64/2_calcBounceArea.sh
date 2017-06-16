#!/bin/bash

SRCDIR=${PWD}

# Earthquakes:
# 1. 180km , -178.8, 52.8
# 2. 190km , -174.0, 52.8

EVLO=-178.8
EVLA=52.8
EVDE=180

# EVLO=-174.0
# EVLA=52.8
# EVDE=190

CCODEDIR=${HOME}/Research/Fun.C.c002

cd ${CCODEDIR}
make
cd ${SRCDIR}

# ==============================
#     ! theo.out !
# ==============================
gcc -o calc.out calc.c -I${CCODEDIR} -L${CCODEDIR} -lASU_tools -lm
if [ $? -ne 0 ]
then
    echo "Code not compiled ..."
    rm *.a *.o 2>/dev/null
    exit 1;
fi

rm *.a *.o 2>/dev/null

./calc.out 0 2 3 << EOF
StationArea.txt
Data.ScP.EQ1.no.area
${EVLO}
${EVLA}
${EVDE}
EOF

exit 0
