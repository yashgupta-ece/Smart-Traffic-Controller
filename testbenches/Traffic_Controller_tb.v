`timescale 1ns/1ps

module Traffic_Controller_tb;

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

        // Generate waveform file
        $dumpfile("Traffic_Controller.vcd");
        $dumpvars(0, Traffic_Controller_tb);
        $monitor(
            "Time=%0t | Reset=%b | Emergency=%b | State=%b | Timer=%d | Red=%b | Yellow=%b | Green=%b | Emergency_out=%b",$time,Reset,Emergency,DUT.Current_state,DUT.timer,Red,Yellow,Green,Emergency_out);
        Clock = 1'b0;
        Reset = 1'b1;
        Emergency = 1'b0;
        #20;
        Reset = 1'b0;
        #250;
        $finish;
    end

endmodule