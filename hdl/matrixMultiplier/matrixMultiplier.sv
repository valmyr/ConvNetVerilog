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
logic working, donesum,standy,standy_next;

always_ff@(posedge clock, negedge nreset)begin
    if(!nreset)begin
        sum <= 0;
        standy <=0;
    end
    else begin
        sum <=sum_next;
        standy <= standy_next;
    end
end
assign prod = standy ? 0 : Aik*Bkj;
assign sum_next = j == 1 && k == 0 ? 0 : prod+sum;

always_comb case(!(k==ACOLUMNS-1&&!standy))
    0:standy_next=1;
    1:standy_next=0;
endcase
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
    .standy (standy  )    ,
    .nreset (nreset )      ,
    .ena    (ena    )      ,
    .i      (i      )      ,
    .j      (j      )      , 
    .k      (k      )
);


endmodule