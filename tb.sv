module tb;
parameter SIZE =7, SIZEKer = 3, WIDTH_BIT = 8;
logic clock, nreset;
logic [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0];
logic [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0];

logic [WIDTH_BIT-1:0] outMatrix_IxK ;
logic [WIDTH_BIT-1:0] i, j ;
cnn #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) CNN1 
(
    .clock                          ,
    .nreset                         ,
    .inpMatrixI(inpMatrixIdinKer)         
);

indexMatrix #(.SIZE(SIZE-SIZEKer),.WIDTH_BIT(WIDTH_BIT)) sliced(
    .nreset,
    .clock,
    .i,
    .j
);
initial begin
    $readmemb("I.txt",inpMatrixI);
    clock =0;
    nreset = 0;
    #1 nreset = 1;
    repeat(40) #1 clock = ~clock;
end
always_ff@(posedge clock)begin
    inpMatrixIdinKer[0][0] = inpMatrixI[0+i][0+j];
    inpMatrixIdinKer[0][1] = inpMatrixI[0+i][1+j];
    inpMatrixIdinKer[0][2] = inpMatrixI[0+i][2+j];
    inpMatrixIdinKer[1][0] = inpMatrixI[1+i][0+j];
    inpMatrixIdinKer[1][1] = inpMatrixI[1+i][1+j];
    inpMatrixIdinKer[1][2] = inpMatrixI[1+i][2+j];
    inpMatrixIdinKer[2][0] = inpMatrixI[2+i][0+j];
    inpMatrixIdinKer[2][1] = inpMatrixI[2+i][1+j];
    inpMatrixIdinKer[2][2] = inpMatrixI[2+i][2+j];
end
endmodule