module rom_16x16(C,clk,instrc);
    input [7:0]C;
    input clk;
    output reg[15:0] instrc; 

    //Instantiate rom with 256 addresses, not all of them used
    reg [15:0] memory_array [255:0] /* synthesis ram_init_file = rom.mif */;

    always @(posedge clk) 
        instrc <= memory_array[C];

endmodule