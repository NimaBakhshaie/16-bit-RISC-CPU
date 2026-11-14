`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 10;

        reg [15:0] instr;
        reg clk;
        wire increment, immFlag, loadIFlag;
        wire [2:0] alu_opcode, R1, R2, R3;
        wire signed [15:0] imm;

	initial begin
                clk <= 1'b1;
	end // initial

	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) clk <= ~clk;
	end
	
	initial begin
        instr <= 16'b0100010110010000;
        #10 instr <= 16'b0100100011001000;
        #10 instr <= 16'b0001100010011000;
        #10 instr <= 16'b0010010100101000;
        #10 instr <= 16'b0011010001000000;
        #10 instr <= 16'b0000000000000000;
        #10 instr <= 16'b0101100001110000;
        #10 instr <= 16'b0110100010111000;
        #10 instr <= 16'b0011111001000000;
        #10 instr <= 16'b0100001001100100;
        #10 instr <= 16'b0010001100000000;
        #10 instr <= 16'b1111000000000000;
        #10 instr <= 16'b0000000000000000;
	end // initial
	control_unit CU (.instr(instr), .clk(clk), .increment(increment), .immFlag(immFlag), .loadIFlag(loadIFlag), .alu_opcode(alu_opcode), .R1(R1), .R2(R2), .R3(R3), .imm(imm));

endmodule






