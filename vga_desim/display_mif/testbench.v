`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 10;
        reg CLOCK_50;
		reg [1:0] KEY;
		reg [9:0] SW;
		wire [9:0] VGA_X;
		wire [8:0] VGA_Y;
		wire [23:0] VGA_COLOR;
		wire plot;



	initial begin
                CLOCK_50 <= 1'b1;
	end // initial

	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) CLOCK_50 <= ~CLOCK_50;
	end

        initial begin
        KEY[1] <= 1'b1;
        #10 KEY[1] <= 1'b0;
        #10 KEY[1] <= 1'b1;
		//#8 SW[9:0] <= 10'b0000100100;
		//#10 SW[9:0] <= 10'b0001000100;
		#1 SW[9:0] <= 10'b0101000001;
		//#10 SW[9:0] <= 10'b1000100010;
		//#10 SW[9:0] <= 10'b0010100011;
		//#10 SW[9:0] <= 10'b0000000000;
		//#10 SW[9:0] <= 10'b0011000101;
		//#10 SW[9:0] <= 10'b0101000110;
		//#10 SW[9:0] <= 10'b0011110011;
		//#10 SW[9:0] <= 10'b0000010100;
		//#10 SW[9:0] <= 10'b1000010010;
		//#10 SW[9:0] <= 10'b0000001111;

		#9 KEY[0] <= 1'b0;
		#10 KEY[0] <= 1'b1;
	end 
	vga_module_desim VGA (CLOCK_50, SW, KEY, VGA_X, VGA_Y, VGA_COLOR, plot);

endmodule
