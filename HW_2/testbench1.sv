module testbench1();
	logic [7:0] A;
	logic [7:0] B;
	logic [2:0] OP;
	logic [7:0] S;

	ALU alu(
		.A(A),
		.B(B),
		.OP(OP),
		.S(S)
	);
	
	
	initial begin
		#10 A = 8'h5; B = 8'hb; OP = 0; 
		#10 A = 8'hd; B = 8'h7; OP = 1; 
		#200 $stop;
	end
endmodule
