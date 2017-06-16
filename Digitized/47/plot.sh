#!/bin/bash


gmtset PAPER_MEDIA = letter
gmtset ANNOT_FONT_SIZE_PRIMARY = 8p
gmtset LABEL_FONT_SIZE = 9p
gmtset LABEL_OFFSET = 0.1c
gmtset GRID_PEN_PRIMARY = 0.25p,200/200/200

pscoast -Rg -JG175/-5/5i -Bg30/g30 -Dh -N1 -A20000 -W1p,green -P -K > tmp.ps
# In Illustrator:
# X: 107.976 mm
# Y: 140.539 mm
# W: 162.5 mm

rm -f Grid.txt
while read X Y
do
	echo "${X} ${Y}" | awk '{printf ">\n%.2lf %.2lf\n%.2lf %.2lf\n%.2lf %.2lf\n%.2lf %.2lf\n%.2lf %.2lf\n",$1-1,$2-1,$1-1,$2+1,$1+1,$2+1,$1+1,$2-1,$1-1,$2-1}' >> Grid.txt
done << EOF
170 -14
-178 -18
EOF

psxy -J -R Grid.txt -W0.1p,black -L -m -O -K >> tmp.ps

# Events.
psxy -J -R -Sa0.01i -Gred -Wred -O -K >> tmp.ps << EOF
-179.30 -22.05
142.18 21.43
168.95 -19.42
170 -14
-178 -18
EOF

# Hawaii center.
psxy -J -R -St0.01i -Gblue -Wblue -O -K >> tmp.ps << EOF
-158.369 21.379
EOF

# may
psxy -J -R -Sc0.01i -Gyellow -Wyellow -O -K >> tmp.ps << EOF
187.446 -6.98299
186.359 -9.13600
179.001 -3.74361
EOF

# no 
psxy -J -R -Sc0.01i -Gblue -Wblue -O -K >> tmp.ps << EOF
186.653 -10.36781
156 23.75
EOF


# yes
psxy -J -R -Sc0.01i -Gred -Wred -O >> tmp.ps << EOF
177.586 -9.33835
EOF


exit 0
