module testbench();
	logic [2:0] SEL;
	logic [2:0] Y;
	

	MUX mux(
		.SEL(SEL),
		.Y(Y)
	);
	
	
	initial begin
		#10  SEL = 3'b000;
		#10  SEL = 3'b001;
		#10  SEL = 3'b010;
		#10  SEL = 3'b011;
		#10  SEL = 3'b100;
		#10  SEL = 3'b101;
		#10  SEL = 3'b110;
		#10  SEL = 3'b111;
		#200 $stop;
	end
endmodule
