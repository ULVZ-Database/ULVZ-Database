
1. File naming:

	          Data.Phase.Code.[yes,no,may].[point,line,area]
	  	      ---- ----- ---- ------------ -----------------

              A ">" character at the beginning of a line means comment.


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


2. A list of study numbers. Numbering is not continuous because some
   collected studies are excluded from the database either because their
   main focus int the paper was not ULVZ, or the provided figures were too
   vague to digitize.

1
2
3
4
5
6
7
9
11
12
13
14
15
16
17
18
19
20
21
22
24
25
26
28
30
32
33
34
35
36
37
38
40
42
44
46
47
48
49
50
51
52
53
55
56
62
64
65
67
70
72
73
74

10. Waveform, reflection, yes:

3
4
5
6
12
13
17
19
22
26
28
32
33
35
44
47
55
56
62
65
70
73
74

11. Sdiff,Pdiff,PKKPdiff

2
9
11
24

12. SPdKS, SKPdS.

1
7
16
18
36
40
50
52
72

13. PKP.

14
15
25
34
37
46
48
51
53
