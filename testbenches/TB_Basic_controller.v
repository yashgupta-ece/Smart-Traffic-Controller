module tb_basic_controller;

reg Clock;
reg Reset;

wire Red;
wire Yellow;
wire Green;

basic_controller dut (
    .Clock(Clock),
    .Reset(Reset),
    .Red(Red),
    .Yellow(Yellow),
    .Green(Green)
);

always #5 Clock = ~Clock;

initial begin

    $dumpfile("basic_controller.vcd");
    $dumpvars(0, tb_basic_controller);

    $monitor("Time=%0t | Reset=%b | Red=%b Yellow=%b Green=%b",$time, Reset, Red, Yellow, Green);
    Clock = 0;Reset = 1;#10;
    Reset = 0;
    #220;

    $finish;
end

endmodule