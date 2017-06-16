#!/bin/bash


# Hawaii station center:
STLO="-155.369"
STLA="19.379"

# ScP bounce point for event 950117 (Post-cursor).
taup_path -evt -20.9 180.8 -sta ${STLA} ${STLO} -ph ScP -h 637 -mod prem -o stdout | grep 3480 | awk '{print $4,$3}' > Data_ScP.TF.yes.point

# ScP bounce point for event 950129 (Probable post-cursor).
taup_path -evt -21.7 180.5 -sta ${STLA} ${STLO} -ph ScP -h 611 -mod prem -o stdout | grep 3480 | awk '{print $4,$3}' > Data_ScP.TF.may.point

# ScP bounce point for TF other events (no post-cursor).
rm -f Data_ScP.TF.no.point
while read EVLA EVLO EVDP
do
	taup_path -evt ${EVLA} ${EVLO} -sta ${STLA} ${STLO} -ph ScP -h ${EVDP} -mod prem -o stdout | grep 3480 | awk '{print $4,$3}' >> Data_ScP.TF.no.point
done << EOF
-17.8 181.5 564
-22.0 180.4 591
-13.4 170.4 640
-24.1 183.0 111
-22.6 180.2 575
EOF

# ScP bounce point for MAR events (no post-cursor).
rm -f Data_ScP.MAR.no.point
while read EVLA EVLO EVDP
do
	taup_path -evt ${EVLA} ${EVLO} -sta ${STLA} ${STLO} -ph ScP -h ${EVDP} -mod prem -o stdout | grep 3480 | awk '{print $4,$3}' >> Data_ScP.MAR.no.point
done << EOF
21.8 142.6 319
18.9 145.2 596
17.4 145.5 149
22.0 142.8 241
18.7 145.6 177
EOF

exit 0
