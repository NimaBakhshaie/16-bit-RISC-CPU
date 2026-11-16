`timescale 1ns / 1ps

module testbench ();

	reg [7:0] C;
	wire [15:0] instrc;
	
	initial begin
		$readmemh("rom.hex", U1.memory_array);
		C <= 8'd0; 
		#10 C <= 8'd1; 
		#10 C <= 8'd2;
		#10 C <= 8'd3;
		#10 C <= 8'd4;
		#10 C <= 8'd5;
		#10 C <= 8'd6;
		#10 C <= 8'd7;
		#10 C <= 8'd8;
		#10 C <= 8'd9;
		#10 C <= 8'd10;
		#10 C <= 8'd11;
	end // initial
	rom_16x16 U1(C,instrc);
endmodule
