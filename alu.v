module alu(alu_opcode,num1,num2,num3,z);
    input clk; 
    input [2:0]alu_opcode;
    input signed[15:0] num1,num2;
    output z;
    output reg signed[15:0] num3; 

    parameter [2:0] ADD = 3'b000, SUB = 3'b001, AND = 3'b010, OR = 3'b011;

    always @(*) 
    begin 
        case (alu_opcode)
            ADD: 
            num3 <= num1+num2;

            SUB: 
            num3 <= num1-num2; 

            AND:
            num3 <= num1&num2; 

            OR: 
            num3 <= num1|num2; 
        endcase
    end 
endmodule 

    