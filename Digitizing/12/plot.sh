#!/bin/bash

CLON=230
CLAT=10
OUTFILE=tmp.ps

PROJ="-JG${CLON}/${CLAT}/6i"
REG="-R-180/180/-90/90"

pscoast ${REG} ${PROJ} -Dl -A40000 -W2,gray,faint -P -K > ${OUTFILE}
psbasemap ${REG} ${PROJ} -Bg360/g180 -O -K >> ${OUTFILE}
# Illustrator:
# X: 5.4962 in
# Y: 4.2515 in
# W: 7.55   in

cat > ULVZ_No << EOF 
274.3   1.2
272.5   1.65
271.5   1.4
270.75  2.25
270.75  3.2
270.6   4.1
269.1 5.2
268.4 6.45
267.7 7.75
267.9 9
268.4 10.7
267.8 12.6
268.05 13.35
267.65 14.55
268.4  14.9
269    13.75
268.85 12.85
269.15 11.6
269.2  10.1
270.4  9.15
271.3  8
271.8  6.75
271.05   6
270.75  4.95
272     4
272.9   3.75
272.7   2.75
274.2 2.25
269.4 7.8
270.2 6.6
EOF

rm -f Grid.txt
while read X Y
do
    echo "${X} ${Y}" | awk '{printf ">\n%.2lf %.2lf\n%.2lf %.2lf\n>\n%.2lf %.2lf\n%.2lf %.2lf\n",$1-0.5,$2,$1+0.5,$2,$1,$2-0.5,$1,$2+0.5}' >> Grid.txt
done < ULVZ_No

psxy -J -R Grid.txt -W0.5p,black -m -O -K >> ${OUTFILE}

# Event center.
psxy -J -R -W0.5p,red -m -O -K >> ${OUTFILE} << EOF
292.64 -22.58
293.64 -22.58
>
293.14 -22.08
293.14 -23.08
EOF
# 293.14 -22.58

# Station center.
psxy -J -R -W0.5p,red -m -O -K >> ${OUTFILE} << EOF
238.17 37.78
239.17 37.78
>
238.67 37.28
238.67 38.28
EOF
# 238.67 37.78

psxy ${REG} ${PROJ} ULVZ_No -Sa0.025i -Wfaint,red -Gred -O >> ${OUTFILE}

exit 0
