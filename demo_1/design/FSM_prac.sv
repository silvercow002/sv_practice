module FSM_prac(
	input logic clk,
	input logic reset,
	input logic [7:0] B,
	output logic [7:0] W
);

	logic [7:0] S;
	logic [2:0] op;
	logic load_W;
	
	
	
	ALU alu(
		.A(W),
		.B(B),
		.op(op),
		.S(S)
	);

	
	REG Reg(
		.clk(clk),
		.reset(reset),
		.load_W(load_W),
		.S(S),
		.W(W)
	);
	
	
	controller con(
		.clk(clk),
		.reset(reset),		
		.cnt(),
		.op(op),
		.load_W(load_W)
	);
	
endmodule
