module matrixCountIndex#(parameter AROWS = 3,ACOLUMNS = 3,BROWS = 3,BCOLUMNS = 3, WIDTH_BIT=32)(
    input logic clock       ,
    input logic nreset      ,
    output logic [WIDTH_BIT-1:0] i,
    output logic [WIDTH_BIT-1:0] j,
    output logic [WIDTH_BIT-1:0] k,
);


    always_ff@(posedge clock, negedge nreset) begin
        if(!nreset)begin
            i <= 0;
            j <= 0;
            k <= 0;
        end else begin
                k <= k <  ACOLUMNS     ? k + 1: 0   ;
                j <= k == ACOLUMNS - 1 ? j + 1      : 
                     j == BCOLUMNS - 1 ? 0    : j   ;
                i <= j == BCOLUMNS - 1 ? i+1        :
                     i == AROWS -1 ? : 0: i         ;
 
        end
    end
endmodule