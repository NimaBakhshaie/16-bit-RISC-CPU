module reg_8x16 (R1,R2,R3,WR3,resetn,clk,DR1,DR2);
    input [2:0] R1,R2,R3; 
    input signed [15:0] WR3;
    input resetn,clk;
    output reg signed [15:0] DR1,DR2; 

    reg signed[15:0]r0,r1,r2,r3,r4,r5,r6,r7; 
    always @(posedge clk)
        begin 
        if (resetn == 0) 
            begin 
            r0 <= 16'b0;
            r1 <= 16'b0;
            r2 <= 16'b0;
            r3 <= 16'b0;
            r4 <= 16'b0;
            r5 <= 16'b0;
            r6 <= 16'b0;
            r7 <= 16'b0;
            end 
        else 
        begin
            case(R1)
                3'b000: DR1 <= r0;
                3'b001: DR1 <= r1;
                3'b010: DR1 <= r2;
                3'b011: DR1 <= r3;
                3'b100: DR1 <= r4;
                3'b101: DR1 <= r5;
                3'b110: DR1 <= r6;
                3'b111: DR1 <= r7;
            endcase 

            case(R2)
                3'b000: DR2 <= r0;
                3'b001: DR2 <= r1;
                3'b010: DR2 <= r2;
                3'b011: DR2 <= r3;
                3'b100: DR2 <= r4;
                3'b101: DR2 <= r5;
                3'b110: DR2 <= r6;
                3'b111: DR2 <= r7;
            endcase 

            case (R3)
                3'b000: r0 <= WR3; 
                3'b001: r1 <= WR3; 
                3'b010: r2 <= WR3; 
                3'b011: r3 <= WR3; 
                3'b100: r4 <= WR3; 
                3'b101: r5 <= WR3; 
                3'b110: r6 <= WR3; 
                3'b111: r7 <= WR3; 
            endcase
        end 
        end 
endmodule 
