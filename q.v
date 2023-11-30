module q (
    input clk, rst_b, c5, c1, a0, a1, c6,
    input [7:0] in,
    output reg [7:0] out, 
    output reg [16:0] outbus
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b)  out <= 0;
        else if(c1) out <= in;
        else if(c5) out <= {a1, a0, out[7:2]};

    always @(*)
        if(c6)
            outbus[7:0] = out;
        else 
            outbus = 17'bz;
endmodule 