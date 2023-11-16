module counter_N( //defenição do contador do N
    input enable,
    input clk,
    input Reset,
    output reg carry_out_N,
    output reg [2:0] count_N //N = 5
);

    always @(posedge clk or posedge Reset) begin
        if (Reset) begin //reset
            count_N <= 3'd0;
            carry_out_N <= 0;
        end
        else if (enable && (count_N == 3'd5)) begin //basic carry out quando count_N = 5
            count_N <= 3'd0;
            carry_out_N <= 1;//standary
        end
        else if (enable) begin // sum normal
            count_N <= count_N + 3'd1;
            carry_out_N <= 0;
        end
    end
endmodule
module counter_M(//defeniçao do contador M
    input enable,
    input clk,
    input Reset,
    output reg carry_out_M,//standart
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









module state_machine(
    input clk,
    input reset,
    input start,
    output OUT,
    output BIS_END,
    output RUNNING
);
reg carry_out_M, carry_out_N;
reg [1:0] state, next_state; //4 estados 
reg [2:0] count_N;
reg [3:0] count_M;



reg start_current,
start_previus,
reset_current,
reset_previus;

localparam [1:0] IDLE=0,counting_N=1,
counting_M=2,finish=3;



always @(posedge clk)
begin

end

always @(*)
begin
case(state)
endcase
end

endmodule




