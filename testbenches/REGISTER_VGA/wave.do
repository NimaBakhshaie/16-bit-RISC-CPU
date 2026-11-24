onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk -radix binary /testbench/clk
add wave -noupdate -label resetn -radix binary /testbench/resetn
add wave -noupdate -label states -radix binary /testbench/RD/states;
add wave -noupdate -label next_states -radix binary /testbench/RD/next_states; 
add wave -noupdate -label x -radix unsigned /testbench/RD/x;
add wave -noupdate -label y -radix unsigned /testbench/RD/y;
add wave -noupdate -label column -radix binary /testbench/RD/column;
add wave -noupdate -label draw_enable -radix binary /testbench/RD/r;
add wave -noupdate -label done -radix binary /testbench/RD/done;
add wave -noupdate -label address -radix decimal /testbench/RD/sw/pixel_address; 

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
