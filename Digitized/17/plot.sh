#!/bin/bash

cat > yes2.txt << EOF
102.50 67.42
101.88 67.45
101.25 67.45
100.63 67.45
100.00 67.45
99.25  67.45
98.49  67.45
97.74  67.49
96.98  67.45
96.23  67.45
95.47  67.48
94.72  67.49
93.96  67.47
93.37 67.35
92.95 67.16
92.70 66.99
92.96 66.84
92.80 66.69
92.95 66.52
93.20 66.37
93.96 66.2
94.72 66.22
95.47 66.24
96.23 66.26
96.98 66.18
97.74 66.22
98.49 66.18
99.25 66.18
100.00 66.18
100.63 66.18
101.25 66.16
101.88 66.16
102.50 66.14
103.00 66.20
103.27 66.40
103.42 66.67
103.50 66.80
103.25 66.91
103.10 67.08
102.83 67.27
EOF

cat > no.txt << EOF
66.24 56.62
65.70 56.68
65.16 56.64
64.62 56.69
64.07 56.65
63.54 56.61
63.00 56.60
62.82 56.48
62.61 56.36
62.48 56.10
62.30 55.86
62.63 55.63
63.00 55.44
63.50 55.42
64.07 55.47
64.62 55.48
65.16 55.47
65.70 55.51
66.20 55.63
66.28 55.86
66.33 56.11
66.30 56.39
66.27 56.50
EOF

cat > yes.txt << EOF
73.80 56.80
73.24 56.78
72.72 56.78
72.18 56.79
71.64 56.89
71.10 56.86
70.56 56.87
70.02 56.84
69.48 56.82
68.94 56.81
68.38 56.87
67.83 56.83
67.32 56.81
66.78 56.77
66.33 56.65
65.94 56.47
65.77 56.2
65.80 55.94
65.93 55.75
66.34 55.65
66.78 55.56
67.32 55.56
67.81 55.56
68.38 55.58
68.94 55.59
69.48 55.60
70.02 55.62
70.56 55.61
71.10 55.59
71.64 55.58
72.18 55.58
72.72 55.53
73.24 55.55
73.80 55.56
74.32 55.55
74.80 55.57
75.13 55.74
75.39 55.89
75.85 56.19
75.78 56.49
75.40 56.80
74.86 56.87
74.34 56.87
EOF

gmtset PAPER_MEDIA = letter
gmtset ANNOT_FONT_SIZE_PRIMARY = 8p
gmtset LABEL_FONT_SIZE = 9p
gmtset LABEL_OFFSET = 0.1c
gmtset GRID_PEN_PRIMARY = 0.25p,200/200/200


pscoast -R-5/55/25/50 -JA100/63/5i -Ba20f20g10/a10f10g5 -Dh -N1 -A20000 -W1p,green -P -K > tmp.ps
# In Illustrator:
# X: 4.9099 in
# Y: 5.3588 in
# W: 17.4 in


cat no.txt yes.txt yes2.txt > all.txt
head -n 1 no.txt > head.txt
head -n 1 yes.txt >> head.txt
head -n 1 yes2.txt >> head.txt
tail -qn 1 no.txt yes.txt yes2.txt > tail.txt

rm -f Grid.txt
while read X Y
do
	echo "${X} ${Y}" | awk '{printf ">\n%.2lf %.2lf\n%.2lf %.2lf\n>\n%.2lf %.2lf\n%.2lf %.2lf\n",$1-0.5,$2,$1+0.5,$2,$1,$2-0.5,$1,$2+0.5}' >> Grid.txt
done < all.txt

psxy -J -R Grid.txt -W0.1p,black -m -O -K >> tmp.ps

psxy -J -R no.txt -m -W0.2p,blue,faint -L -O -K >> tmp.ps
psxy -J -R no.txt -Sc0.005i -m -Gblue -Wblue -O -K >> tmp.ps

psxy -J -R yes.txt -m -W0.2p,red,faint -L -O -K >> tmp.ps
psxy -J -R yes.txt -Sc0.005i -m -Gred -Wred -O -K >> tmp.ps
psxy -J -R yes2.txt -m -W0.2p,red,faint -L -O -K >> tmp.ps
psxy -J -R yes2.txt -Sc0.005i -m -Gred -Wred -O -K >> tmp.ps

psxy -J -R head.txt -Sc0.005i -m -Ggreen -Wgreen -O -K >> tmp.ps
psxy -J -R tail.txt -Sc0.005i -m -Gpurple -Wpurple -O >> tmp.ps

exit 0
