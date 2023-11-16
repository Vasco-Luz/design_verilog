module shift_reg(
    input signal,
    input clk,
    output reg [1:0] val
);

    always @(posedge clk)
    begin
        val[1] <= val[0];
        val[0] <= signal;  // basic shift reg
    end

endmodule