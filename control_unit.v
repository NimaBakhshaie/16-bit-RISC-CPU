module control_unit(instr, z, clk, increment, alu_opcode, R1, R2, R3, immFlag, imm, loadIFlag);
    input [15:0] instr;
    input z, clk;

    output reg increment, immFlag, loadIFlag;
    output reg [2:0] alu_opcode, R1, R2, R3;
    output reg signed [15:0] imm;

    wire [3:0] opcode;
    assign opcode = instr[15:12];

    parameter [3:0] NOP = 4'b0000, ADD = 4'b0001, SUB = 4'b0010, LOAD = 4'b0011, LOADI = 4'b0100, AND = 4'b0101, OR = 4'b0110, HALT = 4'b0111;
    parameter [2:0] alu_ADD = 3'b000, alu_SUB = 3'b001, alu_AND = 3'b010, alu_OR = 3'b011;

    always (@posedge clk)
    begin
        case(opcode)
            HALT, NOP: 
            begin
                alu_opcode <= alu_OR;
                R1 <= 0;
                R2 <= 0;
                R3 <= 0;
                immFlag <= 0;
                loadIFlag <= 0;
            end
            ADD:
            begin
                alu_opcode <= alu_ADD;
                R1 <= instr[11:9];
                R2 <= instr[8:6];
                R3 <= instr[5:3];
                immFlag <= 0;
                loadIFlag <= 0;
            end
            SUB:
            begin
                alu_opcode <= alu_SUB;
                R1 <= instr[11:9];
                R2 <= instr[8:6];
                R3 <= instr[5:3];
                immFlag <= 0;
                loadIFlag <= 0;
            end
            LOAD:
            begin
                alu_opcode <= alu_ADD;
                R1 <= instr[11:9];
                R2 <= instr[11:9];
                R3 <= instr[8:6];
                immFlag <= 1;
                imm <= 0;
                loadIFlag <= 0;
            end
            LOADI:
            begin
                alu_opcode <= alu_ADD;
                R1 <= instr[11:9];
                R2 <= instr[11:9];
                R3 <= instr[11:9];
                immFlag <= 1;
                imm <= instr[8:0];
                loadIFlag <= 1;
            end
            AND:
            begin
                alu_opcode <= alu_AND;
                R1 <= instr[11:9];
                R2 <= instr[8:6];
                R3 <= instr[5:3];
                immFlag <= 0;
                loadIFlag <= 0;
            end
            OR:
            begin
                alu_opcode <= alu_OR;
                R1 <= instr[11:9];
                R2 <= instr[8:6];
                R3 <= instr[5:3];
                immFlag <= 0;
                loadIFlag <= 0;
            end
        endcase
    
        if (opcode == HALT)
            increment = 0;
        else
            increment = 1;
    end
endmodule