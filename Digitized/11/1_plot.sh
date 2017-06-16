#!/bin/bash

c++ -std=c++14 waypoint_az.cpp

CLON=155
CLAT=30
OUTFILE=tmp.ps

PROJ="-JG${CLON}/${CLAT}/6i"
REG="-Rg"

pscoast ${REG} ${PROJ} -Dl -A40000 -W2,gray,faint -P -K > ${OUTFILE}
psbasemap ${REG} ${PROJ} -Bg360 -O -K >> ${OUTFILE}
# Illustrator:
# X: 312.532 pt
# Y: 432.087 pt
# W: 437.066 pt

# Yellow knife station.
psxy ${REG} ${PROJ} -St0.15i -Gblack -O -K >> ${OUTFILE} << EOF
-114.6053  62.4932
EOF

# ULVZ Points:
cat > ULVZ_Yes << EOF
`./a.out 290   53.1`
`./a.out 285.3 51  `
`./a.out 280.4 50  `
`./a.out 274.9 49.8`
`./a.out 271.3 49  `
EOF

# None detection Points:
# cat > ULVZ_No << EOF
# `./a.out 308.7 58.6`
# `./a.out 314.1 58.6`
# `./a.out 333 51.2`
# EOF

# ULVZ Events:
cat > Event_Yes << EOF
`./a.out 290 106`
`./a.out 285.3 101.5`
`./a.out 280.4 99.5`
`./a.out 274.9 98.8`
`./a.out 271.3 98`
EOF

# # None detection Events:
# cat > Event_No << EOF
# `./a.out 308.7 116.5`
# `./a.out 314.1 117`
# `./a.out 333 102.4`
# EOF

psxy ULVZ_Yes ${REG} ${PROJ} -Sc0.01i -Gblack -O -K >> ${OUTFILE}
# psxy ULVZ_No ${REG} ${PROJ} -Sc0.01i -Ggreen -O -K >> ${OUTFILE}
psxy Event_Yes ${REG} ${PROJ} -Sc0.01i -Gred -O -K >> ${OUTFILE}
# psxy Event_No ${REG} ${PROJ} -Sc0.01i -Gblue -O -K >> ${OUTFILE}

psxy -J -R -O >> ${OUTFILE} << EOF
EOF


cat > ULVZ_Sampling_BAZ_Dist << EOF
290   53.1
285.3 51  
280.4 50  
274.9 49.8
271.3 49  
EOF

# c++ MakeRegion.cpp
# ./a.out

exit 0
