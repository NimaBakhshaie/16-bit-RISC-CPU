module program_counter(enableI, enableL, L, resetn, clk, C);
    input enableI, enableL, resetn, clk;
    input [7:0] L;

    output reg [7:0] C;

    always @(posedge clk or negedge resetn)
        if (resetn == 0)
            C <= 0;
        else if (enableL == 1)
            C <= L;
        else if (enableI == 1)
            C <= C + 1;
endmodule