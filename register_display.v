module register_display(clk, reset, en,vga_write, register, vga_x, vga_y,color, register_index);
    input clk, reset, en;
    input [15:0] register;

    output reg [10:0] vga_x;       
    output reg [9:0] vga_y;       
    output [2:0] register_index;
    output reg [2:0] color;   
    output reg vga_write;   

    reg [1:0] x, y;
    reg column;   
    wire [3:0] current;
    wire [4:0] current_x, current_y;
    wire [9:0] pixel_address;
    wire done;
    wire r;           

    // Combined hexadecimal sprite ROM
    reg [2:0] memory [0:16383] /* synthesis ram_init_file = sprites/hex_combined.mif */;

    parameter [8:0] column_x_one = 9'd139,column_x_two = 9'd418,column_y = 9'd86;
    parameter [5:0] increment_x = 6'd42,increment_y = 6'd48;
    parameter [1:0] IDLE = 2'b00,DRAW = 2'b01, NEXT = 2'b10;

    // FSM
    reg [1:0] states, next_states;
    always @(*) begin
        next_states = states; 
        case (states)
            IDLE: begin
                if (en)
                    next_states = DRAW;
            end
            DRAW: begin
                if (done)
                    next_states = NEXT;
            end
            NEXT: begin
                if (column == 1 && y == 3 && x == 3)
                    next_states = IDLE;
                else
                    next_states = DRAW;
            end
            default: next_states = IDLE;
        endcase
    end

    //State updating 
    always @(posedge clk) begin
        if (!reset)
            states <= IDLE;
        else
            states <= next_states;

    end

    //Outputs of the FSM
    always @(posedge clk) begin
        if (!reset) begin
            x <= 0;
            y <= 0;
            column <= 0;
        end

        else if (states == IDLE) begin
            x <= 0;
            y <= 0;
            column <= 0;
        end

        else if (states == NEXT) begin //Increments once per clock cycle based on state for x,y,column
            if (!(column == 1 && y == 3 && x == 3)) begin
                if (x < 3) begin
                    x <= x + 1;
                end
                else begin
                    x <= 0;
                    if (y < 3) begin
                        y <= y + 1;
                    end
                    else begin
                        y <= 0;
                        column <= 1;
                    end
                end
            end
        end
    end

    assign r = (!reset || states != DRAW); //Reset for the sprite_write
    sprite_write sw (clk,r,done,pixel_address,current_x,current_y);
    sprite_select ss (x,register,current); 
    assign register_index = {column, y};

    //Output handling for outputs going into the adapter
    always @(posedge clk) begin
        if (!reset) begin
            vga_x <= 0;
            vga_y <= 0;
            vga_write <= 0;
        end

        else begin
            color <= memory[{current, pixel_address}];
            vga_x <= (column ? column_x_two : column_x_one)+ increment_x * x+ current_x;
            vga_y <= column_y + increment_y * y + current_y;
            vga_write <= (states == DRAW && !done);
        end
    end

endmodule

module sprite_select(x,register,current);
    input [1:0] x; 
    input [15:0] register; 
    output reg[3:0]current; 

    wire [3:0] a,b,c,d; 

    assign a = register[15:12];
    assign b = register[11:8];
    assign c = register[7:4];
    assign d = register[3:0];

    always @(*) begin
        case(x)
        2'b00: current <= a;
        2'b01: current <= b;
        2'b10: current <= c;
        2'b11: current <= d; 
        endcase 
    end 
endmodule 

module sprite_write(clk,reset,done,pixel_address,current_x,current_y);
    input clk,reset;

    output reg done; 
    output [4:0] current_x,current_y; 
    output reg [9:0] pixel_address; 

    always @(posedge clk) begin
        if (reset == 1) begin
            pixel_address <= 0;
            done <= 0;
        end
        else if (!done) begin
            if (pixel_address == 1023) begin
                done <= 1;
            end
            else pixel_address <= pixel_address + 1;
        end
    end

    assign current_x = pixel_address[4:0];
    assign current_y = pixel_address[9:5];
endmodule 