module top(KEY,SW,HEX3,HEX2,HEX1,HEX0);
    input [1:0] KEY;
    input [2:0] SW; //For testing only
    output [6:0]HEX3, HEX2,HEX1,HEX0; //For testing only


    wire increment, immFlag, loadIFlag, clk;
    wire [2:0] alu_opcode, R1, R2, R3;
    wire [7:0] C;
    wire [15:0] instr, imm, DR1, DR2, WR3, num1, num2;
    wire [15:0] display; //For testing only

    assign clk = ~KEY[0];

    program_counter PC (.enableI(increment), .resetn(KEY[1]), .clk(clk), .C(C));
    rom_16x16 ROM (.C(C),.instrc(instr));
    control_unit CU (.instr(instr), .increment(increment), .resetn(KEY[1]), .alu_opcode(alu_opcode), .R1(R1), .R2(R2), .R3(R3), .immFlag(immFlag), .imm(imm), .loadIFlag(loadIFlag));
    reg_8x16 REG_8X16 (.R1(R1), .R2(R2), .R3(R3), .WR3(WR3), .resetn(KEY[1]), .clk(clk), .DR1(DR1), .DR2(DR2), .SW(SW), .display(display)); //SW and Display can be removed later
    alu ALU (.alu_opcode(alu_opcode), .num1(num1), .num2(num2), .num3(WR3));

    //Temporary register display
    hex_decoder h0(.X(display[3:0]),.HEX(HEX0));
    hex_decoder h1(.X(display[7:4]),.HEX(HEX1));
    hex_decoder h2(.X(display[11:8]),.HEX(HEX2));
    hex_decoder h3(.X(display[15:12]),.HEX(HEX3));

    //MUX
    assign num1 = immFlag ? imm : DR1;
    assign num2 = loadIFlag ? 16'b0 : DR2;
endmodule

