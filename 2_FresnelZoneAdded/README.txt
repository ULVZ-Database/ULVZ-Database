
1. File naming:

              Ref.[yes,no,may].grd.txt
              --- ------------

  -> Ref    : Reference numbering.
              Increment by year of publication.

			  "All" means all studies of the same detection kind are merged onto one grid.
			  "Reflection" means only reflection studies are merged.


  -> "[yes,no,may]" tells the data in this file is a yes/no/weak ULVZ detections.


2. File format.

	Grid Center Longitude / Grid Center Latitude / Mark

	Mark = 0 : background.
	Mark = 1 : this cell has the study information.
			   (these cells are colored in plot.pdf)

	Grid size: 0.5 degree at both directions.
	Grid dimension: -179.75 ~ 179.75 in longitude direction.
	                -89.75  ~ 89.75  in latitude direction.

3. plot.sh

	An plotting example reproduce ULVZs in Figure 7a.
