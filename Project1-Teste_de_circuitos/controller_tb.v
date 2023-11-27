`timescale 1ns / 100ps



module controller_tb;
reg clk, start,reset;
wire BIST_END,OUT,Running;

controller cont(
    .start(start),
    .reset(reset),
    .clk(clk),
    .BIST_END(BIST_END),
    .OUT(OUT),
    .Running(Running)
);


initial begin
        $dumpfile("simulation_output.vcd");
        // Dump all signals in the testbench
        $dumpvars(0, clk,start,reset,BIST_END,OUT,Running); // Add signals to be dumped
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
        #400 start =0;
        #6 start = 1;
        #600 reset = 1;
        #5 start = 0;
        #5 start =1;
        #5 start = 0;
        #5 reset = 0;
        #10 start = 1;
        #10 start = 0;
        #20 reset = 1;
        #20 reset = 0;
        #20 start = 1;
        #600 $finish;
    end
    always #2 clk = ~clk;



endmodule