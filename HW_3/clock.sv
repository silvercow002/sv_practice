module clock(
	input logic clk,
	input logic rst,
	output logic [3:0] min,
	output logic [3:0] min_ten,
	output logic [3:0] hr,
	output logic [3:0] hr_ten
);



	logic  c2, c3, c4;
	logic r1, r2, r3, r4;


	counter _c1(
		.clk(clk),
		.rst(r1),
		.OUT(min)	
	);
	counter _c2(
		.clk(c2),
		.rst(r2),
		.OUT(min_ten)
	);
	counter _c3(
		.clk(c3),
		.rst(r3),
		.OUT(hr)		
	);
	counter _c4(
		.clk(c4),
		.rst(r4),
		.OUT(hr_ten)
	);



	always_comb begin
		r1 = rst & ~(min == 4'd10);
		c2 = (min == 4'd10) ? clk : 0;

		r2 = rst & ~(min_ten == 4'd6);
		c3 = (min_ten == 4'd6) ? clk : 0;

		r3 = rst & ~(hr ==  (hr_ten == 4'd2 ? 4'd4 : 4'd10));
		c4 = (hr == (hr_ten == 4'd2 ? 4'd4 : 4'd10)) ? clk :0;	


		r4 = rst & ~(hr_ten == 4'd3);

	end
	

endmodule
