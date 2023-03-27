module q (
    input clk, rst_b, c5, c1, a0, a1,
    input [7:0] in,
    output reg [7:0] out, outbus
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b) out <= 0;
        else if(c1) out <= in;
        else out <= {a1, a0, out[7:2]};

    always @(*)
        if(c5) outbus = out;
endmodule 

module q_tb;
    reg clk, rst_b, c5, c1, a0, a1;
    reg [7:0] in;
    wire [7:0] out, outbus;

    q q1(.clk(clk),
         .rst_b(rst_b),
         .c5(c5),
         .c1(c1),
         .a0(a0),
         .a1(a1),
         .in(in),
         .out(out),
         .outbus(outbus));
    
    localparam CLOCK_CYCLES = 10, CLOCK_PERIOD = 50, RST_PULSE = 25;
    initial begin 
        clk = 0;
        in = 8'b01110101;
        repeat(CLOCK_CYCLES * 2)
            #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    initial begin 
        rst_b = 0;
        c5 = 0;
        a0 = 0;
        a1 = 1;
        c1 = 1;
        #(RST_PULSE) rst_b = 1;
        #(75) c1 = 0;
        #(300) c5 = 1;
    end



endmodule