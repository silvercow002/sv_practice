`timescale 1ns/100ps
module testbench;
	logic clk, reset;
	logic [7:0] W;
	logic done;
 
	FSM uut (.clk(clk), .rst(reset), .W(W), .done(done));
 
	always #5 clk = ~clk;
	initial begin
		clk = 0; reset = 1;
		#40 reset = 0;
		#300 $stop;
	end
endmodule
 
