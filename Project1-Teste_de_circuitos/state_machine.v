module counter_N(
    input enable,
    input clk,
    input reset,
    output reg carry_out_N
);
    reg [2:0] count_N; // N = 5

    always @(posedge clk or posedge reset) begin
        if (reset) begin // Reset
            count_N <= 3'd0;
            carry_out_N <= 0;
        end
        else if (enable && (count_N == 3'd5)) begin // Basic carry out when count_N = 5
            count_N <= 3'd0;
            carry_out_N <= 1; // Standard
        end
        else if (enable) begin // Normal increment
            count_N <= count_N + 3'd1;
            carry_out_N <= 0;
        end
    end
endmodule

module counter_M(//defeniçao do contador M
    input enable,
    input clk,
    input reset,
    output reg carry_out_M//standart
);
    reg [3:0] count_M; // M = 12 logo 4 bits
    always @(posedge clk or posedge reset) begin
        if (reset) begin //reset
            count_M <= 4'd0;
            carry_out_M <= 0;
        end
        else if (enable && (count_M == 4'd12)) begin //basic carry out quando count_M = 12
            count_M <= 4'd0;
            carry_out_M <= 1;
        end
        else if (enable) begin // sum normal
            count_M <= count_M+4'd1;
            carry_out_M <= 0;
        end
    end
endmodule

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

module state_machine(
    input clk,
    input reset,
    input start,
    output reg OUT,
    output reg BIS_END,
    output reg Running
);

reg carry_out_M, carry_out_N;
reg [1:0] state; 
reg [1:0] next_state; //4 estados 
reg [2:0] count_N ;
reg [3:0] count_M ;


wire [1:0] start_val,reset_val; //valores do shift reg

reg enable_count_N,enable_count_M;
wire carry_N; //enable dos contadores

localparam [1:0] IDLE=0,counting_N=1,
counting_M=2,finish=3;

counter_N cnt_N (
    .enable(enable_count_N),
    .clk(clk),
    .carry_out_N(carry_N),
    .reset(reset)
);
counter_M cnt_M (
    .enable(enable_count_M),
    .clk(clk),
    .carry_out_M(carry_M),
    .reset(reset)
);
shift_reg start_shift (
    .signal(start),
    .clk(clk),
    .val(start_val)
);
shift_reg reset_shift (
    .signal(reset),
    .clk(clk),
    .val(reset_val)
);

always @(posedge clk) begin
    if((reset == 1'b1))begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end


always @(*) begin
    case (state)
        IDLE: begin
            next_state = IDLE;
            enable_count_N = 0;
            Running = 0;
            OUT = 0;
            BIS_END = 0;
            if ((start_val[1:0] == 2'b10) && (Running == 1'b0) && (reset == 1'b0)) begin
                next_state = counting_N;
            end
            else begin
                next_state = IDLE;
            end

        end
        counting_N: begin
            enable_count_N = 1;
            Running = 1;
            OUT = 1;
            BIS_END = 0;
            if (carry_out_N == 1'b1) begin
                next_state = counting_M;
            end
            else begin
                next_state = counting_N;
            end
        end
        counting_M: begin
            enable_count_M = 1;
            Running = 1;
            OUT = 0;
            BIS_END = 0;
            if (carry_out_M == 1'b1) begin
                next_state = finish;
            end
            else begin
                next_state = counting_N;
            end
        end
        finish: begin
            next_state = finish;
            enable_count_N = 0;
            Running = 0;
            OUT = 0;
            BIS_END = 1;
        end
        default: next_state = IDLE;
    endcase
end
endmodule