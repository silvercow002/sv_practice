module REG(
	input logic [7:0] S,
	input logic clk,
	input logic reset,
	input logic load_W,
	output logic [7:0] W
	
);

always_ff @(posedge clk) begin
	if (reset) 
		W <= 8'h00;
	else if (load_W) 
		W <= S;
end


endmodule
