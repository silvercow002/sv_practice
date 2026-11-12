module  pipe (
    input logic clk,
    input logic rst,
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [3:0] C,
    input logic [3:0] D,
    input logic [3:0] E
);

logic [3:0] ab, cd, abcd, e1, e2;


always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        ab <= 0;
        cd <= 0;
        abcd <= 0;
        e1 <= 0;
        e2 <= 0;
    end else begin
        ab <= A + B;
        cd <= C - D;
        abcd <= ab + cd;
        e1 <= E;
        e2 <= e1;
    end 
    
end

    
endmodule