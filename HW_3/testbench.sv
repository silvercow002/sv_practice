module testbench;

	logic clk, reset;
	logic [3:0] min;
	logic [3:0] min_ten;
	logic [3:0] hr;
	logic [3:0] hr_ten;
	

	clock u_clock(
		.clk		(clk	),
		.rst		(reset	),
		.min		(min	),
		.min_ten	(min_ten),
		.hr			(hr		),
		.hr_ten		(hr_ten	)
	);

	always #5 clk = ~clk;
	initial begin
		clk = 0;	reset = 0;
		#15 reset = 1;
		#500000 $stop;
	end
endmodule