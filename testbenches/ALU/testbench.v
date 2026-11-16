`timescale 1ns/1ps

module testbench;
    reg [2:0] alu_opcode;
    reg signed [15:0] num1, num2;
    wire signed [15:0] num3;
    wire z;

    parameter [2:0] ADD = 3'b000, SUB = 3'b001,
                    AND = 3'b010, OR = 3'b011;

    alu dut (
        .alu_opcode(alu_opcode),
        .num1(num1),
        .num2(num2),
        .num3(num3),
        .z(z)
    );

    initial begin
        alu_opcode = ADD; num1 = 16'd10; num2 = 16'd20;
        #20;

        // ADD: 32767 + 1 = -32768
        alu_opcode = ADD; num1 = 16'sd32767; num2 = 16'sd1;
        #20;

        // SUB: 20 - 5 = 15
        alu_opcode = SUB; num1 = 16'd20; num2 = 16'd5;
        #20;

        // SUB: 5 - 20 = -15
        alu_opcode = SUB; num1 = 16'd5; num2 = 16'd20;
        #20;

        // AND: F0F0 & FF00 = F000
        alu_opcode = AND; num1 = 16'hF0F0; num2 = 16'hFF00;
        #20;

        // AND: AAAA & 5555 = 0000
        alu_opcode = AND; num1 = 16'hAAAA; num2 = 16'h5555;
        #20;

        // OR: 0F00 | 00F0 = 0FF0
        alu_opcode = OR; num1 = 16'h0F00; num2 = 16'h00F0;
        #20;

        // OR: A000 | 0505 = A505
        alu_opcode = OR; num1 = 16'hA000; num2 = 16'h0505;
        #20;
    end
endmodule