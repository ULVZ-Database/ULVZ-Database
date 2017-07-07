#!/bin/bash

# Run under ULVZ-Database/GoogleEarth/MakeKML/

OUTFILE="GoogleEarthView.kml"
rm -f ${OUTFILE}

# 1. Header

cat > ${OUTFILE} << EOF
<?xml version="1.0" encoding="UTF-8"?> 
<kml xmlns="http://earth.google.com/kml/2.0"> 

<Document>

	<name>ULVZs</name>

EOF

# 2. Database (raw)

rm -f tmpfile1_$$
for file in `find ../../Database -name "Data.*"`
do
	Ref=`echo ${file} | awk 'BEGIN {FS="/"} {print $4}'`
	Ref=${Ref#No.}
	FILE=`basename ${file}`
	Type=`echo ${FILE} | awk 'BEGIN {FS="."} {print $4}'`
	DataType=`echo ${FILE} | awk 'BEGIN {FS="."} {print $5}'`

	echo "${Ref} ${Type} ${DataType} ${file}" >> tmpfile1_$$
done
sort -gk1,1 tmpfile1_$$ > tmpfile_$$

# 2.1 header
cat >> ${OUTFILE} << EOF
	<Document>

		<name>Database</name>
EOF

# 2.2. each file
while read Ref Type DataType filename
do

	[ ${Type} = "yes" ] && Color=ff0000ff
	[ ${Type} = "no"  ] && Color=ffff0000
	[ ${Type} = "may" ] && Color=ff00ffff

	if [ -z "${Begin1[${Ref}]}" ]
	then
		Begin1[${Ref}]=1

		if [ ${Ref} -ne 1 ]
		then
			cat >> ${OUTFILE} << EOF

		</Folder>

EOF
		fi

		PaperName=`awk 'BEGIN {FS="|"} {print $2,$8}' ../../Database/ULVZ_DB.MariaDB.txt | grep -w ${Ref} | head -n 1`

		cat >> ${OUTFILE} << EOF
		<Folder>

			<name>${PaperName}</name>

EOF
	fi


	grep -n ">" ${filename} | awk 'BEGIN {FS=":"} {print $1}' > tmpfile_lines 
	wc -l < ${filename} | awk '{print $1+1}' >> tmpfile_lines

	Cnt=0
	A=0
	rm -f tmpfile_raw_*
	while read B
	do
		awk -v l1=${A} -v l2=${B} '{if (NR>l1 && NR<l2) print $1,$2}' ${filename} > tmpfile_raw_${Cnt}
		A=${B}
		Cnt=$((Cnt+1))
	done < tmpfile_lines


	for file in tmpfile_raw_*
	do
		! [ -s ${file} ] && continue

		if [ ${DataType} = "area" ]
		then

			cat >> ${OUTFILE} << EOF

			<Placemark><Style><LineStyle>
				<color>00000000</color>
				<width>1</width>
				</LineStyle><PolyStyle>
				<colorMode>normal</colorMode>
				<color>${Color}</color>
				<fill>1</fill>
				</PolyStyle></Style><Polygon><outerBoundaryIs><LinearRing><coordinates>
EOF
			Flag=`minmax -C ${file} | awk '{if ($1<-150) print 1; else print 0}'`

			if [ ${Flag} -eq 1 ]
			then
				awk '{if ($1<0) $1+=360; print $1","$2}' ${file} >> ${OUTFILE}
			else 
				awk '{print $1","$2}' ${file} >> ${OUTFILE}
			fi

			cat >> ${OUTFILE} << EOF
				</coordinates></LinearRing></outerBoundaryIs></Polygon></Placemark>

EOF
		elif [ ${DataType} = "point" ]
		then
			while read lon lat
			do
				lon=`echo ${lon} | awk '{if ($1>180) $1-=360; print $1}'`
				cat >> ${OUTFILE} << EOF

			<Placemark><Style><IconStyle>
					<color>${Color}</color>
					<colorMode>normal</colorMode>
					<scale>0.6</scale>
					<Icon><href>http://maps.google.com/mapfiles/kml/shapes/shaded_dot.png</href></Icon>
					</IconStyle></Style><Point><coordinates>
${lon},${lat}
			</coordinates></Point></Placemark>

EOF
			done < ${file}
		else

			cat >> ${OUTFILE} << EOF

			<Placemark><Style><LineStyle>
				<color>${Color}</color>
				<width>2</width>
				</LineStyle></Style><LineString>
				<tessellate>1</tessellate>
				<extrude>1</extrude>
				<altitudeMode>clampedToGround</altitudeMode>
				<coordinates>
EOF
			Flag=`minmax -C ${file} | awk '{if ($1<-150) print 1; else print 0}'`
			if [ ${Flag} -eq 1 ]
			then
				awk '{if ($1<0) $1+=360; print $1","$2}' ${file} >> ${OUTFILE}
			else 
				awk '{print $1","$2}' ${file} >> ${OUTFILE}
			fi
			
			cat >> ${OUTFILE} << EOF
				</coordinates></LineString></Placemark>

EOF

		fi
	done
done < tmpfile_$$


cat >> ${OUTFILE} << EOF

		</Folder>

	</Document>

EOF


# 3. FresnelZoneAdded

ls ../../FresnelZoneAdded/* > tmpfile_$$
rm -f tmpfile1_$$
while read filename
do
	File=`basename ${filename}`
	Ref=`echo ${File} | awk 'BEGIN {FS="."} {print $1}'`
	Type=`echo ${File} | awk 'BEGIN {FS="."} {print $2}'`
	echo ${Ref} ${Type} ${filename} >> tmpfile1_$$
done < tmpfile_$$
sort -gk1,1 tmpfile1_$$ > tmpfile_$$

# 3.1. header
cat >> ${OUTFILE} << EOF
	<Document>

		<name>FresnelZoneAdded</name>

EOF

# 3.2. each study
while read Ref Type filename
do

	[ ${Type} = "yes" ] && FillColor=7f0000ff
	[ ${Type} = "no"  ] && FillColor=7fff0000
	[ ${Type} = "may" ] && FillColor=7f00ffff

	if [ -z "${Begin[${Ref}]}" ]
	then
		Begin[${Ref}]=1

		if [ ${Ref} -ne 1 ]
		then
			cat >> ${OUTFILE} << EOF

		</Folder>

EOF
		fi

		PaperName=`awk 'BEGIN {FS="|"} {print $2,$8}' ../../Database/ULVZ_DB.MariaDB.txt | grep -w ${Ref} | head -n 1`

		cat >> ${OUTFILE} << EOF
		<Folder>

			<name>${PaperName}</name>

EOF
	fi


	grep -n ">" ${filename} | awk 'BEGIN {FS=":"} {print $1}' > tmpfile_lines 
	wc -l < ${filename} | awk '{print $1+1}' >> tmpfile_lines

	Cnt=0
	A=0
	rm -f tmpfile_fresnel_*
	while read B
	do
		awk -v l1=${A} -v l2=${B} '{if (NR>l1 && NR<l2) print $1,$2}' ${filename} > tmpfile_fresnel_${Cnt}
		A=${B}
		Cnt=$((Cnt+1))
	done < tmpfile_lines


	for file in tmpfile_fresnel_*
	do
		! [ -s ${file} ] && continue

		cat >> ${OUTFILE} << EOF

			<Placemark><Style><LineStyle>
				<color>00000000</color>
				<width>1</width>
				</LineStyle><PolyStyle>
				<colorMode>normal</colorMode>
				<color>${FillColor}</color>
				<fill>1</fill>
				</PolyStyle></Style><Polygon><outerBoundaryIs><LinearRing><coordinates>
EOF
		Flag=`minmax -C ${file} | awk '{if ($1<-150) print 1; else print 0}'`

		if [ ${Flag} -eq 1 ]
		then
			awk '{if ($1<0) $1+=360; print $1","$2}' ${file} >> ${OUTFILE}
		else 
			awk '{print $1","$2}' ${file} >> ${OUTFILE}
		fi

		cat >> ${OUTFILE} << EOF
				</coordinates></LinearRing></outerBoundaryIs></Polygon></Placemark>

EOF
	done

done < tmpfile_$$

cat >> ${OUTFILE} << EOF

		</Folder>

EOF

# 4. The End
cat >> ${OUTFILE} << EOF
	</Document>

</Document>
</kml>
EOF

# Clean up.
rm -f tmpfile*

exit 0
