module Traffic_Controller (
    input wire Clock,
    input wire Reset,
    input wire Emergency,
    output reg Emergency_out,
    output reg Red,
    output reg Yellow;
    output reg Green; 
);
    parameter RED = 3'b000;
    parameter YELLOW = 3'b001;
    parameter GREEN = 3'b010;
    parameter All_RED = 3'b010;
    parameter EMERGENCY = 3'b100;
    parameter [2:0] Current_state;
    parameter [2:0] Next_state;
    parameter [2:0] Previous_state;
    parameter [3:0] timer;
endmodule