module Reg_file(
    input logic clk,
    input logic rst,
    input logic write_regf_en,
    input logic [4:0] addr_rs1,
    input logic [4:0] addr_rs2,
    input logic [4:0] addr_rd,
    input logic [31:0] rd_value,

    output logic [31:0] rs1_value,
    output logic [31:0] rs2_value
);


logic [31:0] regs [0:31];
logic  addr_rd_not_0;

assign addr_rd_not_0 = | addr_rd;

assign rs1_value = regs[addr_rs1];
assign rs2_value = regs[addr_rs2];

always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        for (integer i=0; i < 32; i=i+1) begin
            regs[i] <= 0;
        end
    end else begin
        // write
        if (write_regf_en & addr_rd_not_0) begin
            regs[addr_rd] <= rd_value;
        end
    end
end



endmodule
