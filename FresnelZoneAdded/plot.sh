#!/bin/bash

# This script uses gmt-4 for plotting. (xyz2grd & grdimage)
# This script uses (ps2pdf) convert post-script file to pdf file.

# We will plot All.yes.grd.txt as an example.
# This file has 3 columns: longitude/latitude/mark(0 or 1)
# Grid increment is 0.5 deg in both directions.
file="All.yes.grd.txt"

# color plate file.
# 255 0 0     means plot 1 in red.
# 255 255 255 means plot 0 in white.
cat > tmp.cpt << EOF
0   255 255 255 1 255 0 0
B   255 255 255
F   255 0 0
N   128 128 128
EOF

xyz2grd ${file} -R-179.75/179.75/-89.75/89.75 -Gtmp.grd -I0.5/0.5

grdimage tmp.grd -JR137/9i -Rg -B0 -Ctmp.cpt > plot.ps

ps2pdf plot.ps

# Clean up.
rm -f tmp.grd tmp.cpt .gmt*

exit 0
