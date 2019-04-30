#!/bin/bash

ghdl -a reg_8bit.vhdl
ghdl -a myregister.vhdl
ghdl -a register_tb.vhdl
ghdl -e register_tb
ghdl -r register_tb --vcd=shift_reg.vcd