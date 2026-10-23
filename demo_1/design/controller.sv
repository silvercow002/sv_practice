module controller(
	input logic clk,
	input logic reset,
	output logic [7:0] cnt,
	output logic load_W,
	output logic [2:0] op
);
	
	typedef enum logic [3:0] {
		T0, T1, T2, T3, T4, T5, T6, T7, T8
	} state_t;
	
	state_t ps, ns;
	
	
	always_ff @(posedge clk)
	begin
		if (reset) ps <= T0;
		else ps <= ns;
	end
	
	always_comb begin
		 ns = ps;
		 cnt = 8'h00;
		 load_W = 1'b0;
		 op = 3'b000;
	
		 case(ps)
		 // +
			T0:
			begin
				cnt = 8'h00;
				load_W = 1;
				op = 3'b000;
				ns = T1;
			end
		// + 
			T1:
			begin
				cnt = 8'h1A;
				load_W = 1;
				op = 3'b000;
				ns = T2;
			end
		// +
			T2:
			begin
				cnt = 8'h24;
				load_W = 1;
				op = 3'b000;
				ns = T3;
			end
			// -
			T3:
			begin
				cnt = 8'h20;
				load_W = 1;
				op = 3'b001;
				ns = T4;
			end
			// &
			T4:
			begin
				cnt = 8'h0F;
				load_W = 1;
				op =3'b010;
				ns = T5;
			end
			// |
			T5:
			begin
				cnt = 8'hA1;
				load_W = 1;
				op = 3'b011;
				ns = T6;
			end
			// ^
			T6:
			begin
				cnt = 8'h34;
				load_W = 1;
				op = 3'b100;
				ns = T7;
			end
			// +
			T7:
			begin
				cnt = 8'h01;
				load_W = 1;
				op = 3'b110;
				ns = T8;
			end
			// -
			T8:
			begin
				cnt = 8'h01;
				load_W = 1;
				op = 3'b111;
				ns = T8;
			end
		endcase
	end
	
			
			
endmodule
