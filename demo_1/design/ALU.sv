module ALU(
	input logic [7:0] A,
	input logic [7:0] B,
	input logic [2:0] op,
	output logic [7:0] S
);

		always_comb
		begin
			case(op)
			3'b000: S = A + B;
			3'b001: S = A - B;
			3'b010: S = A & B;
			3'b011: S = A | B;
			3'b100: S = A ^ B;
			3'b101: S = ~A;
			3'b110: S = A + 1;
			3'b111: S = A - 1;
			endcase
		end
endmodule
