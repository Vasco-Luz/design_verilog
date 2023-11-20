module shift_reg(
    input signal,
    input clk,
    input reset,
    output reg [1:0] val
);
    always @(posedge clk or posedge reset)
    begin
        if(reset == 1'b1)begin
            val <= 2'bxx; //xx para ser indeterminado como diz no enunciado
        end
        else begin
            val[1] <= val[0]; //serve para controlar as variaveis do start e reset
            val[0] <= signal;  // basic shift reg
        end
    end
endmodule