Joseph Daniel Moreno, U#60156204 ||
				 ||
FPGA A3 Simulation Explanation	 ||
==================================

Both problem 1 and 2 are in a single project:
gt2.vhdl and bcd_2_bin.vhdl.

I have 3 folders in the sources window under simulation sources:
sim_1, sim_2, and sim_3.

To run each simulation, I right-clicked their respective folder
and ran a behavioural simulation.

***
sim_1 has the gt2 gate-level architecture testbench as the top module.
I tested all 16 possible inputs.

test_a is the first 2-bit input and test_b is the second 2-bit input.

test_agtb is the 1-bit output.

***
sim_2 has the gt2 structural architecture testbench as the top module.
The input and output names are the same as in sim_1.

***
sim_3 has the bcd_2_bin testbench as the top module.
I have 8 test input vectors; 5 valid and 3 invalid.

test_bcdIn1 is the tens digit of the BCD input.

test_bcdIn0 is the ones digit of the BCD input.

test_binIn is the initial binary input, which is always be b"0000000".

test_bcdOut1 and test_bcdOut0 are the final BCD output,
which will always be x"0" and x"0" since their bits are shifted into
the binary output.

test_binOut is the final output which is the binary conversion
from the BCD input.

To handle illegal inputs, I created a design source called
invalid_compare.vhdl. The design takes each BCD digit and compares
them to 9; if either are > 9, output 1. Else, output 0. Using this
design in bcd_2_bin.vhdl, when the comparator outputs 1, the final
binary number will always be b"0000000".

I commented my test input vectors in bcd_2_bin's testbench VHDL file.