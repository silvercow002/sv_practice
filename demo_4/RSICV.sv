module RSICV(
    input logic clk,
    input logic rst
);

`define I_NOP 32'h13

logic [31:0] Rom_addr, Rom_data;
Program_Rom rom(
    .Rom_addr(Rom_addr),
    .Rom_data(Rom_data)
);


// PC register
logic [31:0] pc, pc_next;
logic  rst_pc_, rst_pc;

assign rst_pc = rst | rst_pc_;
assign Rom_addr = pc;
assign pc_next = pc + 4;
always_ff @(posedge clk) begin
    if (rst_pc) begin
        pc <= 0;
    end else begin
        pc <= pc_next;
    end
end


// IFID
logic [31:0] inst_r, inst_r_;
logic  flush_IFID_;
assign inst_r_ = Rom_data;
assign rst_or_flush_IFID  = flush_IFID_ | rst;
always_ff @(posedge clk) begin
    if (rst_or_flush_IFID) begin
        inst_r <= `I_NOP;
        // pc_r 
    end else begin
        inst_r <= inst_r_;
    end

end




// INST_DEC
// R-type
logic [6:0] opcode_, funct7_;
logic [4:0] addr_rd_, addr_rs1_, addr_rs2_;
logic [2:0] funct3_;
logic [31:0] imm_;
assign opcode_ = inst_r[6:0];
assign addr_rd_ = inst_r[11:7];
assign funct3_ = inst_r[14:12];
assign addr_rs1_= inst_r[19:15];
assign addr_rs2_ = inst_r[24:20];
assign funct7_ = inst_r[31:25];
assign imm_ = {{20{inst_r[31]}}, inst_r[31:20]};


// controller
typedef enum { 
    t0, t1, t2, t3
} state_t;
state_t ps, ns;

always_ff @(posedge clk) begin
    if (rst) begin
        ps <= t0;
    end else begin
        ps <= ns;
    end
end


// IDEX
logic flush_IDEX_;
assign rst_or_flush_IDEX = flush_IDEX_ | rst;
logic [6:0] opcode, funct7;
logic [4:0] addr_rd, addr_rs1, addr_rs2;
logic [2:0] funct3;
logic [31:0] imm;
always_ff @(posedge clk) begin
    if (rst_or_flush_IDEX) begin
        opcode <= 0;
        addr_rd <= 0;
        addr_rs1 <= 0;
        addr_rs2 <= 0;
        funct3 <= 0;
        funct7 <= 0;
        imm <= 0;
    end else begin
        opcode <= opcode_;
        addr_rd <= addr_rd_;
        addr_rs1 <= addr_rs1_;
        addr_rs2 <= addr_rs2_;
        funct3 <= funct3_;
        funct7 <= funct7_;
        imm <= imm_;
    end
end


always_comb begin
    rst_pc_ = 0;
    // sel_pc = 0;
    flush_IFID_ = 0;
    flush_IDEX_ = 0;
    ns = ps;
    unique case(ps)
        t0: begin
            flush_IDEX_ = 1;
            flush_IFID_ = 1;
            rst_pc_ = 1;
            ns = t1;
        end
        t1: begin
            flush_IDEX_ = 1;
            flush_IFID_ = 1;
            rst_pc_ = 1;
            ns = t2;
            
        end
        t2: begin

        end

    endcase

end




























endmodule

