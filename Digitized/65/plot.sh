#!/bin/bash


gmtset PAPER_MEDIA = letter
gmtset ANNOT_FONT_SIZE_PRIMARY = 8p
gmtset LABEL_FONT_SIZE = 9p
gmtset LABEL_OFFSET = 0.1c
gmtset GRID_PEN_PRIMARY = 0.25p,200/200/200

pscoast -R-5/55/25/50 -JE30/60/5i -Ba20f20g10/a10f10g5 -Dh -N1 -A20000 -W1p,green -P -K > tmp.ps
# In Illustrator:
# X: 3.6184 in
# Y: 4.5399 in
# W: 34.45 in

rm -f Grid.txt
while read X Y
do
	echo "${X} ${Y}" | awk '{printf ">\n%.2lf %.2lf\n%.2lf %.2lf\n%.2lf %.2lf\n%.2lf %.2lf\n%.2lf %.2lf\n",$1-1,$2-1,$1-1,$2+1,$1+1,$2+1,$1+1,$2-1,$1-1,$2-1}' >> Grid.txt
done << EOF
44.5 54.9
49 52.5
1.75 48.75
13.25 44.35
19.25 47.9
30.25 50.5
45 47
24 63
EOF

psxy -J -R Grid.txt -W0.1p,black -L -m -O -K >> tmp.ps

psxy -J -R -Sc0.005i -Gblue -Wblue -O -K >> tmp.ps << EOF
1.75 48.75
13.25 44.35
19.1 47.9
30 50.5
45 47
24 63
EOF

psxy -J -R -Sc0.005i -Gred -Wred -O >> tmp.ps << EOF
44.5 54.9
49 52.5
EOF

exit 0
