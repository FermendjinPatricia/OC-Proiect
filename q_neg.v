module q_neg (
    input clk, rst_b, c0, q1,
    output reg out
);
    always @(posedge clk, negedge rst_b) begin
        if(!rst_b)  out <= 0;
        else if(c0) out <= 0;
        else        out <= q1;
    end
endmodule
