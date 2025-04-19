module tb;
parameter SIZE =7, SIZEKer = 3, WIDTH_BIT = 8;
logic clock, nreset,ena;
logic [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0];
logic [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0];
logic [WIDTH_BIT-1:0] convIxKernel ;
logic [WIDTH_BIT-1:0] convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0] ;
logic [WIDTH_BIT-1:0] i, j, next,current;
conv2 #(.SIZE(SIZE),.SIZEKer(3),.WIDTH_BIT(8))top_conv (
    .clock(clock)       ,
    .nreset(nreset)     ,
    .inpMatrixI(inpMatrixI),
    .done(),
    .convIxKernelOut(convIxKernelOut)
);
initial begin
    $readmemb("simulation/I.txt",inpMatrixI);
    clock =0;
    #1nreset = 0;
    #1 nreset = 1;
    repeat(153)begin #1 clock = ~clock;end
    $writememh("simulation/IxKernel.txt",convIxKernelOut);
end
endmodule
