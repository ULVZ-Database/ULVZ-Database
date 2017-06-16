#!/bin/csh

#Script for plotting ULVZ location

pscoast -JX5d/4.2d -R175/205/-30/-5 -Df -P -K -B10g10000f1/10g10000f1nSeW \
 -W2/100/100/100  >! ulvz.ps

#Approximate Location NW ULVZ
psxy -JX -R -P -O -K -W4/100/100/100 -G255/222/173 << eol >> ulvz.ps
180.771 -10.0409
181.646 -9.91497
182.396 -10.1225
183.083 -10.6218
183.521 -11.4547
183.438 -12.3714
183.042 -13.0177
182.292 -13.4976
181.313 -13.6237
180.417 -13.3746
179.708 -12.792
179.458 -11.7506
179.667 -10.8962
180.063 -10.4375
180.771 -10.0409
eol

#Approximate Location W ULVZ
psxy -JX -R -P -O -K -W4/100/100/100 -G255/222/173 << eol >> ulvz.ps
185.646 -17.7233
186.208 -17.4727
187     -17.4302
187.833 -17.7002
188.458 -18.262
188.813 -18.9908
188.729 -19.9493
188.458 -20.512
187.833 -20.9502
186.646 -21.1598
185.833 -20.9523
185.125 -20.3905
184.75  -19.6409
184.771 -18.9117
185.125 -18.1822
185.646 -17.7233
eol

#Approximate Location NE ULVZ
psxy -JX -R -P -O -K -W4/100/100/100 -G255/222/173 << eol >> ulvz.ps
195.604 -7.5046
197.938 -11.0647
199.479 -10.1256
197     -6.35732
195.604 -7.5046
eol

#Primary_Ulvz   
psxy -JX -R -P -O -K -W6/0/0/0 -G205/85/85 << eol >> ulvz.ps
195.021 -24.9635
194.229 -23.3394
193.438 -22.0485
192.563 -20.9244
192.771 -20.0284
192.854 -19.0491
192.729 -17.9034
192.333 -17.4038
191.458 -16.8006
190.313 -16.4476
189.604 -16.3858
188.958 -16.0532
188.396 -15.5954
187.917 -15.0959
190     -10.5313
191.583 -11.3838
193.5   -12.8193
194.583 -13.9223
194.875 -14.797
195.063 -15.4843
195.542 -16.2755
196.208 -16.7123
196.917 -17.2949
197.542 -18.1276
197.75  -18.919
197.729 -19.8149
197.646 -20.8775
197.542 -22.6901
196.458 -24.9829
eol

# in No.51

#Add the Vidale Hedlin strong scatterer box
psxy -JX -R -P -O -K -W3/255/0/0 << eol >> ulvz.ps
170.0 -10.
190.0 -10.
190.0 2.5
170.0 2.5
170.0 -10.0
eol


# in No.47

#Garnero & Vidale ScP points
# no ulvz - white triangle
psxy -JX -R -P -O -K -W1/0/0/0 -G255/255/255 -St.1i << eol >> ulvz.ps
186.653 -10.36781
eol
#weak or noisy - black crosses
psxy -JX -R -P -O -K -W1/0/0/0 -G255/255/255 -Sx.1i << eol >> ulvz.ps
187.446 -6.98299
186.359 -9.13600
179.001 -3.74361
eol
#yes ulvz - black triangle
psxy -JX -R -P -O -K -W1/0/0/0 -G0/0/0 -St.1i << eol >> ulvz.ps
177.586 -9.33835
eol



# in No.44

#Add Reasoner & Revenaugh ScP bpts - NO ULVZ (white circles)
psxy -JX -R -P -O -K -W1/0/0/0 -Sc.1i -G255/255/255 << eol >> ulvz.ps
-172.27 -8.02
-173.25 -11.74
178.94 -5.20
-170.91 -12.66
-173.40 -12.25
156.67 23.44
158.28 20.83
159.33 19.69
157.04 23.60
159.51 20.74
-172.96 -10.84
eol

#Add Reasoner & Revenaugh ScP bpts - YES ULVZ (black circles) #event 950117
psxy -JX -R -P -O -K -W1/0/0/0 -Sc.1i -G0/0/0 << eol >> ulvz.ps
-172.96 -10.84
eol

#Add Reasoner & Revenaugh ScP bpts - Maybe ULVZ (gray circles) #event 951029
psxy -JX -R -P -O -K -W1/0/0/0 -Sc.1i -G100/100/100 << eol >> ulvz.ps
-173.18 -11.51
eol


