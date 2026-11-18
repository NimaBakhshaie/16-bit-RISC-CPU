onerror {resume}
add wave -noupdate -divider Clock_and_Reset
add wave -noupdate -label KEY -radix binary /testbench/KEY
add wave -noupdate -divider CPU
add wave -noupdate -label C -radix decimal /testbench/CPU/C
add wave -noupdate -label instruction -radix binary /testbench/CPU/instr
add wave -noupdate -divider CU
add wave -noupdate -label alu_opcode -radix binary /testbench/CPU/CU/alu_opcode
add wave -noupdate -label R1 -radix unsigned /testbench/CPU/CU/R1
add wave -noupdate -label R2 -radix unsigned /testbench/CPU/CU/R2
add wave -noupdate -label R3 -radix unsigned /testbench/CPU/CU/R3
add wave -noupdate -label increment -radix binary /testbench/CPU/CU/increment
add wave -noupdate -label immFlag -radix binary /testbench/CPU/CU/immFlag
add wave -noupdate -label loadIFlag -radix binary /testbench/CPU/CU/loadIFlag
add wave -noupdate -label imm -radix signed /testbench/CPU/CU/imm
add wave -noupdate -divider ALU
add wave -noupdate -label alu_opcode -radix binary /testbench/CPU/ALU/alu_opcode
add wave -noupdate -label num1 -radix signed /testbench/CPU/ALU/num1
add wave -noupdate -label num2 -radix signed /testbench/CPU/ALU/num2
add wave -noupdate -label num3 -radix signed /testbench/CPU/ALU/num3
add wave -noupdate -divider REG_8X16
add wave -noupdate -label R1 -radix decimal /testbench/CPU/REG_8X16/R1
add wave -noupdate -label R2 -radix decimal /testbench/CPU/REG_8X16/R2
add wave -noupdate -label R3 -radix decimal /testbench/CPU/REG_8X16/R3
add wave -noupdate -label DR1 -radix decimal /testbench/CPU/REG_8X16/DR1
add wave -noupdate -label DR2 -radix decimal /testbench/CPU/REG_8X16/DR2
add wave -noupdate -label WR3 -radix decimal /testbench/CPU/REG_8X16/WR3
add wave -noupdate -label r0 -radix signed /testbench/CPU/REG_8X16/r0
add wave -noupdate -label r1 -radix signed /testbench/CPU/REG_8X16/r1
add wave -noupdate -label r2 -radix signed /testbench/CPU/REG_8X16/r2
add wave -noupdate -label r3 -radix signed /testbench/CPU/REG_8X16/r3
add wave -noupdate -label r4 -radix signed /testbench/CPU/REG_8X16/r4
add wave -noupdate -label r5 -radix signed /testbench/CPU/REG_8X16/r5
add wave -noupdate -label r6 -radix signed /testbench/CPU/REG_8X16/r6
add wave -noupdate -label r7 -radix signed /testbench/CPU/REG_8X16/r7
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
