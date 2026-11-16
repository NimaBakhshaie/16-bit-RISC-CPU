`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 10;
        reg [1:0] KEY;

	initial begin
                KEY[0] <= 1'b0;
	end // initial

	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) KEY[0] <= ~KEY[0];
	end

        initial begin 
        $readmemh("rom.hex", CPU.ROM.memory_array);
        KEY[1] <= 1'b1;
        #1 KEY[1] <= 1'b0;
        #1 KEY[1] <= 1'b1;
	end 
	top CPU (KEY);

endmodule
