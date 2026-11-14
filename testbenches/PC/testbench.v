`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 10;


        reg clk, resetn, enableI;
        wire [7:0] C;

	initial begin
                clk <= 1'b1;
	end // initial

	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) clk <= ~clk;
	end
	
	initial begin
        resetn <= 1'b1; enableI <= 1'b0;
        #20 resetn <= 1'b0;
        #20 resetn <= 1'b1; enableI <= 1'b1;
        #40 enableI <= 1'b0;
        #30 enableI <= 1'b1;
        #10 resetn <= 1'b0;
        #10 resetn <= 1'b1;
	end // initial
	program_counter PC (.enableI(enableI), .clk(clk), .resetn(resetn), .C(C));

endmodule
