`timescale 1ns/100ps
module tb();

logic rst, clk;


RSICV v(
    .clk(clk),
    .rst(rst)
);


always begin
    clk = ~clk;
    #10;
end

initial begin
    rst = 0; clk = 0;
    #9;
    rst = 1;
    #30;
    rst = 0;
    #10000;
    $stop;

end

endmodule