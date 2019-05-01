#!/bin/bash

ghdl -a reg_8bit.vhdl
ghdl -a myregister.vhdl
ghdl -a disp.vhdl
ghdl -a decoder.vhdl
ghdl -a fulladder.vhdl
ghdl -a addsub.vhdl
ghdl -a alu.vhdl
ghdl -a jumpsel.vhdl
ghdl -a reg_8bit.vhdl
ghdl -a myregister.vhdl
ghdl -a bigcalc.vhdl
ghdl -a bigcalc_tb.vhdl
ghdl -e bigcalc_tb
ghdl -r bigcalc_tb --vcd=bigcalc.vcd
