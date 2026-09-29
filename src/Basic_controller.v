module basic_controller (
    input wire Clock,
    input wire Reset,
    output reg Red,
    output reg Yellow,
    output reg Green
);
    parameter RED = 2'b00;
    parameter YELLOW = 2'b01;
    parameter GREEN = 2'b10;
    parameter All_RED = 2'b11;
    reg [1:0] Current_state;
    reg [1:0] Next_state;
    reg [3:0] timer;
    reg [3:0] state_duration;

    always @(*) begin
    case (Current_state)
        RED:       state_duration = 4'd5;
        YELLOW:    state_duration = 4'd3;
        GREEN:     state_duration = 4'd10;
        All_RED:   state_duration = 4'd2;
        default:   state_duration = 4'd5;
    endcase
end
always @(posedge Clock or posedge Reset) begin

    if (Reset) begin
        Current_state  <= RED;
        timer <= 4'd0;
    end

    else if (timer == state_duration - 1) begin
        Current_state <= Next_state;
        timer <= 4'd0;
    end

    else begin
        timer <= timer + 4'd1;
    end
end
always @(*) begin
    Next_state=Current_state;
    case (Current_state)
        RED:begin
            Next_state=YELLOW;
        end 
        YELLOW:begin
            Next_state=GREEN;
        end
        GREEN:begin
            Next_state=All_RED;
        end
        All_RED:begin
            Next_state=RED;
        end
        default:Next_state=RED;
    endcase
end
always @(*) begin
    Red=1'b0;
    Yellow=1'b0;
    Green=1'b0;
    case (Current_state)
        RED:begin 
            Red=1'b1;
        end
        YELLOW:begin 
            Yellow=1'b1;
        end
        GREEN:begin 
            Green=1'b1;
        end
        All_RED:begin Red=1'b1;
        Yellow=1'b1;
        Green=1'b1;
        end
        default:begin Red=1'b0;
        Yellow=1'b0;
        Green=1'b0;
        end
    endcase
end

endmodule