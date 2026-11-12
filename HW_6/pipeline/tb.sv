`timescale 1ns/100ps

module tb();
    logic clk;
    logic rst;
    logic [3:0] A, B, C, D, E;

    localparam int TEST_COUNT = 10;
    logic [3:0] test_A [0:TEST_COUNT-1] = '{4'd6,  4'd4, 4'd1, 4'd8, 4'd6,  4'd11, 4'd6, 4'd11, 4'd7,  4'd2};
    logic [3:0] test_B [0:TEST_COUNT-1] = '{4'd7,  4'd8, 4'd9, 4'd7, 4'd10, 4'd9,  4'd8, 4'd10, 4'd4,  4'd8};
    logic [3:0] test_C [0:TEST_COUNT-1] = '{4'd8,  4'd7, 4'd6, 4'd3, 4'd3,  4'd6,  4'd2, 4'd4,  4'd10, 4'd11};
    logic [3:0] test_D [0:TEST_COUNT-1] = '{4'd3,  4'd3, 4'd3, 4'd7, 4'd3,  4'd5,  4'd7, 4'd3,  4'd7,  4'd13};
    logic [3:0] test_E [0:TEST_COUNT-1] = '{4'd10, 4'd1, 4'd5, 4'd2, 4'd10, 4'd6,  4'd1, 4'd2,  4'd9,  4'd5};

    pipe p(
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E)
    );

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        rst = 0;
        A = 0; B = 0; C = 0; D = 0; E = 0;

        #9;
        rst = 1;
        #20;
        rst = 0;
        @(negedge clk);

        for (int i = 0; i < TEST_COUNT; i++) begin
            A = test_A[i];
            B = test_B[i];
            C = test_C[i];
            D = test_D[i];
            E = test_E[i];
            @(negedge clk);
        end

        #200;

        $stop;
    end

endmodule