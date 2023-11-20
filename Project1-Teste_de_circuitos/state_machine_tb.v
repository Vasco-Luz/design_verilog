`timescale 1ns / 100ps



module state_machine_tb;



    reg clk, start,reset;
    wire OUT,Running,BIS_END;


    state_machine test (
        .clk(clk),
        .start(start),
        .reset(reset),
        .OUT(OUT),
        .Running(Running),
        .BIS_END(BIS_END)
    );

    initial begin
        $dumpfile("simulation_output.vcd");
        // Dump all signals in the testbench
        $dumpvars(0, clk, start,OUT,reset,BIS_END,Running); // Add signals to be dumped
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
        #3 start = 1;
        #33 $finish;
    end


    always #2 clk = ~clk;

endmodule