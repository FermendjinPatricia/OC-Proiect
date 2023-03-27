module count (
    input clk, rst_b, c0,
    output reg [1:0] out
);
    always @(posedge clk, negedge rst_b) 
        if(!rst_b)  out <= 0;
        else if(c0) out <= 0;
        else        out <= out + 1;
endmodule