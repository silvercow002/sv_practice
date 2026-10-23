module ALU(
	input logic [7:0] A,
	input logic [7:0] B,
	input logic [2:0] OP,
	output logic [7:0] S	
	
);

	always_comb begin
		case(OP)
			3'b000: S = A + B;
			3'b001: S = A - B;
		endcase
	end
endmodule

