module parallel_adder (
    input cin,
    input [8:0]a, b,
    output [8:0]out_add
);
    wire c0, c1, c2, c3, c4, c5, c6;
    wire [8:0]out;

    fac fac0(.a(a[0]), .b(b[0]), .cin(cin), .out(out[0]), .cout(c0));
    fac fac1(.a(a[1]), .b(b[1]), .cin(c0), .out(out[1]), .cout(c1));
    fac fac2(.a(a[2]), .b(b[2]), .cin(c1), .out(out[2]), .cout(c2));
    fac fac3(.a(a[3]), .b(b[3]), .cin(c2), .out(out[3]), .cout(c3));
    fac fac4(.a(a[4]), .b(b[4]), .cin(c3), .out(out[4]), .cout(c4));
    fac fac5(.a(a[5]), .b(b[5]), .cin(c4), .out(out[5]), .cout(c5));
    fac fac6(.a(a[6]), .b(b[6]), .cin(c5), .out(out[6]), .cout(c6));
    fac fac7(.a(a[7]), .b(b[7]), .cin(c6), .out(out[7]), .cout(c7));
    fac fac8(.a(a[8]), .b(b[8]), .cin(c7), .out(out[8]), .cout());
    
    assign out_add = out;
endmodule


