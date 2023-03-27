module m (
    input clk, rst_b, c0,
    input [7:0] in,
    output reg [7:0] out
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b)  out <= 0;
        else if(c0) out <= in;
endmodule
