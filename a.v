module a(
    input clk, rst_b, c0, c5, c2,
    input [8:0]adder_input,
    output reg [8:0]out, outbus
);
    always @(posedge clk, negedge rst_b) 
        if(!rst_b)  out <= 0;
        else if(c0) out <= 0;
        else if(c2) out <= adder_input;
        else        out <= {out[8], out[8], out[8:2]};

    always @(*)
        if(c5) outbus = out;
endmodule
