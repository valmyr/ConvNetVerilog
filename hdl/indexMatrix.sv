module indexMatrix#(parameter SIZELin = 3, SIZECol =3,WIDTH_BIT = 8,STEP = 1)(
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
                if(i <= SIZELin && j <= SIZECol)begin
                    j <= (j   <  SIZECol          )   ? j +STEP : 0 ;
                    i <= (i == SIZELin && j == SIZECol)   ? 0     : 
                         (j == SIZECol               )   ? i + STEP : i ;
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
