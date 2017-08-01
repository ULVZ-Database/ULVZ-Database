#!/bin/bash

c++ -std=c++14 1_ProjectRegion.cpp -I${HOME}/Research/Fun.C++.c003 -L${HOME}/Research/Fun.C++.c003 -lASU_tools_cpp -I${HOME}/Research/Fun.C.c002 -L${HOME}/Research/Fun.C.c002 -lASU_tools

[ $? -eq 0 ] && ./a.out


exit 0
