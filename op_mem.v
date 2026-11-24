module op_mem (count, opcode, data_out);
    input wire [13:0] count;
    input wire [3:0] opcode;
    output wire [2:0] data_out;

    wire [3:0] index;
    assign index = opcode == 15 ? 7 : opcode;
    
    reg [2:0] mem [16383:0] /* synthesis ram_init_file = CPU_Instruction_Labels_Combined.mif */;

    assign data_out = mem[index * 2048 + count];

endmodule