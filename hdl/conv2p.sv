// `define WINDOWING = SIZE/$sqrt(3)
module conv2#(parameter SIZE =320, SIZEKer = 3, WIDTH_BIT = 16, SUBIMAGENS = 4, WINDOWING = 160)
(
    input   logic                               clock                                                           ,
    input   logic                               nreset                                                          ,
    input   logic  signed  [WIDTH_BIT-1:0]      inpMatrixI          [SIZE-1:0][SIZE-1:0]                        ,        
    output  logic                               done                                                            ,
    output  logic  signed  [WIDTH_BIT-1:0]      convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0]
);
logic ena;
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer[SUBIMAGENS-1:0][SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] convIxKernel[SUBIMAGENS-1:0];
logic [WIDTH_BIT-1:0] i, ii, j, jj, next,current;
generate
    for(genvar s = 0; s < SUBIMAGENS; s++)begin:CONVMOD2
        conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNV(
            .clock                              (                 clock             ),
            .nreset                             (       nreset                      ),
            .inpMatrixI                         (       inpMatrixIdinKer[s]         ),
            .convIxKernel                       (       convIxKernel[s]             )            
        );
    end
endgenerate
    indexMatrix #(.SIZELin(SIZE/$sqrt(SUBIMAGENS)-SIZEKer+3),.SIZECol(SIZE/$sqrt(SUBIMAGENS)-SIZEKer+3),.WIDTH_BIT(WIDTH_BIT))slicedIndexVertic
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
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin
            for(integer k=0; k < SIZEKer; k++)
                for(integer l = 0; l < SIZEKer; l++)begin
                    for(integer s = 0; s < SUBIMAGENS; s++)
                        inpMatrixIdinKer[s][k][l] <= 0;
                end
            ena     <= 0;
            current <= 0;
            done    <= 0;
        end else begin
            case(current)
             0:begin
                ena <= 0;
                for(integer k = 0; k < SIZEKer; k++)
                    for(integer l = 0; l < SIZEKer; l++)begin
                        for(integer s = 0; s < SUBIMAGENS; s++)
                            inpMatrixIdinKer[s][k][l] <= inpMatrixI[k+i+s[1]*(WINDOWING)][l+j+s[0]*(WINDOWING)];
                    end

                done <= 0;
             end
             1:begin 
                ena  <= 1;
                done <= 0;
             end
             2:begin 
                for(integer s = 0; s < SUBIMAGENS; s++)
                    convIxKernelOut[i+s[1]*(WINDOWING)][j+s[0]*(WINDOWING)] <= convIxKernel[s] >= 0  ? convIxKernel[s]: 0; //Relu+
                done <= ii == SIZE/($sqrt(SUBIMAGENS))-SIZEKer+2 && jj == SIZE/$sqrt(SUBIMAGENS)-SIZEKer;
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