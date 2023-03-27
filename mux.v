module mux (
    input clk, rst_b, c3,
    input [8:0]M, 2M,
    output reg [8:0] out
);
    always @(posedge clk, negedge rst_b) 
        if(!rst_b)  out <= 0;
        else if(c3) out <= 2M;
        else        out <= M;
endmodule
