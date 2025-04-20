module tb;
parameter SIZE =5, SIZEKer = 3, WIDTH_BIT = 8;
logic clock, nreset,ena;
logic [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0];
logic [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0];
logic [WIDTH_BIT-1:0] convIxKernel ;
logic [WIDTH_BIT-1:0] convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0] ;
logic [WIDTH_BIT-1:0] i, j, next,current;
conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT))top_conv (
    .clock(clock)       ,
    .nreset(nreset)     ,
    .inpMatrixI(inpMatrixI),
    .done(),
    .convIxKernelOut(convIxKernelOut)
);
initial begin
    $readmemh("simulation/I.txt",inpMatrixI);
    clock =0;
    #1nreset = 0;
    #1 nreset = 1;
    repeat(153)begin #1 clock = ~clock;end
    $writememh("simulation/IxKernel.txt",convIxKernelOut);
    for(integer i = 0; i < SIZE-SIZEKer+1; i++)begin
        for(integer j = 0; j < SIZE-SIZEKer+1; j++)begin
            $write(convIxKernelOut[i][j]);
        end
        $display("\n");
    end
end
endmodule
