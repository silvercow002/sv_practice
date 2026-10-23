module testbench;
	logic clk, reset;
	logic [7:0] B;
	logic [7:0] W;
	
	
	FSM_prac prac0(
		.clk(clk),
		.reset(reset),
		.B(B),
		.W(W)
	);
	
	
	always #5 clk = ~clk;
	initial begin
		clk = 0; reset = 1;
		#10 reset = 0; B = 8'H00;
		#10 B = 8'H1A;
		#10 B = 8'H24;
		#10 B = 8'H20;
		#10 B = 8'H0F;
		#10 B = 8'HA1;
		#10 B = 8'H34;
		#200 $stop;
	end
endmodule
