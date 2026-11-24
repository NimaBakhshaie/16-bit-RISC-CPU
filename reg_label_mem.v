module reg_label_mem (count, reg_address, data_out);
    input wire [13:0] count;
    input wire [2:0] reg_address;
    output wire [2:0] data_out;
    
    reg [2:0] mem [16383:0] /* synthesis ram_init_file = CPU_Register_Labels_R0_to_R7_Combined.mif */;

    assign data_out = mem[reg_address * 2048 + count];
endmodule