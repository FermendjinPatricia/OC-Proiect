module mux (
    input c3,
    input [8:0]M, dM,
    output [8:0] out
);
    assign out = (c3) ? dM : M;

endmodule
