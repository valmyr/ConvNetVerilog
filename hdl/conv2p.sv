// `define WINDOWING = SIZE/$sqrt(3)
module conv2#(parameter SIZE =320, SIZEKer = 3, WIDTH_BIT = 16, TOTSUBIMAGEM = 16)//sqrt(n**2)
(
    input   logic                               clock                                                           ,
    input   logic                               nreset                                                          ,
    input   logic  signed  [WIDTH_BIT-1:0]      inpMatrixI          [SIZE-1:0][SIZE-1:0]                        ,        
    output  logic                               done                                                            ,
    output  logic  signed  [WIDTH_BIT-1:0]      convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0]
);
logic ena;
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer[TOTSUBIMAGEM-1:0][TOTSUBIMAGEM-1:0][SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] convIxKernel[TOTSUBIMAGEM-1:0][TOTSUBIMAGEM-1:0];
logic         [WIDTH_BIT-1:0] subdivisoes[TOTSUBIMAGEM-1:0];
logic [WIDTH_BIT-1:0] i, ii, j, jj, next,current;
generate
    for(genvar s = 0; s < TOTSUBIMAGEM; s++)begin:CONVMOD2
        for(genvar w = 0; w < TOTSUBIMAGEM; w++)begin:CONVMOD2_
            conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNV(
                .clock                              (                 clock             ),
                .nreset                             (       nreset                      ),
                .inpMatrixI                         (       inpMatrixIdinKer[s][w]       ),
                .convIxKernel                       (       convIxKernel[s][w]           )            
            );
        end
    end
endgenerate
    indexMatrix #(.SIZELin(SIZE/TOTSUBIMAGEM-SIZEKer+2+1),.SIZECol(SIZE/TOTSUBIMAGEM-SIZEKer+2+1),.WIDTH_BIT(WIDTH_BIT))slicedIndexVertic
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
        static integer f = 0;
            for(integer w = 0; w < TOTSUBIMAGEM; w++)begin
                subdivisoes[w] = f;
                f+=SIZE/(TOTSUBIMAGEM);
            end

    end
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin
            for(integer k=0; k < SIZEKer; k++)
                for(integer l = 0; l < SIZEKer; l++)
                    for(integer s = 0; s < TOTSUBIMAGEM; s++)
                        for(integer w = 0; w < TOTSUBIMAGEM; w++)
                            inpMatrixIdinKer[s][w][k][l] <= 0;
            ena     <= 0;
            current <= 0;
            done    <= 0;
        end else begin
            case(current)
             0:begin
                ena <= 0;
                        for(integer k = 0; k < SIZEKer; k++)begin
                            for(integer l = 0; l < SIZEKer; l++)begin
                                for(integer h = 0; h < TOTSUBIMAGEM; h++)
                                    for(integer d = 0; d < TOTSUBIMAGEM; d++)
                                         inpMatrixIdinKer[h][d][k][l] <= inpMatrixI[k+i+subdivisoes[h]][l+j+subdivisoes[d]];
                                // inpMatrixIdinKer[0][1][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[1]];
                                // inpMatrixIdinKer[0][2][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[2]];
                                // inpMatrixIdinKer[0][3][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[3]];

                                // inpMatrixIdinKer[1][0][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[0]];
                                // inpMatrixIdinKer[1][1][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[1]];
                                // inpMatrixIdinKer[1][2][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[2]];
                                // inpMatrixIdinKer[1][3][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[3]];

                                // inpMatrixIdinKer[2][0][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[0]];
                                // inpMatrixIdinKer[2][1][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[1]];
                                // inpMatrixIdinKer[2][2][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[2]];
                                // inpMatrixIdinKer[2][3][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[3]];

                                // inpMatrixIdinKer[3][0][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[0]];
                                // inpMatrixIdinKer[3][1][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[1]];
                                // inpMatrixIdinKer[3][2][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[2]];
                                // inpMatrixIdinKer[3][3][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[3]];



                            end
                        end
                done <= 0;
             end
             1:begin 
                ena  <= 1;
                done <= 0;
             end
             2:begin 
                for(integer h = 0; h < TOTSUBIMAGEM; h++)
                    for(integer d = 0; d < TOTSUBIMAGEM; d++)
                        convIxKernelOut[i+subdivisoes[h]][j+subdivisoes[d]] <= convIxKernel[h][d] >= 0  ? convIxKernel[h][d]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[0]][j+subdivisoes[1]] <= convIxKernel[0][1] >= 0  ? convIxKernel[0][1]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[0]][j+subdivisoes[2]] <= convIxKernel[0][2] >= 0  ? convIxKernel[0][2]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[0]][j+subdivisoes[3]] <= convIxKernel[0][3] >= 0  ? convIxKernel[0][3]: 0; //Relu+

                        // convIxKernelOut[i+subdivisoes[1]][j+subdivisoes[0]] <= convIxKernel[1][0] >= 0  ? convIxKernel[1][0]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[1]][j+subdivisoes[1]] <= convIxKernel[1][1] >= 0  ? convIxKernel[1][1]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[1]][j+subdivisoes[2]] <= convIxKernel[1][2] >= 0  ? convIxKernel[1][2]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[1]][j+subdivisoes[3]] <= convIxKernel[1][3] >= 0  ? convIxKernel[1][3]: 0; //Relu+

                        // convIxKernelOut[i+subdivisoes[2]][j+subdivisoes[0]] <= convIxKernel[2][0] >= 0  ? convIxKernel[2][0]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[2]][j+subdivisoes[1]] <= convIxKernel[2][1] >= 0  ? convIxKernel[2][1]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[2]][j+subdivisoes[2]] <= convIxKernel[2][2] >= 0  ? convIxKernel[2][2]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[2]][j+subdivisoes[3]] <= convIxKernel[2][3] >= 0  ? convIxKernel[2][3]: 0; //Relu+

                        // convIxKernelOut[i+subdivisoes[3]][j+subdivisoes[0]] <= convIxKernel[3][0] >= 0  ? convIxKernel[3][0]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[3]][j+subdivisoes[1]] <= convIxKernel[3][1] >= 0  ? convIxKernel[3][1]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[3]][j+subdivisoes[2]] <= convIxKernel[3][2] >= 0  ? convIxKernel[3][2]: 0; //Relu+
                        // convIxKernelOut[i+subdivisoes[3]][j+subdivisoes[3]] <= convIxKernel[3][3] >= 0  ? convIxKernel[3][3]: 0; //Relu+
                done <= i == SIZE/(TOTSUBIMAGEM)-SIZEKer && j == SIZE/TOTSUBIMAGEM -SIZEKer;
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
/*


                                inpMatrixIdinKer[0][0][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[0]];
                                inpMatrixIdinKer[0][1][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[1]];
                                inpMatrixIdinKer[0][2][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[2]];
                                inpMatrixIdinKer[0][3][k][l] <= inpMatrixI[k+i+subdivisoes[0]][l+j+subdivisoes[3]];

                                inpMatrixIdinKer[1][0][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[0]];
                                inpMatrixIdinKer[1][1][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[1]];
                                inpMatrixIdinKer[1][2][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[2]];
                                inpMatrixIdinKer[1][3][k][l] <= inpMatrixI[k+i+subdivisoes[1]][l+j+subdivisoes[3]];

                                inpMatrixIdinKer[2][0][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[0]];
                                inpMatrixIdinKer[2][1][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[1]];
                                inpMatrixIdinKer[2][2][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[2]];
                                inpMatrixIdinKer[2][3][k][l] <= inpMatrixI[k+i+subdivisoes[2]][l+j+subdivisoes[3]];

                                inpMatrixIdinKer[3][0][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[0]];
                                inpMatrixIdinKer[3][1][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[1]];
                                inpMatrixIdinKer[3][2][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[2]];
                                inpMatrixIdinKer[3][3][k][l] <= inpMatrixI[k+i+subdivisoes[3]][l+j+subdivisoes[3]];

                                */