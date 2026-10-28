#!/bin/sh
set -e

# Remove previous simulation files
rm -rf obj_dir
rm -f sigdelay.vcd

# Convert SystemVerilog into C++
verilator -Wall --cc --trace \
    --top-module sigdelay \
    sigdelay.sv counter.sv ram.sv \
    --exe sigdelay_tb.cpp

# Compile the generated C++ code
make -j -C obj_dir -f Vsigdelay.mk Vsigdelay

# Run the simulation
./obj_dir/Vsigdelay
