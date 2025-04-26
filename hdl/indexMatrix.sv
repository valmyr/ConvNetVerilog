module indexMatrix#(parameter SIZELin = 3, SIZECol =3,WIDTH_BIT = 8)(
    input   logic                 clock                               ,
    input   logic                 nreset                              ,
    input   logic ena                                                 ,
    output logic [WIDTH_BIT-1:0]  i                                   ,
    output logic [WIDTH_BIT-1:0]  j
);

    always_ff@(posedge clock, negedge nreset)begin
        if(!nreset)begin 
            i <= 0;
            j <= 0;
        end
        else begin
            if(ena)
                if(i != SIZELin && j != SIZECol)begin
                    j <= (j   <  SIZECol - 1              )   ? j + 1 : 0 ;
                    i <= (i == SIZELin-1 && j == SIZECol-1)   ? 0     : 
                         (j == SIZECol-1                  )   ? i + 1 : i ;
                end else begin
                    j <= j;
                    i <= i;
                end
            else begin
                j <= j;
                i <= i;
            end
            // $display("%d %d",i,j);
        end
    end


endmodule
