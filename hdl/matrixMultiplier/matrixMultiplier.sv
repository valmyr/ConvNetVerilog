module matrixMultiplier#(parameter AROWS = 3,ACOLUMNS = 3,BROWS = 3,BCOLUMNS = 3, WIDTH_BIT=32)(
    //A[n][m] x B[m][p] = C[n][p]

    input logic clock                                               ,
    input logic nreset                                              ,
    input logic [WIDTH_BIT-1:0] MatrixA [AROWS-1:0][ACOLUMNS-1:0]   ,
    input logic [WIDTH_BIT-1:0] MatrixB [BROWS-1:0][BCOLUMNS-1:0]   ,
    output logic[WIDTH_BIT-1:0] MatrixO [AROWS-1:0][BCOLUMNS-1:-0]    
);

logic [WIDTH_BIT-1:0] sum;
logic [WIDTH_BIT-1:0] prod;

always_ff@(posedge clock, negedge nreset)begin
    if(!nreset)begin
        sum  <= 0;
        prod <= 0;
    end
    else begin
        sum <= ena ? sum + prod : 0;
    end
end

matrixAccessMem#(.AROWS(AROWS),.ACOLUMNS(ACOLUMNS),.BROWS(BROWS),.BCOLUMNS(BCOLUMNS))matrixAccess(
    .clock      (   clock      ),
    .nreset     (   nreset     ),
    .ena        (   ena        ),
    .i          (   i          ),
    .j          (   j          ),
    .k          (   k          ),
    .MatrixA    (   MatrixA    ),
    .MatrixB    (   MatrixB    ),
    .Aik        (   Aik        ),
    .Bkj        (   Bkj        ),
    .done       (   doneAccess )
);


matrixCountIndex#(.AROWS(AROWS),.ACOLUMNS(ACOLUMNS),.BROWS(BROWS),.BCOLUMNS(BCOLUMNS))CountIndex(
    .clock  (clock  )      ,
    .nreset (nreset )      ,
    .i      (i      )      ,
    .j      (j      )      , 
    .k      (k      )
);


endmodule