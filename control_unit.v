module control_unit(
    input clk, rst_b, bgn, q1, q0, q, is_count_3,
    output c0, c1, c2, c3, c4, c5, c6, done
);
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, S10 = 10, OP_STATE = 11;
    reg[3:0]state, state_next;
    integer operation_state;
    always @(*) begin
        case({q1, q0, q})
            3'b000: operation_state = S7;
            3'b111: operation_state = S7;
            3'b001: operation_state = S3;
            3'b010: operation_state = S3;
            3'b011: operation_state = S5;
            3'b100: operation_state = S6;
            3'b110: operation_state = S4;
            3'b101: operation_state = S4;
        endcase
        case(state)
            S0: state_next = (bgn) ? S1 : S0;
            S1: state_next = S2;
            S2: state_next = OP_STATE;
            OP_STATE: state_next = operation_state;
            S3: state_next = (is_count_3) ? S9 : S8;
            S4: state_next = (is_count_3) ? S9 : S8;
            S5: state_next = (is_count_3) ? S9 : S8;
            S6: state_next = (is_count_3) ? S9 : S8;
            S7: state_next = (is_count_3) ? S9 : S8;
            S8: state_next = OP_STATE;
            S9: state_next = S10;
            S10: state_next = S0;
        endcase
    end

    assign c0 = (state == S1);
    assign c1 = (state == S2);
    assign c2 = (state == S3) | (state == S4) | (state == S5) | (state == S6);
    assign c3 = (state == S5) | (state == S6);
    assign c4 = (state == S4) | (state == S6);
    assign c5 = (state == S8) | (state == S9);
    assign c6 = (state == S10);
    assign done = (state == S10);

    always @(posedge clk, negedge rst_b) 
        if(!rst_b) state <= 0;
        else state <= state_next;

endmodule