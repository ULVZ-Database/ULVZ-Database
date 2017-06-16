#!/bin/bash

OUTFILE=tmp.ps

PROJ="-JG6/-35/6i"
REG="-R-180/180/-90/90"

pscoast ${REG} ${PROJ} -Dl -A40000 -W1p,green -P -K > ${OUTFILE}
# In Illustrator:
# X: 107.309 mm
# Y: 140.381 mm
# W: 182.18  mm

psbasemap ${REG} ${PROJ} -Bg30/g15 -O -K >> ${OUTFILE}

# Area.
psxy ${REG} ${PROJ} -Sc0.01i -Gred -Wred -O -K >> ${OUTFILE} << EOF
0 -46
-0.8 -50.8
2.7 -51
5.25 -49.6
8 -46
12 -41
11 -40.3
7.5 -40.1
5 -40.5
4 -42
2.63 -47.8
4 -46
8 -41.5
6 -44
2 -44
EOF

psxy ${REG} ${PROJ} -St0.02i -Gblue -Wblue -L -O -K >> ${OUTFILE} << EOF
27.5 -25
EOF

psxy ${REG} ${PROJ} -Sa0.02i -Gred -Wred -L -O -K >> ${OUTFILE} << EOF
-28 -58
EOF

# Seal.
psxy ${REG} ${PROJ} -O >> ${OUTFILE} << EOF
EOF

# # Area.
# psxy ${REG} ${PROJ} -W1p,red -L -O -K >> ${OUTFILE} << EOF
# 0 -45
# 0 -50
# 2 -50
# 10 -45
# 10 -40
# 5 -40
# 0 -45
# EOF
# 

exit 0
