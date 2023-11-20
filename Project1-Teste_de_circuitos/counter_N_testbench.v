`timescale 1ns / 100ps

module counter_N_testbench;

    reg clk, reset, enable;

    wire carry_out_N;

    wire [2:0] count_N;

    counter_N cnt1 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .carry_out_N(carry_out_N),
        .count_N(count_N)
    );

    initial begin
        $dumpfile("simulation_output.vcd");
        // Dump all signals in the testbench
        $dumpvars(0, counter_N_testbench);

        clk = 0;
        enable = 0;
    end
    always #2 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        #30 enable = 1;
        #35 reset = 0;
        #35 reset = 1;
        #30 reset = 0;
        #400 $finish;
    end

endmodule
