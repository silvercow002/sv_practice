`timescale 1ns/100ps
module Program_Rom(
	input	logic [31:0] Rom_addr,
	output	logic [31:0] Rom_data
);    
  
    always_comb begin
        case (Rom_addr)
			32'h0  : Rom_data = 32'h00100093;	//addi	x1, x0, 1	
			32'h4  : Rom_data = 32'h00300113;	//addi	x2, x0, 3	
			32'h8  : Rom_data = 32'hffb00193;	//addi	x3, x0, -5
			32'hc  : Rom_data = 32'hffa0a593;	//slti	x11, x1, -6    
			32'h10 : Rom_data = 32'hffa0b613;	//sltiu	x12, x1, -6   
			32'h14 : Rom_data = 32'h7ff0fa13;	//andi  x20, x1, 2047
			32'h18 : Rom_data = 32'h44216a93;	//ori   x21, x2, 1090
			32'h1c : Rom_data = 32'h3201cb13;	//xori  x22, x3, 800
			32'h20 : Rom_data = 32'h00109f93;	//slli  x31, x1, 1   
			32'h24 : Rom_data = 32'h0021df13;	//srli  x30, x3, 2
			32'h28 : Rom_data = 32'h4041de93;	//srai  x29, x3, 4
            default: Rom_data = 32'h00000013;   //NOP
        endcase
    end
endmodule












