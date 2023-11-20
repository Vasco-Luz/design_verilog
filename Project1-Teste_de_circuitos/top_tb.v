`timescale 1ns / 100ps





module top_tb;


    reg clk, start,reset;
    wire carry_out_M,carry_out_N,enable_count_M,enable_count_N,OUT,BIST_END,Running;
    wire [3:0] count_M;
    wire [2:0] count_N;
    wire [1:0] state,next_state,start_val,reset_val;

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
 
    state_machine_2 STATE2(
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
        .state(state),
        .next_state(next_state),
        .start_val(start_val),
        .count_M(count_M)
    );  


    initial begin
        $dumpfile("simulation_output.vcd");
        // Dump all signals in the testbench
        $dumpvars(0, clk, start,OUT,reset,BIST_END,Running,start_val,next_state,state,carry_out_M,carry_out_N,enable_count_M,enable_count_N,count_N,count_M); // Add signals to be dumped
        clk = 0;
        start = 0;
        reset = 1;
        #3 start = 1;
        #4 reset = 0;
        #3 start = 1;
        #8 start = 0;
        #8 start = 1;
        #70 start = 0;
        #3 start = 1;
        #3start = 0;
        #3 start = 1;
        #3 start = 0;
        #3 start = 1;
        #33 start = 0;
        #3 start = 0;
        #400 $finish;
    end
    always #2 clk = ~clk;
endmodule