`timescale 1ns/1ps

module testbench;
    parameter CLOCK_PERIOD = 10;
    reg resetn, clk;
    wire [10:0] vga_x;       
    wire [9:0] vga_y;       
    wire [2:0] register_index;
    wire [2:0] color;   
    reg [15:0] register;
    wire vga_write;   
    register_display RD (clk, resetn, 1'b1, vga_write, register, vga_x, vga_y, color, register_index);


    // Clock generator
    initial clk = 0;

    always begin
        #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    initial begin
        #0 register <= 16'b0; 
        #0 resetn <= 1;
        #1 resetn <= 0;
        #1 resetn <= 1; 
    end
endmodule