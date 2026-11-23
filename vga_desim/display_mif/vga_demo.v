`default_nettype none

/* This Verilog code demonstrates use of the VGA output window in the DESim GUI. The demo reads
 * an image from a memory and displays this image on the VGA output. After the image has been 
 * displayed, the code illuminates LEDR[9].
 *
 * Three levels of VGA resolution are supported in this example: 640x480, 320x240, and 160x120.
 * The resolution is set in the Verilog file top.v and must match that selected in the DESim GUI 
 * within the VGA output window. The color depth of the image is set in the file top.v. Three 
 * depths are supported: 3-, 6-, and 9-bit color.
 */

module vga_module_desim(CLOCK_50, SW, KEY, VGA_X, VGA_Y, VGA_COLOR, plot);
	
    // default resolution. Specify a resolution in top.v
    parameter RESOLUTION = "640x480"; // "640x480" "320x240" "160x120"

    // default color depth. Specify a color depth in top.v
    parameter COLOR_DEPTH = 3; // 9 6 3

    // specify the number of bits needed for an X (column) pixel coordinate on the VGA display
    parameter nX = 10;
    // specify the number of bits needed for a Y (row) pixel coordinate on the VGA display
    parameter nY = 9;

	input wire CLOCK_50;
    input wire [9:0] SW;
	input wire [0:0] KEY;
	output wire [nX-1:0] VGA_X;          // for DESim VGA
	output wire [nY-1:0] VGA_Y;          // for DESim VGA
	output wire [23:0] VGA_COLOR;        // for DESim VGA
	output wire plot;                    // for DESim VGA

    /* The following signals are needed for connections to the VGA adapter. These signals
     * would be needed if the demo code were to write to pixels using their x, y addresses, but
     * this example only reads the contents of the video memory and displays it. Since this 
     * example does not write to individual pixels except when reading from the video memory, 
     * the signals below are used only as placeholders. */
	wire [COLOR_DEPTH-1:0] colorO, colorR, MUX_color;        // used as placeholder
    wire [nX-1:0] XO, XR, MUX_x;                     // used as placeholder
    wire [nY-1:0] YO, YR, MUX_y;                     // used as placeholder
    wire writeO, writeR, MUX_write;                          // used as placeholder
    
    wire VGA_SYNC;  // used to indicate that the video-memory has been read and displayed

    wire op_disp_done;

    op_disp OPD (.x(10'd312), .y(9'd329), .opcode(SW[3:0]), .resetn(KEY[0]), .clk(CLOCK_50), .VGA_X(XO), .VGA_Y(YO), .VGA_COLOR(colorO), .VGA_WRITE(writeO), .ready(VGA_SYNC), .done(op_disp_done));
    instr_reg_disp IRD (.x(10'd391), .y(9'd329), .address(SW[6:4]), .resetn(KEY[0]), .clk(CLOCK_50), .VGA_X(XR), .VGA_Y(YR), .VGA_COLOR(colorR), .VGA_WRITE(writeR), .ready(op_disp_done));

    assign MUX_x = op_disp_done ? XR : XO;
    assign MUX_y = op_disp_done ? YR : YO;
    assign MUX_write = op_disp_done ? writeR : writeO;
    assign MUX_color = op_disp_done ? colorR: colorO;
    // instantiate the DESim VGA adapter
    `define VGA_MEMORY              // include a memory module in the VGA adapter
    vga_adapter VGA (
        .resetn(KEY[0]),
        .clock(CLOCK_50),
        .color(MUX_color),              // used to draw pixels on top of background
        .x(MUX_x),                      // used to draw pixels on top of background
        .y(MUX_y),                      // used to draw pixels on top of background
        .write(MUX_write),              // used to draw pixels on top of background
        .VGA_X(VGA_X),              // the output VGA x coordinate (column)
        .VGA_Y(VGA_Y),              // the output VGA y coordinate (row)
        .VGA_COLOR(VGA_COLOR),      // the output VGA color
        .VGA_SYNC(VGA_SYNC),        // indicates when background MIF has been drawn
        .plot(plot));               // the output VGA plot signal
		defparam VGA.RESOLUTION = RESOLUTION;
        // choose background image according to resolution and color depth
		defparam VGA.BACKGROUND_IMAGE = "./MIF/CPU_Instruction_Labels_Combined.mif";
//
		defparam VGA.COLOR_DEPTH = COLOR_DEPTH;
endmodule

module op_disp (x, y, opcode, resetn, clk, VGA_X, VGA_Y, VGA_COLOR, VGA_WRITE, ready, done);
    input wire [9:0] x;
    input wire [8:0] y;
    input wire [3:0] opcode;
    input wire resetn, clk, ready;

    output reg [9:0] VGA_X;
    output reg [8:0] VGA_Y;
    output reg [2:0] VGA_COLOR;
    output reg VGA_WRITE, done;

    parameter INIT = 3'b001, WRITE = 3'b010, DONE = 3'b100;

    //reg [9:0] xVal = x;
    //reg [8:0] yVal = y;
    reg [6:0] xC = 0;
    reg [5:0] yC = 0;
    
    wire [2:0] colour;

    // State Regs
    reg [2:0] y_Q, Y_D;
    
    op_mem mem(xC + yC*64, opcode, colour);

    always @(*)
    begin: state_table
        case(y_Q)
            INIT:
            begin
                xC <= 0;
                yC <= 0;
                done <= 0;

                

                if (!ready)
                begin
                    Y_D <= INIT;
                    VGA_WRITE <= 0;
                end
                else
                begin
                    Y_D <= WRITE;
                    VGA_WRITE <= 1;
                end
            end

            WRITE:
            begin
                if (yC < 32)
                begin
                    Y_D <= WRITE;
                end
                else
                begin
                    Y_D <= DONE;
                    VGA_WRITE <= 0;
                end
            end

            DONE:
            begin
                VGA_WRITE <= 0;
                done <= 1;
            end

            default: Y_D = 3'bxxx;
                    
        endcase
    end

    always @(posedge clk)
    begin: state_FFs
        if (!resetn) y_Q <= INIT;
        else y_Q <= Y_D;
    end

    always @(posedge clk)
    begin
        if (y_Q == WRITE)
        begin
            if (xC < 64)
                xC <= xC + 1;
            else if (yC < 32)
            begin
                yC <= yC + 1;
                xC <= 0;
            end
            
            VGA_X <= x + xC;
            VGA_Y <= y + yC;
            VGA_COLOR <= colour;
        end
    end
         
endmodule

module instr_reg_disp (x, y, address, resetn, clk, VGA_X, VGA_Y, VGA_COLOR, VGA_WRITE, ready, done);
    input wire [9:0] x;
    input wire [8:0] y;
    input wire [2:0] address;
    input wire resetn, clk, ready;

    output reg [9:0] VGA_X;
    output reg [8:0] VGA_Y;
    output reg [2:0] VGA_COLOR;
    output reg VGA_WRITE, done;

    parameter INIT = 3'b001, WRITE = 3'b010, DONE = 3'b100;

    //reg [9:0] xVal = x;
    //reg [8:0] yVal = y;
    reg [6:0] xC = 0;
    reg [5:0] yC = 0;
    
    wire [2:0] colour;

    // State Regs
    reg [2:0] y_Q, Y_D;
    
    reg_label_mem mem(xC + yC*64, address, colour);

    always @(*)
    begin: state_table
        case(y_Q)
            INIT:
            begin
                xC <= 0;
                yC <= 0;
                done <= 0;

                

                if (!ready)
                begin
                    Y_D <= INIT;
                    VGA_WRITE <= 0;
                end
                else
                begin
                    Y_D <= WRITE;
                    VGA_WRITE <= 1;
                end
            end

            WRITE:
            begin
                if (yC < 32)
                begin
                    Y_D <= WRITE;
                end
                else
                begin
                    Y_D <= DONE;
                    VGA_WRITE <= 0;
                end
            end

            DONE:
            begin
                VGA_WRITE <= 0;
                done <= 1;
            end

            default: Y_D = 3'bxxx;
                    
        endcase
    end

    always @(posedge clk)
    begin: state_FFs
        if (!resetn) y_Q <= INIT;
        else y_Q <= Y_D;
    end

    always @(posedge clk)
    begin
        if (y_Q == WRITE)
        begin
            if (xC < 64)
                xC <= xC + 1;
            else if (yC < 32)
            begin
                yC <= yC + 1;
                xC <= 0;
            end
            
            VGA_X <= x + xC;
            VGA_Y <= y + yC;
            VGA_COLOR <= colour;
        end
    end
endmodule

module op_mem (count, opcode, data_out);
    input wire [13:0] count;
    input wire [3:0] opcode;
    output wire [2:0] data_out;

    wire [3:0] index;
    assign index = opcode == 15 ? 7 : opcode;
    
    reg [2:0] mem [16383:0] /* synthesis ram_init_file = vga_desim/display_mif/MIF/CPU_Instruction_Labels_Combined.mif */;
    
    initial 
    begin
        $readmemh("../CPU_Instruction_Labels_Combined.hex", mem);
    end

    assign data_out = mem[index * 2048 + count];

endmodule

module reg_label_mem (count, reg_address, data_out);
    input wire [13:0] count;
    input wire [2:0] reg_address;
    output wire [2:0] data_out;
    
    reg [2:0] mem [16383:0] /* synthesis ram_init_file = vga_desim/display_mif/MIF/CPU_Register_Labels_R0_to_R7_Combined.mif */;
    
    initial 
    begin
        $readmemh("../CPU_Register_Labels_R0_to_R7_Combined.hex", mem);
    end

    assign data_out = mem[reg_address * 2048 + count];
endmodule
