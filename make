#!/bin/bash

ghdl -a reg_8bit.vhdl
ghdl -a myregister.vhdl
ghdl -a register_tb.vhdl
ghdl -e register_tb
ghdl -r register_tb --vcd=register.vcd
#ghdl -a reg_8bit_tb.vhdl
#ghdl -e reg_8bit_tb
#ghdl -r reg_8bit_tb --vcd=flipflop.vcd
ghdl -a disp.vhdl
ghdl -a disp_tb.vhdl
ghdl -e disp_tb
ghdl -r disp_tb --vcd=disp.vcd
