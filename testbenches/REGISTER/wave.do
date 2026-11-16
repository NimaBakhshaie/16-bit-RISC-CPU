onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -label "clk" -radix binary sim:/testbench/clk
add wave -label "resetn" -radix binary sim:/testbench/resetn
add wave -divider "ports"
add wave -label "R3" -radix unsigned sim:/testbench/R3
add wave -label "WR3" -radix decimal sim:/testbench/WR3
add wave -label "R1" -radix unsigned sim:/testbench/R1
add wave -label "DR1" -radix decimal sim:/testbench/DR1
add wave -label "R2" -radix unsigned sim:/testbench/R2
add wave -label "DR2" -radix decimal sim:/testbench/DR2
add wave -divider "Registers"
add wave -label "R0" -radix decimal sim:/testbench/dut/r0
add wave -label "R1" -radix decimal sim:/testbench/dut/r1
add wave -label "R2" -radix decimal sim:/testbench/dut/r2
add wave -label "R3" -radix decimal sim:/testbench/dut/r3
add wave -label "R4" -radix decimal sim:/testbench/dut/r4
add wave -label "R5" -radix decimal sim:/testbench/dut/r5
add wave -label "R6" -radix decimal sim:/testbench/dut/r6
add wave -label "R7" -radix decimal sim:/testbench/dut/r7

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 80
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {120 ns}
