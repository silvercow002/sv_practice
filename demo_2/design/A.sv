module A(
	input logic rst,
	input logic clk,
	output logic [2:0] A,	
	output logic [2:0] B,	
	output logic [2:0] C
);

	typedef enum logic [2:0] {
		t0, t1, t2, t3
	} state_t;
	state_t ps, ns;

	logic c1, c2, c3;

	always_ff @(posedge clk, posedge rst) begin
		if (rst) begin
			ps <= t0;
		end else begin
			ps <= ns;
		end
	end

	always_ff @(posedge clk) begin
		if (rst) begin
			A <= 3'b000;k
		end else if (c1) begin A <= A + 1;
		end else begin A <= A;
		end
	end

	always_ff @(posedge clk) beginj
		if (rst) B <= 3'b000;
		else if (c2) B <= B + 1;
		else B <= B;
	end


	always_ff @(posedge clk) begin
		if (rst) C <= 3'b000;
		else if (c3) C <= C + 1;
		else C <= C;
	end

	always_comb begin
		c1 = 0; c2 = 0; c3 = 0;
		case(ps)
			t0:
			begin 	
				if (A == 3'd5) ns = t1; 
				else begin
					c1 = 1;
					ns = t0;
				end

			end
			t1:
			begin 	
				if (B == 3'd6) ns = t2;
				else begin
					c2 = 1;
					ns = t1;
				end
			end
			t2:
			begin 	
				if (C == 3'd7) ns = t3;
				else begin
					c3 = 1;
					ns = t2;
				end
			end
			t3:
			begin 	
				ns = t3;
			end
		endcase
	
	end

endmodule
