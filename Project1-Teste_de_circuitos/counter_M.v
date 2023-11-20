module counter_M(
    input enable, //enable para deixar contar
    input clk, // sincrono com o clock
    input reset, // reset
    output reg carry_out_M,//carry out do M
    output reg [3:0] count_M // M = 12 logo 4 bits
);
   always @(posedge clk or posedge reset) begin // mesma coisa que o N
        if (reset) begin //reset
            count_M <= 4'd0;
            carry_out_M <= 0;
        end
        if(enable)begin
            if(count_M == 4'd12)begin
                count_M <= 4'd0;
                carry_out_M <= 1; //carry out nao e usado mas esta aui pq faz parte de um counter
            end
            else begin
                count_M <= count_M+4'd1;
                carry_out_M <= 0;
            end
        end
    end
endmodule