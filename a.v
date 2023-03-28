module a(
    input clk, rst_b, c0, c5, c2, c6,
    input [8:0]adder_input,
    output reg [8:0]out, outbus
);
    always @(posedge clk, negedge rst_b) 
        if(!rst_b)  out <= 0;
        else if(c0) out <= 0;
        else if(c2) out <= adder_input;
        else if(c5) out <= {out[8], out[8], out[8:2]};

    always @(*)
        outbus = (c6) ? out : 9'bz;
endmodule
