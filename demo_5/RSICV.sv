`include "define.sv"
module RSICV(
    input logic clk,
    input logic rst
);


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
logic [31:0] imm_, IMM_I;
assign opcode_ = inst_r[6:0];
assign addr_rd_ = inst_r[11:7];
assign funct3_ = inst_r[14:12];
assign addr_rs1_= inst_r[19:15];
assign addr_rs2_ = inst_r[24:20];
assign funct7_ = inst_r[31:25];

assign IMM_I = {{20{inst_r[31]}}, inst_r[31:20]};

always_comb begin
    unique case(opcode_)
        `Opcode_I:
            imm_ = IMM_I;
    endcase
end 


// controller
logic write_regf_en_, write_regf_en_r;
logic [3:0] op_, op_r;



logic [31:0] rd_value_, rs1_value, rs2_value;
logic [4:0] addr_rd_r;
Reg_file reg_file(
    .clk(clk),
    .rst(rst),
    .write_regf_en_r(write_regf_en_r),
    .addr_rs1(addr_rs1_),
    .addr_rs2(addr_rs2_),
    .addr_rd_r(addr_rd_r),
    .rd_value_(rd_value_),

    .rs1_value(rs1_value),
    .rs2_value(rs2_value)
);






// IDEX
logic flush_IDEX_;
assign rst_or_flush_IDEX = flush_IDEX_ | rst;
logic [31:0] imm_r, rs1_value_r, rs2_value_r;
always_ff @(posedge clk) begin
    if (rst_or_flush_IDEX) begin
        // controller
        op_r <= 0;
        write_regf_en_r <= 0;
        // inst_dec
        addr_rd_r <= 0;
        imm_r <= 0;
        // reg_file
        rs1_value_r <= 0;
        rs2_value_r <= 0;
    end else begin
        // controller
        op_r <= op_;
        write_regf_en_r <= write_regf_en_;
        // inst_dec
        addr_rd_r <= addr_rd_;
        imm_r <= imm_;
        // rsg_file
        rs1_value_r <= rs1_value;
        rs2_value_r <= rs2_value;
    end
end


logic [31:0] alu_out, alu_a, alu_b;
assign rd_value_ = alu_out, alu_a = rs1_value_r, alu_b = imm_r;
// ALU
always_comb begin
    unique case(op_r)
        `ALUOP_ADD: 
            alu_out = alu_a + alu_b;
        `ALUOP_SUB:
            alu_out = $signed(alu_a) - $signed(alu_b);
        `ALUOP_AND:
            alu_out = alu_a & alu_b;
        `ALUOP_OR:
            alu_out = alu_a | alu_b;
        `ALUOP_XOR:
            alu_out = alu_a ^ alu_b;
        `ALUOP_A:
            alu_out = alu_a;
        `ALUOP_A_ADD_4:
            alu_out = alu_a + 4;
        `ALUOP_LTU:
            alu_out = alu_a < alu_b;
        `ALUOP_LT:
            alu_out = $signed(alu_a) < $signed(alu_b);
        `ALUOP_SLL:
            alu_out = alu_a << alu_b[4:0];
        `ALUOP_SRL:
            alu_out = alu_a >> alu_b[4:0];
        `ALUOP_SRA:
            alu_out = $signed(alu_a) >>> $signed(alu_b);
        `ALUOP_B:
            alu_out = alu_b;
        default:
            alu_out = alu_a;
    endcase
end



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
            unique case(opcode_)
                `Opcode_I: begin
                    write_regf_en_ = 1;
                    unique case(funct3_)
                        `F_ANDI:
                            op_ = `ALUOP_AND;
                        `F_SLTI:
                            op_ = `ALUOP_LT;
                        `F_SLTIU:
                            op_ = `ALUOP_LTU;
                        `F_ORI:
                            op_ = `ALUOP_OR;
                        `F_XORI:
                            op_ = `ALUOP_XOR;
                        `F_SLLI:
                            op_ = `ALUOP_SLL;
                        `F_SRLI_SRAI: begin
                            if (funct7_ == `F7_SRLI) begin
                            end else if (funct7_ == `F7_SRAI) begin
                                op_ = `ALUOP_SRA;
                            end
                        end
                        default:
                            op_ = `ALUOP_ADD;
                    endcase
                end
            endcase
        end

    endcase

end




























endmodule

