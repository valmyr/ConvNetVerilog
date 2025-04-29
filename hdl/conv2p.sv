// `define WINDOWING = SIZE/$sqrt(3)
module conv2#(parameter SIZE =320, SIZEKer = 3, WIDTH_BIT = 16, SUBIMAGENS = 2)//sqrt(n**2)
(
    input   logic                               clock                                                           ,
    input   logic                               nreset                                                          ,
    input   logic  signed  [WIDTH_BIT-1:0]      inpMatrixI          [SIZE-1:0][SIZE-1:0]                        ,        
    output  logic                               done                                                            ,
    output  logic  signed  [WIDTH_BIT-1:0]      convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0]
);
logic ena;
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer[SUBIMAGENS-1:0][SUBIMAGENS-1:0][SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] convIxKernel[SUBIMAGENS-1:0][SUBIMAGENS-1:0];
logic  signed [WIDTH_BIT-1:0] subdivisoes[SUBIMAGENS-1:0][SUBIMAGENS-1:0];
logic [WIDTH_BIT-1:0] i, ii, j, jj, next,current;
generate
    for(genvar s = 0; s < SUBIMAGENS; s++)begin:CONVMOD2
        for(genvar w = 0; w < SUBIMAGENS; w++)begin:CONVMOD2_
            conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNV(
                .clock                              (                 clock             ),
                .nreset                             (       nreset                      ),
                .inpMatrixI                         (       inpMatrixIdinKer[s][w]       ),
                .convIxKernel                       (       convIxKernel[s][w]           )            
            );
        end
    end
endgenerate
    indexMatrix #(.SIZELin(SIZE/SUBIMAGENS-SIZEKer+1+2),.SIZECol(SIZE/SUBIMAGENS-SIZEKer+1+2),.WIDTH_BIT(WIDTH_BIT))slicedIndexVertic
    (
        .nreset                                 (       nreset                      ),
        .clock                                  (       clock                       ),
        .i                                      (       i                           ),
        .ena                                    (       ena                         ),
        .j                                      (       j                           )
    );
    indexMatrix #(.SIZELin(SIZE-SIZEKer+1),.SIZECol(SIZE-SIZEKer+1),.WIDTH_BIT(WIDTH_BIT))slicedIndexOut
    (
        .nreset                                 (       nreset                      ),
        .clock                                  (       clock                       ),
        .i                                      (       ii                         ),
        .ena                                    (       ena                         ),
        .j                                      (       jj                         )
    );
    //Constantes usadas nas sub janelas de cada sub imagem
    initial begin
        integer f = 0;
        for(integer  s = 0; s < SUBIMAGENS; s++)begin
            for(integer w = 0; w < SUBIMAGENS; w++)begin
                subdivisoes[s][w] = f;
                f+=SIZE/(SUBIMAGENS*SUBIMAGENS);
            end
        end

    end
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin
            for(integer k=0; k < SIZEKer; k++)
                for(integer l = 0; l < SIZEKer; l++)
                    for(integer s = 0; s < SUBIMAGENS; s++)
                        for(integer w = 0; w < SUBIMAGENS; w++)
                            inpMatrixIdinKer[s][w][k][l] <= 0;
            ena     <= 0;
            current <= 0;
            done    <= 0;
        end else begin
            case(current)
             0:begin
                ena <= 0;
                for(integer s = 0; s < SUBIMAGENS; s++)
                    for(integer w = 0; w < SUBIMAGENS; w++)
                        for(integer k = 0; k < SIZEKer; k++)
                            for(integer l = 0; l < SIZEKer; l++)
                                inpMatrixIdinKer[s][w][k][l] <= inpMatrixI[k+i+subdivisoes[s][w]][l+j+subdivisoes[s][w]];
                                // $write("%d",subdivisoes[s][w]);
                            // $display("\n");
                // $finish;
                done <= 0;
             end
             1:begin 
                ena  <= 1;
                done <= 0;
             end
             2:begin 
                for(integer s = 0; s < SUBIMAGENS; s++)
                    for(integer w = 0; w < SUBIMAGENS; w++)
                        convIxKernelOut[i+subdivisoes[s][w]][j+subdivisoes[s][w]] <= convIxKernel[s][w] >= 0  ? convIxKernel[s][w]: 0; //Relu+
                done <= ii == SIZE/(SUBIMAGENS)-SIZEKer+2 && jj == SIZE/SUBIMAGENS-SIZEKer+2;
                ena <= 0;
             end
            endcase
            current <= next;
        end
    end
    always_comb case(current)
        0:next = 1;
        1:next = 2;
        2:next = 0;
    endcase
endmodule