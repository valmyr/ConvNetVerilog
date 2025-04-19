module indexMatrix#(parameter SIZE = 3,WIDTH_BIT = 8)(
    input   logic                 clock                               ,
    input   logic                 nreset                              ,
    output logic [WIDTH_BIT-1:0]  i                                   ,
    output logic [WIDTH_BIT-1:0]  j
);
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin 
            i <= 0;
            j <= 0;
        end
        else begin
            j <= (j   <  SIZE - 1           )   ? j + 1 : 0 ;
            i <= (i == SIZE-1 && j == SIZE-1)   ? 0     : 
                 (j == SIZE-1               )   ? i + 1 : i ;
        end
    end
endmodule