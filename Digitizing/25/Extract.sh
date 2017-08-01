#!/bin/bash

# Distance selection.
cp papernumber-table1_with_labels.txt tmpfile
# awk '{if (110<=$NF && $NF<115) print $0}' papernumber-table1_with_labels.txt > tmpfile

# Extract.
echo "> SourceSide May" > Data.SKS.wGlobal.may.line
awk '{if ($2=="PLVZ") printf "%.2lf %.2lf\n%.2lf %.2lf\n",$11,$10,$13,$12}' tmpfile >> Data.SKS.wGlobal.may.line
echo "> According ReceiverSide May" >> Data.SKS.wGlobal.may.line
awk '{if ($2=="PLVZ") printf "%.2lf %.2lf\n%.2lf %.2lf\n",$15,$14,$17,$16}' tmpfile >> Data.SKS.wGlobal.may.line

echo "> SourceSide Yes" > Data.SKS.yGlobal.yes.line
awk '{if ($2=="ELVZ" || $2=="ULVZ") printf "%.2lf %.2lf\n%.2lf %.2lf\n",$11,$10,$13,$12}' tmpfile >> Data.SKS.yGlobal.yes.line
echo "> According ReceiverSide Yes" >> Data.SKS.yGlobal.yes.line
awk '{if ($2=="ELVZ" || $2=="ULVZ") printf "%.2lf %.2lf\n%.2lf %.2lf\n",$15,$14,$17,$16}' tmpfile >> Data.SKS.yGlobal.yes.line

echo "> SourceSide No" > Data.SKS.nGlobal.no.line
awk '{if ($2=="PREM") printf "%.2lf %.2lf\n%.2lf %.2lf\n",$11,$10,$13,$12}' tmpfile >> Data.SKS.nGlobal.no.line
echo "> According ReceiverSide No" >> Data.SKS.nGlobal.no.line
awk '{if ($2=="PREM") printf "%.2lf %.2lf\n%.2lf %.2lf\n",$15,$14,$17,$16}' tmpfile >> Data.SKS.nGlobal.no.line

# Format
${HOME}/PROJ/t002.ULVZMap/bin/ConvertLine.out Data.SKS.wGlobal.may.line tmpfile
mv tmpfile Data.SKS.wGlobal.may.line
${HOME}/PROJ/t002.ULVZMap/bin/ConvertLine.out Data.SKS.yGlobal.yes.line tmpfile
mv tmpfile Data.SKS.yGlobal.yes.line
${HOME}/PROJ/t002.ULVZMap/bin/ConvertLine.out Data.SKS.nGlobal.no.line tmpfile
mv tmpfile Data.SKS.nGlobal.no.line

rm -f tmpfile

exit 0
