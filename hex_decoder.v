module hex_decoder(X, HEX);

    input [3:0] X;
    output [6:0] HEX;
    wire A, B, C, D;

    assign A = X[3];
    assign B = X[2];
    assign C = X[1];
    assign D = X[0];

 
    assign HEX[0] = (~A & ~B & ~C & D) | (~A & B & ~C & ~D) | (A & ~B & C & D) |(A & B & ~C & D);
    assign HEX[1] = (A & C & D) | (A & B & ~D) |(B & C & ~D) |(~A & B & ~C & D);
    assign HEX[2] = (A & B & C) |(A & B & ~D) |(~A & ~B & C & ~D);
    assign HEX[3] = (B & C & D) |(A & ~B & C & ~D) |(~A & B & ~C & ~D) |(~A & ~B & ~C & D);
    assign HEX[4] = (~A & D) |(~A & B & ~C) |(~B & ~C & D);
    assign HEX[5] = (~A & C & D) |(~A & ~B & C) |(~A & ~B & D) |(A & B & ~C & D);
    assign HEX[6] = (~A & B & C & D) |(~A & ~B & ~C) |(A & B & ~C & ~D);

endmodule 