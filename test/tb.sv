module tb;
parameter SIZE =28, SIZEKer = 5, WIDTH_BIT = 16;
parameter STEP_MAX_POOLING = 2;
parameter SIZEINPUT_POOLING = SIZE - SIZEKer + 1;

parameter SIZEPOOLING = 2,SIZEOUTCONV = (SIZEINPUT_POOLING - 2)/STEP_MAX_POOLING + 1;
parameter FILTER_N1D = 8;
parameter FILTER_N2D = 16;

logic clock, nreset1,nreset2,ena;
logic done0[FILTER_N1D-1:0];
logic done0m[FILTER_N1D-1:0];

real timestart, timestop;

logic signed  [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0]                                      ;
logic signed  [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0]                                ;
logic signed  [WIDTH_BIT-1:0] convIxKernel                                                                  ;



logic signed  [WIDTH_BIT-1:0] i, j, next,current;

logic  signed  [WIDTH_BIT-1:0] Kernel0     [FILTER_N1D-1:0][SIZEKer-1:0][SIZEKer-1:0];

logic  signed  [WIDTH_BIT-1:0] Kernel00 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel01 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel02 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel03 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel04 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel05 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel06 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel07 [SIZEKer-1:0][SIZEKer-1:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut0     [FILTER_N1D-1:0][SIZE-SIZEKer:0][SIZE-SIZEKer:0]     ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut0       [FILTER_N1D-1:0][SIZEOUTCONV-1:0][SIZEOUTCONV-1:0]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel0  [FILTER_N1D-1:0][SIZEOUTCONV-1:0][SIZEOUTCONV-1:0    ];

generate
    genvar iii;
    for(iii = 0; iii < FILTER_N1D; iii++)begin:INST_CONVS1D
        conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv0 (
            .clock                  (clock                          )                               ,
            .nreset                 (nreset1                        )                               ,
            .inpMatrixI             (inpMatrixI                     )                               ,
            .Kernel                 (Kernel0[iii]                     )                               ,
            .done                   (done0[iii]                       )                               ,
            .convIxKernelOut        (convIxKernelOut0[iii]            )
        );
    end

        for(iii = 0; iii < FILTER_N1D; iii++)begin:INST_MAXPOOLING1D
        maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling7 (
            .clock                              (clock                  )                               ,
            .nreset                             (nreset1                )                               ,
            .convIxKernelOut                    (convIxKernelOut0[iii]     )                               ,
            .done                               (done0m[iii]              )                               ,
            .maxPoolingOut                      (maxPoolingOut0[iii]      )
        );
    end
    endgenerate

parameter SIZE2 =12, SIZEKer2 = 5;
parameter STEP_MAX_POOLING2 = 2;
parameter SIZEINPUT_POOLING2 = SIZE2 - SIZEKer2 + 1;
parameter SIZEPOOLING2 = 2,SIZEOUTCONV2 = (SIZEINPUT_POOLING2 - 2)/STEP_MAX_POOLING2 + 1;

logic done00[FILTER_N2D-1:0];
logic done00m[FILTER_N2D-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel_1_0 [FILTER_N2D-1:0][SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_00 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_01 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_02 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_03 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_04 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_05 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_06 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_07 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_08 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_09 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_10 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_11 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_12 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_13 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_14 [SIZEKer2-1:0][SIZEKer2-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernels2d_15 [SIZEKer2-1:0][SIZEKer2-1:0];

logic signed  [WIDTH_BIT-1:0] convIxKernelOut_1_0     [FILTER_N2D-1:0][SIZE2-SIZEKer2:0][SIZE2-SIZEKer2:0]     ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut_1_0       [FILTER_N2D-1:0][SIZEOUTCONV2-1:0][SIZEOUTCONV2-1:0]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel_1_0  [FILTER_N2D-1:0][SIZEOUTCONV2-1:0][SIZEOUTCONV2-1:0    ];


generate
    genvar jj;
    for(jj = 0; jj < FILTER_N2D; jj++)begin:INST_CONVS2D
        conv2 #(.SIZE(SIZE2),.SIZEKer(SIZEKer2),.WIDTH_BIT(WIDTH_BIT)) conv00 (
            .clock                  (clock                          )                               ,
            .nreset                 (nreset1                        )                               ,
            .inpMatrixI             (maxPoolingOut0[0]                    )                               ,
            .Kernel                 (Kernel_1_0[jj]                     )                               ,
            .done                   (done00[jj]                       )                               ,
            .convIxKernelOut        (convIxKernelOut_1_0[jj]            )
        );
    end

        for(jj = 0; jj < FILTER_N2D; jj++)begin:INST_MAXPOOLING2D
        maxpooling #(.SIZE(SIZE2-SIZEKer2),.STEP_MAX_POOLING(STEP_MAX_POOLING2),.SIZEOUTCONV(SIZEOUTCONV2),.SIZEPOOLING(SIZEPOOLING2),.WIDTH_BIT(WIDTH_BIT)) maxPooling0 (
            .clock                              (clock                  )                               ,
            .nreset                             (nreset1                )                               ,
            .convIxKernelOut                    (convIxKernelOut_1_0[jj]     )                               ,
            .done                               (done00m[jj]              )                               ,
            .maxPoolingOut                      (maxPoolingOut_1_0[jj]      )
        );
    end
endgenerate
assign Kernel0[0] = Kernel00;
assign Kernel0[1] = Kernel01;
assign Kernel0[2] = Kernel02;
assign Kernel0[3] = Kernel03;
assign Kernel0[4] = Kernel04;
assign Kernel0[5] = Kernel05;
assign Kernel0[6] = Kernel06;
assign Kernel0[7] = Kernel07;

assign Kernel_1_0[0]  = Kernels2d_00;
assign Kernel_1_0[1]  = Kernels2d_01;
assign Kernel_1_0[2]  = Kernels2d_02;
assign Kernel_1_0[3]  = Kernels2d_03;
assign Kernel_1_0[4]  = Kernels2d_04;
assign Kernel_1_0[5]  = Kernels2d_05;
assign Kernel_1_0[6]  = Kernels2d_06;
assign Kernel_1_0[7]  = Kernels2d_07;
assign Kernel_1_0[8]  = Kernels2d_08;
assign Kernel_1_0[9]  = Kernels2d_09;
assign Kernel_1_0[10] = Kernels2d_10;
assign Kernel_1_0[11] = Kernels2d_11;
assign Kernel_1_0[12] = Kernels2d_12;
assign Kernel_1_0[13] = Kernels2d_13;
assign Kernel_1_0[14] = Kernels2d_14;
assign Kernel_1_0[15] = Kernels2d_15;

initial begin
    $readmemh("simulation/I.txt",inpMatrixI);
    // $readmemh("simulation/Kernel0.txt",inpMatrixIdinKer);
    $readmemh("simulation/Kernel0.txt",Kernel00);
    $readmemh("simulation/Kernel1.txt",Kernel01);
    $readmemh("simulation/Kernel2.txt",Kernel02);
    $readmemh("simulation/Kernel3.txt",Kernel03);
    $readmemh("simulation/Kernel4.txt",Kernel04);
    $readmemh("simulation/Kernel5.txt",Kernel05);
    $readmemh("simulation/Kernel6.txt",Kernel06);
    $readmemh("simulation/Kernel7.txt",Kernel07);

    $readmemh("simulation/Kernels2d_1_0.txt",Kernels2d_00);
    $readmemh("simulation/Kernels2d_1_1.txt",Kernels2d_01);
    $readmemh("simulation/Kernels2d_1_2.txt",Kernels2d_02);
    $readmemh("simulation/Kernels2d_1_3.txt",Kernels2d_03);
    $readmemh("simulation/Kernels2d_1_4.txt",Kernels2d_04);
    $readmemh("simulation/Kernels2d_1_5.txt",Kernels2d_05);
    $readmemh("simulation/Kernels2d_1_6.txt",Kernels2d_06);
    $readmemh("simulation/Kernels2d_1_7.txt",Kernels2d_07);
    $readmemh("simulation/Kernels2d_1_8.txt",Kernels2d_08);
    $readmemh("simulation/Kernels2d_1_9.txt",Kernels2d_09);
    $readmemh("simulation/Kernels2d_1_10.txt",Kernels2d_10);
    $readmemh("simulation/Kernels2d_1_11.txt",Kernels2d_11);
    $readmemh("simulation/Kernels2d_1_12.txt",Kernels2d_12);
    $readmemh("simulation/Kernels2d_1_13.txt",Kernels2d_13);
    $readmemh("simulation/Kernels2d_1_14.txt",Kernels2d_14);
    $readmemh("simulation/Kernels2d_1_15.txt",Kernels2d_15);
    
    $display("Matriz de Entrada>> \n");
    for(integer i = 0; i < SIZE; i++)begin
        for(integer j = 0; j < SIZE; j++)begin
            $write(inpMatrixI[i][j]);
        end
        $display("\n");
    end
    
    // $display("\n");
    // $display("\n");
    clock =0;
    nreset1 = 0;
    nreset2 = 0;
    #1 nreset1 = 1;
    timestart = $realtime();
    do begin 
        #1 clock = ~clock;
    end while(!done0[0]);
    timestop= $realtime()-timestart;
    $writememh("simulation/IxKernel.txt",convIxKernelOut0[0]);
    clock =0;
    // #1 nreset2 = 0;
    #1 nreset2 = 1;

    do begin 
        #1 clock = ~clock;
    end while(!done0m[0]);
    $display("Kernel>> \n");
    for(integer i = 0; i < SIZEKer; i++)begin
        for(integer j = 0; j < SIZEKer; j++)begin
            $write(inpMatrixIdinKer[i][j]);
        end
        $display("\n");
    end
    $display("Matriz de Convoluída>> \n");
    $writememh("simulation/IxKernel.txt",convIxKernelOut0[0]);
    for(integer i = 0; i < SIZE-SIZEKer+1; i++)begin
        for(integer j = 0; j < SIZE-SIZEKer+1; j++)begin
            $write(convIxKernelOut0[0][i][j]);
        end
        $display("\n");
    end
    $display("Matriz Maxpooling0>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut0[0][i][j]);
        end
        $display("\n");
    end


    $writememh("simulation/maxIxKernelPooling0.txt",maxPoolingOut0[0]);
    $writememh("simulation/maxIxKernelPooling1.txt",maxPoolingOut0[1]);
    $writememh("simulation/maxIxKernelPooling2.txt",maxPoolingOut0[2]);
    $writememh("simulation/maxIxKernelPooling3.txt",maxPoolingOut0[3]);
    $writememh("simulation/maxIxKernelPooling4.txt",maxPoolingOut0[4]);
    $writememh("simulation/maxIxKernelPooling5.txt",maxPoolingOut0[5]);
    $writememh("simulation/maxIxKernelPooling6.txt",maxPoolingOut0[6]);
    $writememh("simulation/maxIxKernelPooling7.txt",maxPoolingOut0[7]);

    $display("Tempo de exerc %.2fns OK... ",timestop);


end
endmodule
