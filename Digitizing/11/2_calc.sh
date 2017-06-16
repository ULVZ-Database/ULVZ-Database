#!/bin/bash

# YKA
stlo=-114.6053
stla=62.4932

# rm -f line_no
# while read evlo evla
# do
# 	taup_path -sta ${stla} ${stlo} -evt ${evla} ${evlo} -ph P,Pdiff -mod prem -o stdout | awk '{ if ($2<3481) print $0}' > tmpfile_$$
# 	head -n 1 tmpfile_$$ | awk '{print $4,$3}' >> line_no
# 	tail -n 1 tmpfile_$$ | awk '{print $4,$3}' >> line_no
# 	echo ">" >> line_no
# 
# done < Event_No

echo ""
rm -f line_yes line_yes_calc
while read evlo evla
do
	taup_path -sta ${stla} ${stlo} -evt ${evla} ${evlo} -ph P,Pdiff -mod prem -o stdout | awk '{ if ($2<3510) print $0}' > tmpfile_$$

	head -n 1 tmpfile_$$ | awk '{print $4,$3}' >> line_yes
	tail -n 1 tmpfile_$$ | awk '{print $4,$3}' >> line_yes
	head -n 1 tmpfile_$$ | awk '{print $4,$3}' >> line_yes_calc
	tail -n 1 tmpfile_$$ | awk '{print $4,$3}' >> line_yes_calc

	echo ">" >> line_yes
done < Event_Yes

rm -f tmpfile_$$

c++ -std=c++14 MakeRegion.cpp
./a.out

exit 0
