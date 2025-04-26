module conv2#(parameter SIZE =7, SIZEKer = 3, WIDTH_BIT = 8)(
    input  logic                      clock                                                         ,
    input logic                     nreset                                                          ,
    input logic  signed  [WIDTH_BIT-1:0]     inpMatrixI          [SIZE-1:0][SIZE-1:0]               ,
    output logic                    done                                                            ,
    output logic  signed  [WIDTH_BIT-1:0]    convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0]
);

logic ena;
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer0    [SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer1    [SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer2    [SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer3    [SIZEKer-1:0][SIZEKer-1:0];

logic  signed [WIDTH_BIT-1:0] convIxKernel0 ;
logic  signed [WIDTH_BIT-1:0] convIxKernel1 ;
logic  signed [WIDTH_BIT-1:0] convIxKernel2 ;
logic  signed [WIDTH_BIT-1:0] convIxKernel3 ;

logic [WIDTH_BIT-1:0] i, ii, iii, j, jj, jjj, next,current;


    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN1(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer0)          ,
        .convIxKernel(convIxKernel0)            
    );
    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN2(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer1)          ,
        .convIxKernel(convIxKernel1)            
    );    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN3(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer2)          ,
        .convIxKernel(convIxKernel2)            
    );    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN4(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer3)          ,
        .convIxKernel(convIxKernel3)            
    );
    indexMatrix #(.SIZELin(SIZE/2-SIZEKer+3),.SIZECol(SIZE/2-SIZEKer+3),.WIDTH_BIT(WIDTH_BIT))slicedIndexVertic(
        .nreset(nreset),
        .clock(clock),
        .i(i),
        .ena(ena),
        .j(j)
    );
    indexMatrix #(.SIZELin(SIZE/2-SIZEKer+3),.SIZECol(SIZE/2-SIZEKer+3),.WIDTH_BIT(WIDTH_BIT))slicedIndexHorizon(
        .nreset(nreset),
        .clock(clock),
        .i(ii),
        .ena(ena),
        .j(jj)
    );
    indexMatrix #(.SIZELin(SIZE-SIZEKer+1),.SIZECol(SIZE-SIZEKer+1),.WIDTH_BIT(WIDTH_BIT))slicedIndexOut(
        .nreset(nreset),
        .clock(clock),
        .i(iii),
        .ena(ena),
        .j(jjj)
    );
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin
            for(integer k=0; k < SIZEKer; k++)
                for(integer l = 0; l < SIZEKer; l++)begin
                    inpMatrixIdinKer0[k][l] <= 0;
                    inpMatrixIdinKer1[k][l] <= 0;
                    inpMatrixIdinKer2[k][l] <= 0;
                    inpMatrixIdinKer3[k][l] <= 0;
                end

            ena= 0;
            current<= 0;
            done<= 0;
        end else begin
            case(current)
             0:begin
                ena <=0;
                for(integer k=0; k < SIZEKer; k++)
                    for(integer l = 0; l < SIZEKer; l++)begin
                        inpMatrixIdinKer0[k][l] <= inpMatrixI[k+i+0     ][l+j+0     ];
                        inpMatrixIdinKer1[k][l] <= inpMatrixI[k+i+     0][l+j+SIZE/2];
                        inpMatrixIdinKer2[k][l] <= inpMatrixI[k+ii+SIZE/2][l+jj+0     ];
                        inpMatrixIdinKer3[k][l] <= inpMatrixI[k+ii+SIZE/2][l+jj+SIZE/2];
                    end

                done<= 0;
             end
             1:begin 
                ena <= 1;
                done<= 0;
             end
             2:begin 
                convIxKernelOut[i     + 0][j     +0 ] <= convIxKernel0 >= 0  ? convIxKernel0: 0; //Relu+
                convIxKernelOut[i      +0][j+SIZE/2 ] <= convIxKernel1 >= 0  ? convIxKernel1: 0; //Relu+
                convIxKernelOut[ii+SIZE/2][jj+     0] <= convIxKernel2 >= 0  ? convIxKernel2: 0; //Relu+
                convIxKernelOut[ii+SIZE/2][jj+SIZE/2] <= convIxKernel3 >= 0  ? convIxKernel3: 0; //Relu+
                done <= iii == SIZE/2-SIZEKer+2 && jjj == SIZE/2-SIZEKer;
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