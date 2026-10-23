module A(
	input logic rst,	
	input logic clk,
	input logic [3:0] cp1,
	input logic [3:0] cp2,
	output logic [3:0] Y
	
	
);

	typedef enum logic [2:0] {
		t0, t1, t2, t3
	} state_t;
	state_t ps, ns;


	always_ff @(posedge clk, posedge rst) begin
		if (rst) begin
			ps <= t0;
		end else begin
			ps <= ns;
		end
	end	


	logic c1, c2;
	logic [3:0] A, B, W, S;

	always_ff @(posedge clk) begin
		if (rst) begin
			A <= cp1;
		end else if (c1) begin 
			A <= A + 1;
		end else begin
			A <= A;
		end
	end


	always_ff @(posedge clk) begin
		if (rst) begin
			B <= cp2;
		end else if (c1) begin 
			B <= B + 1;
		end else begin
			B <= B;
		end
	end

	always_comb begin
		S <= A + B;
	end

	always_ff @(posedge clk) begin
		if (rst) begin
			W <= 0;
		end else begin
			W <= S;
		end
	end

	always_comb begin
		if (W >= 0) begin
			Y <= W;
		end else begin
			Y <= 0;
		end
	end
	
	always_comb begin
		c1 = 0; c2 = 0;
		case (ps)
		t0:
		begin
			if (A == 4'd0) begin
				ns = t1;
			end else begin
				c1 = 1;
				ns = t0;
			end
		end

		t1:
		begin
			if (B == 4'd7) begin
				ns = t2;
			end else begin
				c2 = 1;	
				ns = t1;
			end
		end

		t2:
		begin
			ns = t2;
		end

		t3:
		begin
		end
		endcase
	end

endmodule

