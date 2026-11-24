module vga_module(CLOCK_50, SW, KEY, VGA_R, VGA_G, VGA_B,
				VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);
	
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
    output wire [7:0] VGA_R;
	output wire [7:0] VGA_G;
	output wire [7:0] VGA_B;
	output wire VGA_HS;
	output wire VGA_VS;
	output wire VGA_BLANK_N;
	output wire VGA_SYNC_N;
	output wire VGA_CLK;	

    /* The following signals are needed for connections to the VGA adapter. These signals
     * would be needed if the demo code were to write to pixels using their x, y addresses, but
     * this example only reads the contents of the video memory and displays it. Since this 
     * example does not write to individual pixels except when reading from the video memory, 
     * the signals below are used only as placeholders. */
	wire [COLOR_DEPTH-1:0] colorO, colorR, MUX_color;        // used as placeholder
    wire [nX-1:0] XO, XR, MUX_x;                     // used as placeholder
    wire [nY-1:0] YO, YR, MUX_y;                     // used as placeholder
    wire writeO, writeR, MUX_write;                          // used as placeholder
    
    reg VGA_SYNC;  // used to indicate that the video-memory has been read and displayed
    reg sync_counter = 0;

    wire op_disp_done;

    always @(posedge VGA_VS)
    begin
        if (sync_counter == 68)
        begin
            VGA_SYNC <= 1;
            sync_counter <= 0;
        end
        else
            sync_counter <= sync_counter + 1;
    end

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
        .VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_BLANK_N(VGA_BLANK_N),
		.VGA_SYNC_N(VGA_SYNC_N),
		.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = RESOLUTION;
        // choose background image according to resolution and color depth
		defparam VGA.BACKGROUND_IMAGE = "16-Bit_CPU_FINAL_640x480_RGB111.mif";
//
		defparam VGA.COLOR_DEPTH = COLOR_DEPTH;
endmodule