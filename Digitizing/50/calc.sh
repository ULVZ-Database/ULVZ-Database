#!/bin/bash

# No ULVZ:
taup_path -sta 34.697 -117.595 -evt 38.625 141.164   -h 104 -ph PcP -mod prem -o stdout | grep 3480 | awk '{print $4,$3}'

# Yes ULVZ:
taup_path -sta 34.697 -117.595 -evt -22.180 -179.575 -h 104 -ph PcP -mod prem -o stdout | grep 3480 | awk '{print $4,$3}'
taup_path -sta 34.697 -117.595 -evt -22.427 -179.565 -h 104 -ph PcP -mod prem -o stdout | grep 3480 | awk '{print $4,$3}'


exit 0
