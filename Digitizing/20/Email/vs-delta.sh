#!/bin/zsh -f

ps=vs-delta.ps

gmtset BASEMAP_TYPE fancy FRAME_WIDTH 0.15c PAPER_MEDIA A4 ANOT_FONT 0 ANOT_FONT_SIZE 15 LABEL_FONT 0 LABEL_FONT_SIZE 17 PLOT_DEGREE_FORMAT D MEASURE_UNIT inch CHAR_ENCODING Standard+

size=6
reg=-R/100/175/-35/20
pj=-JM$size
anot=-Ba20g10WSne

psbasemap $pj $reg $anot -K -V -Y2.0 >! $ps
pscoast $pj -R -A10000 -Dl -W1 -V -K -O -N1 -G200 >>$ps
awk '{print $2,$1}' hinscp.nondtctd | psxy $pj -R -K -O -V -Sx0.1 -W3/0/0/255 >>$ps 

awk '{print $2,$1}' imsscp.nondtctd | psxy -JM -R -K -O -V -Sx0.1 -W3/0/0/255 >> $ps
awk '{print $2,$1,$3*(-0.01)}' scsp_detected.dat | psxy -JM -R -K -O -V -Sc -W4/255/0/0 >>$ps

echo "0.5 0.75 -40" | awk '{print $1,$2,$3*(-0.01)}' | psxy -JX${size}/${size} -R0/10/0/10 -K -O -Sc -V -W4/255/0/0 >>$ps
echo "1.15 0.75 -30" | awk '{print $1,$2,$3*(-0.01)}' | psxy -JX${size}/${size} -R -K -O -Sc -V -W4/255/0/0 >>$ps
echo "1.65 0.75 -20" | awk '{print $1,$2,$3*(-0.01)}' | psxy -JX${size}/${size} -R -K -O -Sc -V -W4/255/0/0 >>$ps
echo "2 0.75 -10" | awk '{print $1,$2,$3*(-0.01)}' | psxy -JX${size}/${size} -R -K -O -Sc -V -W4/255/0/0 >>$ps

echo "0.5  0.3  10 0 4 CT -40%" | pstext -JX -R -K -O -V >>$ps
echo "1.15 0.3  10 0 4 CT -30%" | pstext -JX -R -K -O -V >>$ps
echo "1.65 0.3  10 0 4 CT -20%" | pstext -JX -R -K -O -V >>$ps
echo "2.0 0.3  10 0 4 CT -10%" | pstext -JX -R -K -O -V  >>$ps

echo "2.25 0.75 14 0 4 LM dlnVS evaluated by ScsP/ScP " | pstext -JX -R -K -O -V -W255  >>$ps

pstext -R0/1/0/1 -JX1 -O < /dev/null >>$ps
