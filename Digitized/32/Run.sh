#!/bin/bash

while read evdp deg
do
	taup_path -mod prem -ph ScP -h ${evdp} -deg ${deg} -o stdout | awk 'NR>1 {print $0}' | grep 3480
done << EOF
506  42.58
539  42.59
518  42.63
515  42.65
534  42.77
456  42.87
531  42.60
EOF
exit 0
