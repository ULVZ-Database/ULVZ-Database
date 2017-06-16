#!/bin/bash

OUTFILE=tmp.ps

PROJ="-JG165/30/6i"
REG="-Rg"

pscoast ${REG} ${PROJ} -Dl -A40000 -W0.3p,green -P -K > ${OUTFILE}
# In Illustrator:
# X: 257.156 mm
# Y: 124.142 mm
# W: 410 mm

psbasemap ${REG} ${PROJ} -Bg50/g50 -O -K >> ${OUTFILE}

# Bouncing pionts
psxy ${REG} ${PROJ} -Sc0.02i -Gblue -Wblue -O -K >> ${OUTFILE} << EOF
129 10.5
EOF

# Event center.
psxy ${REG} ${PROJ} -Sc0.02i -Gblue -Wblue -O -K >> ${OUTFILE} << EOF
127.21 0.07
EOF

# Station center.
psxy ${REG} ${PROJ} -Sc0.02i -Ggreen -Wgreen -O -K >> ${OUTFILE} << EOF
133.51 34.226
EOF

# Seal.
psxy ${REG} ${PROJ} -O >> ${OUTFILE} << EOF
EOF

exit 0
