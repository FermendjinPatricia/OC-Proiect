module boothr4(
    input bgn, clk, rst_b, 
    input [7:0] inbus,
    output done,
    output [8:0] outbus
);
    wire[7:0] reg_m, reg_q;
    wire[8:0] reg_a, adder_output, mux_out;
    wire[1:0] cnt;
    wire q;
    wire c0, c1, c2, c3, c4, c5, c6, c7;

    control_unit inst7(.clk(clk),
                    .rst_b(rst_b),
                    .bgn(bgn),
                    .q1(reg_q[1]),
                    .q0(reg_q[0]),
                    .q(q),
                    .is_count_3(cnt == 2'b11),
                    .c0(c0),
                    .c1(c1),
                    .c2(c2),
                    .c3(c3),
                    .c4(c4),
                    .c5(c5),
                    .c6(c6),
                    .c7(c7),
                    .done(done));

    m inst0(.clk(clk),
            .rst_b(rst_b),
            .c0(c0),
            .in(inbus),
            .out(reg_m));

    q inst1(.clk(clk),
            .rst_b(rst_b),
            .c1(c1),
            .c5(c5),
            .c7(c7),
            .a0(reg_a[0]),
            .a1(reg_a[1]),
            .in(inbus[7:0]),
            .out(reg_q),
            .outbus(outbus));

    a inst2(.clk(clk),
            .rst_b(rst_b),
            .c0(c0),
            .c2(c2),
            .c5(c5),
            .c6(c6),
            .adder_input(adder_output),
            .out(reg_a),
            .outbus(outbus));

    q_neg inst3(.clk(clk),
                .rst_b(rst_b),
                .c0(c0),
                .c5(c5),
                .q1(reg_q[1]),
                .out(q));

    count inst4(.clk(clk),
                .rst_b(rst_b),
                .c0(c0),
                .c5(c5),
                .out(cnt));
    
    mux inst5(.c3(c3),
              .M({reg_m[7],reg_m[7:0]}),
              .dM({reg_m[7:0], 1'b0}),
              .out(mux_out));

    parallel_adder inst6(.cin(c4),
                         .a(reg_a),
                         .b(mux_out ^ {9{c4}}),
                         .out_add(adder_output));

endmodule

module boothr4_tb;
    reg bgn, clk, rst_b;
    reg [7:0] inbus;
    wire done;
    wire [8:0] outbus;

    boothr4 inst(.clk(clk),
                 .rst_b(rst_b),
                 .bgn(bgn),
                 .inbus(inbus),
                 .done(done),
                 .outbus(outbus));
                     
    localparam CLOCK_CYCLES = 20, CLOCK_PERIOD = 100, RST_PULSE = 25;

    initial begin 
        clk = 0;
        repeat(CLOCK_CYCLES * 2)
            #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    initial begin 
        rst_b = 0;
        #(RST_PULSE) rst_b = 1;
    end

    initial begin 
        inbus = 8'b11100101;
        #(200)
        inbus = 8'b10011111;
    end

    initial begin
        bgn = 1;
        #(200)
        bgn = 0;
    end
endmodule 