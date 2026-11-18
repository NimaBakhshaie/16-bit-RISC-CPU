module rom_16x16(C,instrc);
    input [7:0]C;
    output [15:0] instrc; 

    //Instantiate rom with 16 addresses, not all of them used
    reg [15:0] memory_array [15:0] /* synthesis ram_init_file = rom.mif */;

    assign instrc = memory_array[C];
endmodule