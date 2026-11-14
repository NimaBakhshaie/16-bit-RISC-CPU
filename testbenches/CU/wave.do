onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk -radix binary /testbench/clk
add wave -noupdate -label instr -radix binary /testbench/instr
add wave -noupdate -divider CU
add wave -noupdate -label alu_opcode -radix binary /testbench/CU/alu_opcode
add wave -noupdate -label R1 -radix binary /testbench/CU/R1
add wave -noupdate -label R2 -radix binary /testbench/CU/R2
add wave -noupdate -label R3 -radix binary /testbench/CU/R3
add wave -noupdate -label increment -radix binary /testbench/CU/increment
add wave -noupdate -label immFlag -radix binary /testbench/CU/immFlag
add wave -noupdate -label loadIFlag -radix binary /testbench/CU/loadIFlag
add wave -noupdate -label imm -radix signed /testbench/CU/imm
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
