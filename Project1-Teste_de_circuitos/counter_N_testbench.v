`timescale 1ns / 100ps

module counter_N_testbench;

    reg clk, reset, enable;
    wire carry_out_N;
    wire [2:0] count_N;

    counter_N cnt1 (
        .clk(clk),
        .Reset(reset),
        .enable(enable),
        .carry_out_N(carry_out_N),
        .count_N(count_N)
    );

    initial begin
        $dumpfile("simulation_output.vcd");

        // Dump all signals in the testbench
        $dumpvars(0, counter_N_testbench);
        clk = 0;
    end

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #30 enable = 1;
        #30 reset = 0;
        #30 reset = 1;
        #30 reset = 0;
        #30 $finish;
    end

endmodule