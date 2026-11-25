module pc_vga(clk,reset,en,counter,vga_write,vga_x,vga_y,color,done);
    input clk;
    input reset; 
    input [7:0]counter;

    output [10:0] vga_x;       
    output [9:0] vga_y;     
    output reg [2:0] color;   
    output reg vga_write; 
    output done; 

    wire d1,d2;
    reg r;
    wire [4:0] current_x, current_y;
    wire [9:0] pixel_address;
    wire [3:0] a,b;

    reg [1:0] states, next_states; 
    parameter [1:0] IDLE = 2'b00, DRAW_ONE = 2'b01, PAUSE = 2'10,DRAW_TWO = 2'b11; 

    always @(*) begin
        next_states = states; 

        case (states)
        IDLE: begin
            if (en) next_states = DRAW_ONE;
        end
        DRAW_ONE: 
            if (d) next_states = PAUSE; 
            else next_states = DRAW_ONE;
        PAUSE:
            next_states = DRAW_TWO;
        DRAW_TWO: 
            if (d) next_states = IDLE;
            else next_states = DRAW_TWO;  
        default: next_states = IDLE; 
        endcase 
    end 

    always @(posedge clk) begin
        if (reset == 0) begin 
            states <= IDLE; 
        end 
        else begin
            states <= next_states; 
        end 
    end 

    always @(posedge clk) begin
        if (!reset) begin 
            x <= 0; 
        end 
        else if (states == IDLE || states == DONE) x <= 0;
        else if (states == PAUSE) x <= 1;
    end 

    assign a = counter[7:4];
    assign b = counter [3:0];

    sprite_write(clk,r,d,pixel_address,current_x,current_y);
    assign r = (states == DRAW_ONE || states == DRAW_TWO);
    assign done = (states == DONE);
    assign vga_x = 139+42*x+current_x; 
    assign vga_y = 377+current_y; 
    assign color = memory[{x?b:a,pixel_address}];
endmodule