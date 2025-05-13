module matrixMultiplier#(parameter AROWS = 3,ACOLUMNS = 3,BROWS = 3,BCOLUMNS = 3, WIDTH_BIT=32)(
    input  logic clock                                               ,
    input  logic nreset                                              ,
    input  logic ena                                                 ,
    input  logic  signed[WIDTH_BIT-1:0] MatrixA [AROWS-1:0][ACOLUMNS-1:0]   ,
    input  logic  signed[WIDTH_BIT-1:0] MatrixB [BROWS-1:0][BCOLUMNS-1:0]   ,
    output logic signed[WIDTH_BIT-1:0] MatrixO [AROWS-1:0][BCOLUMNS-1:-0]  
);

logic [WIDTH_BIT-1:0] i,j,k;
logic signed [WIDTH_BIT-1:0] sum_current,sum_next,sum,prod,Aik,Bkj,counterSumCurrent, counterSum_next;
logic working, donesum;

always_ff@(posedge clock, negedge nreset)begin
    if(!nreset)begin
        sum_current <= 0;
        donesum = 0; 
    end
    else begin
        sum_current <= sum_next;
        donesum = k == ACOLUMNS - 1; 
    end
end
assign sum_next = donesum ? prod : !nreset ? 0 :sum_current + prod;
assign prod = Aik*Bkj;
assign sum = sum_current;
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
    .working    (   working    )
);


matrixCountIndex#(.AROWS(AROWS),.ACOLUMNS(ACOLUMNS),.BROWS(BROWS),.BCOLUMNS(BCOLUMNS))CountIndex(
    .clock  (clock  )      ,
    .nreset (nreset )      ,
    .ena    (ena    )      ,
    .i      (i      )      ,
    .j      (j      )      , 
    .k      (k      )
);


endmodule