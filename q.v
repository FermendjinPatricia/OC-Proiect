module q (
    input clk, rst_b, c5, c1, a0, a1,
    input [7:0] in,
    output reg [7:0] out, outbus
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b)  out <= 0;
        else if(c1) out <= in;
        else        out <= {a1, a0, out[7:2]};

    always @(*)
        if(c5) outbus = out;
endmodule 