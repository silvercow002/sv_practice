module FSM(
	input logic clk;
	input logic rst;	
);
	
logic [3:0] cnt1 ,cnt2;
logic [7:0] M;


COUNT c1(
	.clk(clk),
	.rst(rst),
	.cnt(cnt1)
);
COUNT c2(
	.clk(clk),
	.rst(rst),
	.cnt(cnt2)
);

always_comb begin
	
end









endmodule
