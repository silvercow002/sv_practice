module FSM(
	input logic clk,
	input logic rst,
	output logic done,
	output logic [7:0] W
);


logic [2:0] I, J;
logic inc_i, inc_j, rst_j;


// counter  i
always_ff @(posedge clk, posedge rst) begin
	if (rst) begin
		I <= 1;
	end else if (inc_i) begin
		I <= I + 1;
	end		
end

// counter j
always_ff @(posedge clk, posedge rst) begin
	if (rst) begin
		J <= 1;
	end else if (rst_j) begin
		J <= 0;
	end else if (inc_j) begin
		J <= J + 1;
	end		
end





// CMPI
assign i_eq_4 = (I==4);

// CMPJ
assign j_eq_i = (J==I);


// ACC
logic load_acc;
logic [7:0] acc;
always_ff @(posedge clk, posedge rst) begin
	if (rst) begin
		acc <= 0;
	end else if (load_acc) begin 
		acc <= acc + J;
	end
end

// W
logic load_w;
always_ff @(posedge clk, posedge rst) begin
	if (rst) begin 
		W <= 0;
	end else if (load_w) begin 
		W <= acc + J;
	end
end



// FSM
typedef enum logic [2:0] {
	t0, t1, t2, t3
}state_t;
state_t ps, ns;

always_ff @(posedge clk, posedge rst) begin
	if (rst) begin
		ps <= t0;
	end else begin
		ps <= ns;
	end		
end


always_comb begin
	inc_i = 0; inc_j = 0;
	rst_j = 0;
	load_w = 0; load_acc = 0;
	done = 0;
	case (ps)
	t0: begin
		//load_w = 1;
		load_acc = 1; 		



		if (j_eq_i) begin
			load_w = 1;
			if (i_eq_4) begin
				ns = t3;
			end else begin
				ns = t2;
			end
		end else begin
			ns = t1;
		end

	end


	t1: begin

		inc_j = 1;	

		ns = t0;
	end


	t2: begin
		inc_i = 1;
		rst_j = 1;
		ns = t0;
	end


	t3: begin
		done = 1;


		ns = t3;
	end

	endcase


end


endmodule

