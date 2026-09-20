`timescale 1ns/1ps

module PHASE_B_verification_tb;

reg Clock;
reg Reset;
reg Emergency;

wire Red;
wire Yellow;
wire Green;
wire Emergency_out;

Traffic_Controller DUT (
    .Clock(Clock),
    .Reset(Reset),
    .Emergency(Emergency),
    .Red(Red),
    .Yellow(Yellow),
    .Green(Green),
    .Emergency_out(Emergency_out)
);

always #5 Clock = ~Clock;

initial begin

    $dumpfile("Verification.vcd");
    $dumpvars(0, PHASE_B_verification_tb);

    $monitor(
        "Time=%0t | Reset=%b | Emergency=%b | State=%b | Timer=%d | Red=%b | Yellow=%b | Green=%b | Emergency_out=%b",
        $time, Reset, Emergency,
        DUT.Current_state, DUT.timer,
        Red, Yellow, Green, Emergency_out
    );

    Clock = 1'b0;
    Reset = 1'b1;Emergency = 1'b0;#12;
    Reset = 1'b0;#10;Emergency = 1'b1;#10;
    Emergency = 1'b0;#10;
    wait (DUT.Current_state == 3'b001);#2;
    Emergency = 1'b1;#10;
    Emergency = 1'b0;#10;
    wait (DUT.Current_state == 3'b010);#2;
    Emergency = 1'b1;#10;
    Emergency = 1'b0;#10;
    wait (DUT.Current_state == 3'b011);#2;
    Emergency = 1'b1;#10;
    Emergency = 1'b0;#30;
    $finish;

end

endmodule