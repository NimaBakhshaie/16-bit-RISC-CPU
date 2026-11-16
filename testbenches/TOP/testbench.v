`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 10;
        parameter WRITE_CLOCK_PERIOD = 2;


        reg [1:0] KEY;

        reg writeClk;
        reg [7:0] writeIndex;
        reg [15:0] writeD;

	initial begin
                KEY[0] <= 1'b0;
                writeClk <= 1'b1;
	end // initial

	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) KEY[0] <= ~KEY[0];
	end

        always @(*)
                #((WRITE_CLOCK_PERIOD) / 2) writeClk <= ~writeClk;
	
	initial begin
           writeIndex <= 4'd0; writeD <= 16'b0100010110010000;
        #2 writeIndex <= 4'd1; writeD <= 16'b0100100011001000;
        #2 writeIndex <= 4'd2; writeD <= 16'b0001100010011000;
        #2 writeIndex <= 4'd3; writeD <= 16'b0010010100101000;
        #2 writeIndex <= 4'd4; writeD <= 16'b0011010001000000;
        #2 writeIndex <= 4'd5; writeD <= 16'b0000000000000000;
        #2 writeIndex <= 4'd6; writeD <= 16'b0101100001110000;
        #2 writeIndex <= 4'd7; writeD <= 16'b0110100010111000;
        #2 writeIndex <= 4'd8; writeD <= 16'b0011111001000000;
        #2 writeIndex <= 4'd9; writeD <= 16'b0100001001100100;
        #2 writeIndex <= 4'd10; writeD <= 16'b0010001100000000;
        #2 writeIndex <= 4'd11; writeD <= 16'b1111000000000000;
        #2 writeIndex <= 4'd12; writeD <= 16'b0100100011001000;
        #1 KEY[1] <= 1'b1;
        #1 KEY[1] <= 1'b0;
        #1 KEY[1] <= 1'b1;
	end // initial
	top CPU (.KEY(KEY), .writeIndex(writeIndex), .writeClk(writeClk), .writeD(writeD));

endmodule
