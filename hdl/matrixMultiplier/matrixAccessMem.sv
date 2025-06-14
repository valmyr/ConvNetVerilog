module matrixAccessMem#(parameter AROWS = 3,ACOLUMNS = 3,BROWS = 3,BCOLUMNS = 3,WIDTH_BIT = 32)(
    input  logic clock     ,
    input  logic nreset    ,
    input  logic ena       ,
    input  logic [WIDTH_BIT-1:0] i         ,
    input  logic [WIDTH_BIT-1:0] j         ,
    input  logic [WIDTH_BIT-1:0] k         ,
    input  logic signed [WIDTH_BIT-1:0] MatrixA [AROWS-1:0][ACOLUMNS-1:0]  ,
    input  logic signed [WIDTH_BIT-1:0] MatrixB [BROWS-1:0][BCOLUMNS-1:0]  ,
    output logic signed [WIDTH_BIT-1:0] Aik       ,
    output logic                        working   ,
    output logic signed [WIDTH_BIT-1:0] Bkj       
); 

logic signed [WIDTH_BIT-1:0] tmpMaxtrixA;
logic signed [WIDTH_BIT-1:0] tmpMaxtrixB;
assign  Aik = ena ? MatrixA[i][k]: 0;
assign  Bkj = ena ? MatrixB[k][j]: 0;
endmodule