module tb;
parameter SIZE =28, SIZEKer = 5, WIDTH_BIT = 16;
parameter STEP_MAX_POOLING = 2;
parameter SIZEINPUT_POOLING = SIZE - SIZEKer + 1;

parameter SIZEPOOLING = 2,SIZEOUTCONV = (SIZEINPUT_POOLING - 2)/STEP_MAX_POOLING + 1;

logic clock, nreset1,nreset2,ena;
logic done0;
logic done1;
logic done2;
logic done3;
logic done4;
logic done5;
logic done6;
logic done7;

logic done0m;
logic done1m;
logic done2m;
logic done3m;
logic done4m;
logic done5m;
logic done6m;
logic done7m;
real timestart, timestop;

logic signed  [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0]                                      ;
logic signed  [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0]                                ;
logic signed  [WIDTH_BIT-1:0] convIxKernel                                                                  ;



logic signed  [WIDTH_BIT-1:0] i, j, next,current;

logic  signed  [WIDTH_BIT-1:0] Kernel0 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel1 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel2 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel3 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel4 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel5 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel6 [SIZEKer-1:0][SIZEKer-1:0];
logic  signed  [WIDTH_BIT-1:0] Kernel7 [SIZEKer-1:0][SIZEKer-1:0];

logic signed  [WIDTH_BIT-1:0] convIxKernelOut0[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut1[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut2[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut3[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut4[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut5[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut6[SIZE-SIZEKer:0][SIZE-SIZEKer:0];
logic signed  [WIDTH_BIT-1:0] convIxKernelOut7[SIZE-SIZEKer:0][SIZE-SIZEKer:0];


logic signed  [WIDTH_BIT-1:0] maxPoolingOut0       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut1       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut2       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut3       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut4       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut5       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut6       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut7       [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0 ]   ;


logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel0  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel1  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel2  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel3  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel4  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel5  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel6  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel7  [SIZEOUTCONV-1:0][SIZEOUTCONV-1:0           ];



conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv0 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel0                        )                               ,
    .done                   (done0                          )                               ,
    .convIxKernelOut        (convIxKernelOut0               )
);

conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv1 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel1                        )                               ,
    .done                   (done1                          )                               ,
    .convIxKernelOut        (convIxKernelOut1               )
);

conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv2 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel2                        )                               ,
    .done                   (done2                          )                               ,
    .convIxKernelOut        (convIxKernelOut2               )
);

conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv3 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel3                        )                               ,
    .done                   (done3                          )                               ,
    .convIxKernelOut        (convIxKernelOut3               )
);

conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv4 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel4                        )                               ,
    .done                   (done4                          )                               ,
    .convIxKernelOut        (convIxKernelOut4                )
);

conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv5 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel5                        )                               ,
    .done                   (done5                          )                               ,
    .convIxKernelOut        (convIxKernelOut5                )
);

conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv6 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel6                        )                               ,
    .done                   (done6                          )                               ,
    .convIxKernelOut        (convIxKernelOut6                )
);


conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) conv7 (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset1                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .Kernel                 (Kernel7                        )                               ,
    .done                   (done7                          )                               ,
    .convIxKernelOut        (convIxKernelOut7                )
);

maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling0 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut0    )                               ,
    .done                               (done0m             )                               ,
    .maxPoolingOut                      (maxPoolingOut0      )
);

maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling1 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut1    )                               ,
    .done                               (done1m             )                               ,
    .maxPoolingOut                      (maxPoolingOut1      )
);

maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling2 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut2    )                               ,
    .done                               (done2m             )                               ,
    .maxPoolingOut                      (maxPoolingOut2      )
);
maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling3 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut3    )                               ,
    .done                               (done3m             )                               ,
    .maxPoolingOut                      (maxPoolingOut3      )
);
maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling4 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut4    )                               ,
    .done                               (done4m             )                               ,
    .maxPoolingOut                      (maxPoolingOut4      )
);
maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling5 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut5    )                               ,
    .done                               (done5m             )                               ,
    .maxPoolingOut                      (maxPoolingOut5      )
);
maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling6 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut6    )                               ,
    .done                               (done6m             )                               ,
    .maxPoolingOut                      (maxPoolingOut6      )
);
maxpooling #(.SIZE(SIZE-SIZEKer),.STEP_MAX_POOLING(STEP_MAX_POOLING),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling7 (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut7    )                               ,
    .done                               (done7m             )                               ,
    .maxPoolingOut                      (maxPoolingOut7      )
);


initial begin
    $readmemh("simulation/I.txt",inpMatrixI);
    $readmemh("simulation/Kernel0.txt",inpMatrixIdinKer);
    $readmemh("simulation/Kernel1.txt",Kernel0);
    $readmemh("simulation/Kernel2.txt",Kernel1);
    $readmemh("simulation/Kernel2.txt",Kernel2);
    $readmemh("simulation/Kernel3.txt",Kernel3);
    $readmemh("simulation/Kernel4.txt",Kernel4);
    $readmemh("simulation/Kernel5.txt",Kernel5);
    $readmemh("simulation/Kernel6.txt",Kernel6);
    $readmemh("simulation/Kernel7.txt",Kernel7);

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
    end while(!done0);
    timestop= $realtime()-timestart;
    $writememh("simulation/IxKernel.txt",convIxKernelOut0);
    clock =0;
    // #1 nreset2 = 0;
    #1 nreset2 = 1;

    do begin 
        #1 clock = ~clock;
    end while(!done0m);
    $display("Kernel>> \n");
    for(integer i = 0; i < SIZEKer; i++)begin
        for(integer j = 0; j < SIZEKer; j++)begin
            $write(inpMatrixIdinKer[i][j]);
        end
        $display("\n");
    end
    $display("Matriz de Convoluída>> \n");
    $writememh("simulation/IxKernel.txt",convIxKernelOut0);
    for(integer i = 0; i < SIZE-SIZEKer+1; i++)begin
        for(integer j = 0; j < SIZE-SIZEKer+1; j++)begin
            $write(convIxKernelOut0[i][j]);
        end
        $display("\n");
    end
    $display("Matriz Maxpooling0>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut0[i][j]);
        end
        $display("\n");
    end
    $display("Matriz Maxpooling1>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut1[i][j]);
        end
        $display("\n");
    end
    $display("Matriz Maxpooling2>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut2[i][j]);
        end
        $display("\n");
    end
        $display("Matriz Maxpooling3>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut3[i][j]);
        end
        $display("\n");
    end
        $display("Matriz Maxpooling4>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut4[i][j]);
        end
        $display("\n");
    end
        $display("Matriz Maxpooling5>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut4[i][j]);
        end
        $display("\n");
    end
            $display("Matriz Maxpooling5>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut4[i][j]);
        end
        $display("\n");
    end
            $display("Matriz Maxpooling6>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut4[i][j]);
        end
        $display("\n");
    end
            $display("Matriz Maxpooling7>> \n");
    for(integer i = 0; i < SIZEOUTCONV; i++)begin
        for(integer j = 0; j < SIZEOUTCONV ; j++)begin
            $write(maxPoolingOut4[i][j]);
        end
        $display("\n");
    end
    $writememh("simulation/maxIxKernelPooling0.txt",maxPoolingOut0);
    $writememh("simulation/maxIxKernelPooling1.txt",maxPoolingOut1);
    $writememh("simulation/maxIxKernelPooling2.txt",maxPoolingOut2);
    $writememh("simulation/maxIxKernelPooling3.txt",maxPoolingOut3);
    $writememh("simulation/maxIxKernelPooling4.txt",maxPoolingOut4);
    $writememh("simulation/maxIxKernelPooling5.txt",maxPoolingOut5);
    $writememh("simulation/maxIxKernelPooling6.txt",maxPoolingOut6);
    $writememh("simulation/maxIxKernelPooling7.txt",maxPoolingOut7);

    $display("Tempo de exerc %.2fns OK... ",timestop);


end
endmodule
