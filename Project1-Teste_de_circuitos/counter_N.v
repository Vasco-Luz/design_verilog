module counter_N(//inputs do contador N
    input enable, //enable para controlar quando conta
    input clk, // clock, conta sincronamente co mo clock
    input reset,// reset reseta sincronamente
    output reg carry_out_N,// quando o valor da overflow, nest caso quando chega a 5
    output reg [2:0] count_N //N = 5 valor que se quer contar
);
    always @(posedge clk or posedge reset) begin //so começa sincronamente com o clock
        if (reset) begin //reset
            count_N <= 3'd0; //basic reset reset o valor do cotnador
            carry_out_N <= 0; //basic reset do carry out, reseta o carry out
        end
        if(enable)begin
            if(count_N == 3'd5)begin
                count_N <= 3'd0; // quando existe overflow
                carry_out_N <= 1;// sinal do carry out
            end
            else begin
                count_N <= count_N + 3'd1;//soma do contador
                carry_out_N <= 0;//limpar o valor do carryout
            end
        end
    end

endmodule