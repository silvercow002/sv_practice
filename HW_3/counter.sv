module counter(
	input logic clk,
	input logic rst,
	output logic [3:0] OUT
);


	always_ff @(posedge clk or negedge rst) begin
		if (!rst) begin
			OUT <= 0;			
		
		end else begin
			OUT <= OUT + 1;
		end
	end

endmodule
