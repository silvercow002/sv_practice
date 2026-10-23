module testbench0();
	logic clk;
	logic rst;
	logic [3:0] OUT;
	
	counter cnt(
		.clk(clk),
		.rst(rst),
		.OUT(OUT)
	);
	

	initial begin
		clk = 0;
		rst = 0;
		#5 rst = 1;
		#300 $stop;
	end
	always #5 clk = ~clk;
endmodule
	
