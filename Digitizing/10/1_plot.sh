#!/bin/bash

# EU
pscoast -R0/70/30/80 -JL35/90/30/60/5i -Ba20f20g5/a10f10g5 -Dh -N1 -A20000 -W1p,green -P -K > tmp.ps

# In Illustrator:
# X: 108.866 mm
# Y: 159.541 mm
# W: 267     mm

rm -f tmpfile_$$
for c2 in `seq 62 -0.5 52`
do
	for c1 in `seq 20 0.5 40`
	do
		echo "${c1} ${c2}" >> tmpfile_$$
	done
done

psxy tmpfile_$$ -J -R -Sc0.005i -Gblue -O -K >> tmp.ps

psxy 1_Area.area -J -R -L -W1p,yellow -O -K >> tmp.ps

psxy -J -R -O >> tmp.ps << EOF
EOF

rm -f tmpfile_$$

exit 0
