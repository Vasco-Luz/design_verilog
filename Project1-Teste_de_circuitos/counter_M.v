module counter_M(
    input enable,
    input clk,
    input Reset,
    output reg carry_out_M,
    output reg [3:0] count_M // M = 12 logo 4 bits
);

   always @(posedge clk or posedge Reset) begin
        if (Reset) begin //reset
            count_M <= 4'd0;
            carry_out_M <= 0;
        end
        else if (enable && (count_M == 4'd12)) begin //basic carry out quando count_N = 5
            count_M <= 4'd0;
            carry_out_M <= 1;
        end
        else if (enable) begin // sum normal
            count_M <= count_M+4'd1;
            carry_out_M <= 0;
        end
    end


endmodule