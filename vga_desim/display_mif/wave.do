onerror {resume}
add wave -noupdate -divider Clock_and_Reset
add wave -noupdate -label KEY -radix binary /testbench/CLOCK_50
add wave -noupdate -label KEY -radix binary /testbench/KEY
add wave -noupdate -label SW -radix binary /testbench/SW
add wave -noupdate -divider VGA
add wave -noupdate -label VGA_X -radix decimal /testbench/VGA/VGA_X
add wave -noupdate -label VGA_Y -radix decimal /testbench/VGA/VGA_Y
add wave -noupdate -label VGA_COLOUR -radix hexadecimal /testbench/VGA/VGA_COLOR
add wave -noupdate -label Op_xC -radix decimal /testbench/VGA/OPD/xC
add wave -noupdate -label Op_yC -radix decimal /testbench/VGA/OPD/yC
add wave -noupdate -label R_xC1 -radix decimal /testbench/VGA/IRD1/xC
add wave -noupdate -label R_yC1 -radix decimal /testbench/VGA/IRD1/yC
add wave -noupdate -label R_xC2 -radix decimal /testbench/VGA/IRD2/xC
add wave -noupdate -label R_yC2 -radix decimal /testbench/VGA/IRD2/yC
add wave -noupdate -label R_xC3 -radix decimal /testbench/VGA/IRD3/xC
add wave -noupdate -label R_yC3 -radix decimal /testbench/VGA/IRD3/yC

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
