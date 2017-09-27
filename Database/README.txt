
1. File naming:

              Data.Phase.Code.[yes,no,may].[point,line,area]
              ---- ----- ---- ------------ -----------------

  -> "Data.": files without this prefix are regarded as supplementary data.


  -> Phase  : phase used in this study.
		      Including: ScS,PcP,ScP,SKS,SKKS,Sdiff,PKP,PKKP,Pdiff.
		      (SPdKS studies are assigned SKS.)


  -> Code   : meant to distinguish different observations in one study.
		      This could due to different detections, regions, networks, events, etc.


  -> "[yes,no,may]" tells the data in this file is a yes/no/weak ULVZ detections.


  -> "[point,line,area]" tells the data type of this file:


	-- In *.point, each line in the file represents the location of one sampling
	   points. A ">" seperate different subset/groups.


	-- In *.line, two adjacent lines in the file represent the locations of
	   two end points of one diffraction leg. Lines are seperated by ">".


	-- In *area, each line in the data file represents a waypoint. We follow a
	   left-hand-side rule so that when you walk the waypoints line by line,
	   the region lies on your left-hand side. One file may contain several
	   regions, and they are seperated by a ">" character. 


2. The summary for ULVZ properties are in these two files:

	-- ULVZ_DB.MariaDB.sql
	-- ULVZ_DB.MariaDB.txt

	-- "ULVZ_DB.MariaDB.sql" is a direct data dump from MariaDB. To restore
	the database, use:

	$ mysqladmin create ULVZ_DB
	$ mysql ULVZ_DB < ULVZ_DB.MariaDB.sql

	-- "ULVZ_DB.MariaDB.txt" is an ascii format of "ULVZ_DB.MariaDB.sql".


3. For your convenience, here's a list of numbering grouped by phases used
(first column in Table 1 of our paper).
	
	S-diff     : 44,45,54
	P-diff     : 35
	PKKPab_diff: 31
	SKS(SPdKS) : 5,7,11,19,23,25,46,47,52
	PKP        : 6,8,10,14,17,20,32,36,39,48
	Reflection : 1,2,3,4,9,12,13,15,16,18,21,22,24,26,27,28,29,30,33,34,37,38,40,41,42,43,49,50,51,53
