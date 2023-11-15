module counter_N(
    input enable,
    input clk,
    input Reset,
    output reg carry_out_N,
    output reg [2:0] count_N
);

    always @(posedge clk or posedge Reset) begin
        if (Reset) begin
            count_N <= 3'd0;
            carry_out_N <= 0;
        end
        else if (enable && (count_N == 3'd5)) begin
            count_N <= 3'd0;
            carry_out_N <= 1;
        end
        else if (enable) begin
            count_N <= count_N + 3'd1;
            carry_out_N <= 0;
        end
    end

endmodule