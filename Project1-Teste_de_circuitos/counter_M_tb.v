`timescale 1ns / 100ps

module counter_M_tb;

    reg clk, reset, enable;
    wire carry_out_M;
    wire [3:0] count_M;

    counter_M cnt1 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .carry_out_M(carry_out_M),
        .count_M(count_M)
    );

    initial begin
        $dumpfile("simulation_output.vcd");

        // Dump all signals in the testbench
        $dumpvars(0, clk, reset, enable, carry_out_M, count_M); // Add signals to be dumped
        clk = 0;
        enable = 0;
    end

    always #2 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #40 enable = 1;
        #35 reset = 0;
        #35 reset = 1;
        #30 reset = 0;
        #600 $finish;
    end

endmodule
