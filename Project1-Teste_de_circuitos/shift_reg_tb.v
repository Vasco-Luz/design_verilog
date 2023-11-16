`timescale 1ns / 100ps

module shift_reg_tb;

    reg clk, signal;
    wire [1:0] val;

    shift_reg cnt1 (
        .clk(clk),
        .signal(signal),
        .val(val)
    );

    initial begin
        $dumpfile("simulation_output.vcd");
        // Dump all signals in the testbench
        $dumpvars(0, clk, signal, val); // Add signals to be dumped
        clk = 0;
        signal = 1;
    end

    always #2 clk = ~clk;

    initial begin
        clk = 0;
        #1signal = 0;
        #30 signal = 1;
        #30 signal = 0;
        #30 signal = 1;
        #30 signal = 0;
        #30 signal = 1;
        #30 $finish;
    end

endmodule