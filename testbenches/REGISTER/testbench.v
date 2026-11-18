`timescale 1ns/1ps

module testbench;
    parameter CLOCK_PERIOD = 10;

    reg [2:0] R1, R2, R3;
    reg signed [15:0] WR3;
    reg resetn, clk;
    wire signed [15:0] DR1, DR2;

    reg_8x16 dut (R1, R2, R3, WR3, resetn, clk, DR1, DR2);

    // Clock generator
    initial clk = 0;

    always begin
        #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    initial begin
        // Reset all registers
        resetn = 0;
        R1 = 0; R2 = 1; R3 = 0; WR3 = 0;
        #12;
        resetn = 1;

        // Write values to all 8 registers
        #10 R3 = 0; WR3 = 16'sd10;
        #10 R3 = 1; WR3 = 16'sd20;
        #10 R3 = 2; WR3 = -16'sd5;
        #10 R3 = 3; WR3 = 16'sd32767;
        #10 R3 = 4; WR3 = -16'sd32768;
        #10 R3 = 5; WR3 = 16'sd240;
        #10 R3 = 6; WR3 = 16'sd3840;
        #10 R3 = 7; WR3 = 16'sd21845;

        // Read r0 and r1
        #10 R1 = 0; R2 = 1;

        // Read r2 and r3
        #10 R1 = 2; R2 = 3;

        // Read r4 and r5
        #10 R1 = 4; R2 = 5;

        // Read r6 and r7
        #10 R1 = 6; R2 = 7;

        // Read same register on both ports
        #10 R1 = 3; R2 = 3;

        // Reset all registers again
        #10 resetn = 0;
        #10 R1 = 3; R2 = 7;

        #10 $stop;
    end
endmodule