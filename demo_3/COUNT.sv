module COUNT(
	input logic clk,
	input logic rst,
	output logic [2:0] cnt
);



always_ff @(posedge clk, posedge rst) begin
	if (rst) begin
		cnt <= 0;
	end else begin
		cnt <= cnt + 1;
	end	
end





endmodule

