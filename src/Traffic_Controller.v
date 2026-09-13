module Traffic_Controller (
    input wire Clock,
    input wire Reset,
    input wire Emergency,
    output reg Emergency_out,
    output reg Red,
    output reg Yellow,
    output reg Green 
);
    parameter RED = 3'b000;
    parameter YELLOW = 3'b001;
    parameter GREEN = 3'b010;
    parameter All_RED = 3'b011;
    parameter EMERGENCY = 3'b100;
    reg [2:0] Current_state;
    reg [2:0] Next_state;
    reg [2:0] Previous_state;
    reg [3:0] timer;
    reg [3:0] state_duration;
   always @(*) begin
    case (Current_state)
        RED:       state_duration = 4'd5;
        YELLOW:    state_duration = 4'd3;
        GREEN:     state_duration = 4'd10;
        All_RED:   state_duration = 4'd2;
        EMERGENCY: state_duration = 4'd0;
        default:   state_duration = 4'd5;
    endcase
end
always @(posedge Clock or posedge Reset) begin

    if (Reset) begin
        Current_state  <= RED;
        Previous_state <= RED;
        timer <= 4'd0;
    end

    else if (Emergency && Current_state != EMERGENCY) begin
        Previous_state <= Current_state;
        Current_state  <= EMERGENCY;
        timer <= 4'd0;
    end

    else if (Current_state == EMERGENCY && !Emergency) begin
        Current_state <= Previous_state;
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
        EMERGENCY: begin
            if (!Emergency) begin
                Next_state=Previous_state;
            end else begin
                Next_state=EMERGENCY;
            end
        end
        default:Next_state=RED;
    endcase
end
always @(*) begin
    Red=1'b0;
    Yellow=1'b0;
    Green=1'b0;
    Emergency_out=1'b0;
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
        EMERGENCY:begin 
            Emergency_out=1'b1;
            Red=1'b1;
        end
        default:begin Red=1'b0;
        Yellow=1'b0;
        Green=1'b0;
        Emergency_out=1'b0;
        end
    endcase
end
endmodule