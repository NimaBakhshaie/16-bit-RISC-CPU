module op_disp (x, y, opcode, resetn, clk, VGA_X, VGA_Y, VGA_COLOR, VGA_WRITE, ready, done);
    input wire [9:0] x;
    input wire [8:0] y;
    input wire [3:0] opcode;
    input wire resetn, clk, ready;

    output reg [9:0] VGA_X;
    output reg [8:0] VGA_Y;
    output reg [2:0] VGA_COLOR;
    output reg VGA_WRITE, done;

    parameter INIT = 3'b001, WRITE = 3'b010, DONE = 3'b100;

    //reg [9:0] xVal = x;
    //reg [8:0] yVal = y;
    reg [6:0] xC = 0;
    reg [5:0] yC = 0;
    
    wire [2:0] colour;

    // State Regs
    reg [2:0] y_Q, Y_D;
    
    op_mem mem(xC + yC*64, opcode, colour);

    always @(*)
    begin: state_table
        case(y_Q)
            INIT:
            begin
                if (!ready)
                begin
                    Y_D <= INIT;
                    VGA_WRITE <= 0;
                end
                else
                begin
                    Y_D <= WRITE;
                    VGA_WRITE <= 1;
                end
            end

            WRITE:
            begin
                if (yC < 32)
                begin
                    Y_D <= WRITE;
                end
                else
                begin
                    Y_D <= DONE;
                    VGA_WRITE <= 0;
                end
            end

            DONE:
            begin
                VGA_WRITE <= 0;
            end

            default: Y_D = 3'bxxx;
                    
        endcase
    end

    always @(posedge clk)
    begin: state_FFs
        if (!resetn) y_Q <= INIT;
        else y_Q <= Y_D;
    end

    always @(posedge clk)
    begin
        if (y_Q == WRITE)
        begin
            if (xC < 64)
                xC <= xC + 1;
            else if (yC < 32)
            begin
                yC <= yC + 1;
                xC <= 0;
            end
            
            VGA_X <= x + xC;
            VGA_Y <= y + yC;
            VGA_COLOR <= colour;
        end
        else if (y_Q == INIT)
        begin
            xC <= 0;
            yC <= 0;
            done <= 0;
        end
        else if (y_Q == DONE)
            done <= 1;
    end
         
endmodule