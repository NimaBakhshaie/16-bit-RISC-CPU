module top (KEY,CLOCK_50,VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,VGA_BLANK_N,VGA_SYNC_N,VGA_CLK);
	 input CLOCK_50;
     input [1:0] KEY;
	 output [7:0]VGA_R,VGA_G,VGA_B;
	 output VGA_HS,VGA_VS;
	 output VGA_BLANK_N, VGA_SYNC_N,VGA_CLK; 
	 
    wire increment, immFlag, loadIFlag;
    wire cpu_clk = ~KEY[0]; 
    wire [2:0] alu_opcode, R1, R2, R3;
    wire [7:0] C;
    wire [15:0] instr, imm, DR1, DR2, WR3, num1, num2;
    wire [15:0] display;
    wire [2:0] register_index, color;
    wire [9:0] vga_x; 
    wire [8:0] vga_y; 
    wire vga_write;

    program_counter PC (
        .enableI(increment), .enableL(1'b0), .L(8'd0), 
        .resetn(KEY[1]), .clk(cpu_clk), .C(C)
    );
    rom_16x16 ROM (.C(C), .instrc(instr));
    control_unit CU (
        .instr(instr), .z(1'b0),
        .increment(increment), .resetn(KEY[1]),
        .alu_opcode(alu_opcode), .R1(R1), .R2(R2), .R3(R3),
        .immFlag(immFlag), .imm(imm), .loadIFlag(loadIFlag)
    );
    reg_8x16 REG_8X16 (
        .R1(R1), .R2(R2), .R3(R3), .WR3(WR3),
        .resetn(KEY[1]), .clk(cpu_clk),
        .DR1(DR1), .DR2(DR2), .SW(register_index), .display(display)
    );
    alu ALU (.alu_opcode(alu_opcode), .num1(num1), .num2(num2), .num3(WR3), .z());

    register_display REG (
        .clk(CLOCK_50), .reset(KEY[1]), .en(1'b1),
        .vga_write(vga_write), .register(display),
        .vga_x(vga_x), .vga_y(vga_y), .color(color),
        .register_index(register_index)
    );

    vga_adapter #(.RESOLUTION("640x480"), .COLOR_DEPTH(3)) VGA (KEY[1], CLOCK_50, color, vga_x, 
        vga_y, vga_write,VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK
    );

    assign num1 = immFlag ? imm : DR1;
    assign num2 = loadIFlag ? 16'b0 : DR2;
endmodule
