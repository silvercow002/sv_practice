module tb();
	logic rst, clk;
	logic [3:0] cp1, cp2, Y;

	A a(
		.rst(rst),
		.clk(clk),
		.cp1(cp1),
		.cp2(cp2),
		.Y(Y)		
	);
	

	
	always begin
		#5 clk = ~clk;
	end

	initial begin
		clk = 0; rst = 0;
		cp1 = -4'd5;
		cp2 = 4'd0;
		#1 rst = 1;
		#9 rst = 0;


		
		#30000 $stop;
	end


endmodule
