module tb;

parameter AROWS =3,ACOLUMNS = 3, BCOLUMNS =3, BROWS=3, WIDTH_BIT = 32;

logic clock                                               ;
logic nreset                                              ;
logic signed[WIDTH_BIT-1:0] MatrixA [AROWS-1:0][ACOLUMNS-1:0]   ;
logic signed[WIDTH_BIT-1:0] MatrixB [BROWS-1:0][BCOLUMNS-1:0]   ;
logic signed[WIDTH_BIT-1:0] MatrixO [AROWS-1:0][BCOLUMNS-1:-0]  ;
// logic [WIDTH_BIT-1:0] MatrixO [AROWS-1:0][BCOLUMNS-1:-0]  ;
initial begin
    MatrixA[0][0] = 1;
    MatrixA[0][1] = 2;
    MatrixA[0][2] = 3;
    MatrixA[1][0] = 4;
    MatrixA[1][1] = 5;
    MatrixA[1][2] = 6;
    MatrixA[2][0] = 7;
    MatrixA[2][1] = 8;
    MatrixA[2][2] = 9;

    
    MatrixB[0][0] = 9;
    MatrixB[0][1] = 8;
    MatrixB[0][2] = 7;
    MatrixB[1][0] = 6;
    MatrixB[1][1] = 5;
    MatrixB[1][2] = 4;
    MatrixB[2][0] = 3;
    MatrixB[2][1] = 2;
    MatrixB[2][2] = 1;
    clock = 1;
    nreset = 0;
    #10 nreset = 1;
    clock=1;
    #100 $finish;
end

always #1 clock = ~clock;
matrixMultiplier#(.AROWS(AROWS),.ACOLUMNS(ACOLUMNS),.BROWS(BROWS),.BCOLUMNS(BCOLUMNS),.WIDTH_BIT(WIDTH_BIT))dut(
    .clock  (clock  )                                    ,
    .nreset (nreset )                                    ,
    .MatrixA(MatrixA)                                    ,
    .MatrixB(MatrixB)                                    ,
    .MatrixO(MatrixO)                                    ,
    .ena     (1)
);

endmodule