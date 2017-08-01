#!/bin/bash

# Use taup to grid-search the PKPab-bc critical distance for depth of each event.
EVDP=57
DEG=144.927
taup_path -ph PKP -h ${EVDP} -deg ${DEG} -mod prem -o stdout | grep ">"

# Use this critical distance to get the PKPbc b-caustic point gcp distance.
taup_path -ph PKP -h ${EVDP} -deg ${DEG} -mod prem -o stdout | grep "3480"

# Then use the waypoint program to calculate the b-caustic point location.
gcc 2_waypoint.c -lm

exit 0
