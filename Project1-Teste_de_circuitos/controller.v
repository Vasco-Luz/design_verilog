
module controller(
    input start,
    input reset,
    input clk,
    output wire BIST_END,
    output wire Running,
    output wire OUT
);

wire carry_out_M,carry_out_N,enable_count_M,enable_count_N;
wire [3:0] count_M;
wire [2:0] count_N;
wire [1:0] start_val;

counter_N cnt_N (
    .enable(enable_count_N),
    .clk(clk),
    .carry_out_N(carry_out_N),
    .reset(reset),
    .count_N(count_N)
);

counter_M cnt_M (
    .enable(enable_count_M),
    .clk(clk),
    .carry_out_M(carry_out_M),
    .reset(reset),
    .count_M(count_M)
);

shift_reg start_shift (
    .signal(start),
    .clk(clk),
    .val(start_val),
    .reset(reset)
);

state_machine STATE2(
        .clk(clk),
        .reset(reset),
        .start(start),
        .Running(Running),
        .OUT(OUT),
        .BIST_END(BIST_END),
        .enable_count_M(enable_count_M),
        .enable_count_N(enable_count_N),
        .carry_out_M(carry_out_M),
        .carry_out_N(carry_out_N),
        .start_val(start_val),
        .count_M(count_M)
    );  

endmodule