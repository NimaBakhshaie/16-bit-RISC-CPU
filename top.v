module top(KEY, writeIndex, writeClk, writeD);
    input [1:0] KEY;

    input writeClk;
    input [7:0] writeIndex;
    input [15:0] writeD;

    wire increment, immFlag, loadIFlag, clk;
    wire [2:0] alu_opcode, R1, R2, R3;
    wire [7:0] C;
    wire [15:0] instr, imm, DR1, DR2, WR3, num1, num2;

    assign clk = ~KEY[0];

    program_counter PC (.enableI(increment), .resetn(KEY[1]), .clk(clk), .C(C));
    rom_16x16 ROM (.C(C), .clk(clk), .instrc(instr), .writeIndex(writeIndex), .writeD(writeD), .writeClk(writeClk));
    control_unit CU (.instr(instr), .clk(clk), .increment(increment), .resetn(KEY[1]), .alu_opcode(alu_opcode), .R1(R1), .R2(R2), .R3(R3), .immFlag(immFlag), .imm(imm), .loadIFlag(loadIFlag));
    reg_8x16 REG_8X16 (.R1(R1), .R2(R2), .R3(R3), .WR3(WR3), .resetn(KEY[1]), .clk(clk), .DR1(DR1), .DR2(DR2));
    alu ALU (.alu_opcode(alu_opcode), .num1(num1), .num2(num2), .clk(clk), .num3(WR3));

    // MUX
    assign num1 = immFlag ? imm : DR1;
    assign num2 = loadIFlag ? 16'b0 : DR2;
endmodule