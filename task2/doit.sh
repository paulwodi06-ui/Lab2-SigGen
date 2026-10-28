#!/bin/sh
set -e

# Remove previous simulation files
rm -rf obj_dir
rm -f sinegen.vcd

# Convert SystemVerilog into C++
verilator -Wall --cc --trace \
    --top-module sinegen \
    sinegen.sv counter.sv rom.sv \
    --exe sinegen_tb.cpp

# Compile the generated C++ code
make -j -C obj_dir -f Vsinegen.mk Vsinegen

# Run the simulation
./obj_dir/Vsinegen
