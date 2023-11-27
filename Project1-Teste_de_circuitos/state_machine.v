module state_machine( //inputs do block state machine
    input clk, //clock signal
    input start, // start signal
    input reset, // reset signal
    input wire [1:0] start_val, //valor dos flipflops poseedge
    input wire carry_out_N, // carry out N do contadores
    input wire carry_out_M, // cary out M do contador
    input wire [3:0] count_M, // valor do contador M
    output reg OUT, // val OUT
    output reg BIST_END, //BIST end
    output reg Running,// variavel se esta a correr
    output reg enable_count_N, //enabler do counter N
    output reg enable_count_M // enables do counter M
);

reg [1:0] state; // so para verificar o state no testbench
reg [1:0] next_state;//so para verificar o next_state no testbench
localparam [1:0] IDLE=0, counting_N=1, counting_M=2, finish=3; //nome dos estados

always @(posedge clk or posedge reset) begin
    if((reset == 1'b1))begin // reseta sincronamente com o reset, quando reseta muda instantaneamente os valores dos outputs, do shift reg e dos contadores
        state <= IDLE;
        Running = 0;
        OUT = 0;
        BIST_END = 0;
    end
    else begin
        state <= next_state; // update do estado com o clock
    end
end
always @(*) begin
    case (state)
        IDLE: begin
            if((start_val[1:0] == 2'b01) && (Running == 1'b0))begin // so começa quando existe uma variacao 0-1 do start e Running a 0
                next_state = counting_N;
                enable_count_N = 1;
                enable_count_M = 0;
                end
            else begin
                next_state = IDLE;
                enable_count_N = 0;
                enable_count_M = 0;
                Running = 0;
                OUT = 0;
                BIST_END = 0;
            end
        end
        counting_N: begin
            enable_count_N = 1;
            Running = 1;
            OUT = 1;
            BIST_END = 0;
            if (carry_out_N == 1'b1) begin
                if(count_M == 4'd12)begin
                    next_state = finish;
                    Running = 0;
                    OUT = 0;
                    BIST_END = 1;
                    enable_count_N = 0;
                    enable_count_M = 1;
                end

                else begin
                    enable_count_M = 1;
                    Running = 1;
                    OUT = 0;
                    BIST_END = 0;
                    next_state = counting_M;
                end
            end
            else begin
                next_state = counting_N;
                enable_count_M = 0;
            end
        end
        counting_M: begin
            next_state = counting_N;
            enable_count_M = 0;
            enable_count_N = 1;
            Running = 1;
            OUT = 1;
            BIST_END = 0;
        end
        finish: begin
            if(start_val[1:0] == 2'b01)begin
                next_state = counting_N;
                enable_count_N = 1;
                enable_count_M = 0;
            end
            else begin 
                next_state = finish;
                enable_count_N = 0;
                enable_count_M = 0;
                Running = 0;
                OUT = 0;
                BIST_END = 1;
            end
        end
        default: next_state = IDLE;
    endcase
end
endmodule