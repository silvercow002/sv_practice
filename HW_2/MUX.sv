module MUX(
	input logic [2:0] SEL,
	output logic [2:0] Y
);
	
	always_comb begin
		case(SEL)
		3'b000: Y = 3'b000;
		3'b001: Y = 3'b001;
		3'b010: Y = 3'b010;
		3'b011: Y = 3'b011;
		3'b100: Y = 3'b100;
		3'b101: Y = 3'b101;
		3'b110: Y = 3'b110;
		3'b111: Y = 3'b111;
		endcase
	end
endmodule
