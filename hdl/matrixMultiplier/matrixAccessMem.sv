module matrixAccessMem#(.AROWS(AROWS),.ACOLUMNS(ACOLUMNS),.BROWS(BROWS),.BCOLUMNS(BCOLUMNS),.WIDTH_BIT(WII))matrixAccess(
    input  logic clock     ,
    input  logic nreset    ,
    input  logic ena       ,
    input  logic [WIDTH_BIT-1:0] i         ,
    input  logic [WIDTH_BIT-1:0] j         ,
    input  logic [WIDTH_BIT-1:0] k         ,
    input  logic [WIDTH_BIT-1:0] MatrixA [AROWS-1:0][ACOLUMNS-1:0]  ,
    input  logic [WIDTH_BIT-1:0] MatrixB [BROWS-1:0][BCOLUMNS-1:0]  ,
    output logic [WIDTH_BIT-1:0] Aik       ,
    output logic [WIDTH_BIT-1:0] Bkj       
);


always_ff @(posedge clock, negedge nreset ) begin 
    if(!nreset)begin
        Aik <= 0;
        Bkj <= 0;
    end else begin
        Aik <= ena ? MatrixA[i][k]: 0;
        Bkj <= ena ? MatrixB[k][j]: 0;
    end
    
end
endmodule