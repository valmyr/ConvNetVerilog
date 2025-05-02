module tb;
parameter SIZE =28, SIZEKer = 5, WIDTH_BIT = 16;
parameter SIZEPOOLING = 2,SIZEOUTCONV = SIZE - SIZEKer - SIZEPOOLING;

logic clock, nreset1,nreset2,ena,done1, done2;
real timestart, timestop;

logic signed  [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0]                                      ;
logic signed  [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0]                                ;
logic signed  [WIDTH_BIT-1:0] convIxKernel                                                                  ;
logic signed  [WIDTH_BIT-1:0] convIxKernelOut     [SIZE-SIZEKer:0][SIZE-SIZEKer:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingOut       [SIZEOUTCONV:0][SIZEOUTCONV:0 ]   ;
logic signed  [WIDTH_BIT-1:0] maxPoolingIxKernel  [SIZEOUTCONV-1:0]          [SIZEOUTCONV-1:0           ]   ;

logic signed  [WIDTH_BIT-1:0] i, j, next,current;


maxpooling #(.SIZE(SIZE-SIZEKer),.SIZEOUTCONV(SIZEOUTCONV),.SIZEPOOLING(SIZEPOOLING),.WIDTH_BIT(WIDTH_BIT)) maxPooling (
    .clock                              (clock              )                               ,
    .nreset                             (nreset1            )                               ,
    .convIxKernelOut                    (convIxKernelOut    )                               ,
    .done                               (done1              )                               ,
    .maxPoolingOut                      (maxPoolingOut      )
);


conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT)) top_conv (
    .clock                  (clock                          )                               ,
    .nreset                 (nreset2                        )                               ,
    .inpMatrixI             (inpMatrixI                     )                               ,
    .done                   (done2                          )                               ,
    .convIxKernelOut        (convIxKernelOut                )
);

initial begin
    $readmemh("simulation/I.txt",inpMatrixI);
    $readmemh("simulation/Kernel0.txt",inpMatrixIdinKer);
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
    #1 nreset2 = 1;
    timestart = $realtime();
    do begin 
        #1 clock = ~clock;
    end while(!done2);
    timestop= $realtime()-timestart;
    $writememh("simulation/IxKernel.txt",convIxKernelOut);
    clock =0;
    // #1 nreset2 = 0;
    #1 nreset1 = 1;

    do begin 
        #1 clock = ~clock;
    end while(!done1);
    $display("Kernel>> \n");
    for(integer i = 0; i < SIZEKer; i++)begin
        for(integer j = 0; j < SIZEKer; j++)begin
            $write(inpMatrixIdinKer[i][j]);
        end
        $display("\n");
    end
    $display("Matriz de Convoluída>> \n");
    $writememh("simulation/IxKernel.txt",convIxKernelOut);
    for(integer i = 0; i < SIZE-SIZEKer+1; i++)begin
        for(integer j = 0; j < SIZE-SIZEKer+1; j++)begin
            $write(convIxKernelOut[i][j]);
        end
        $display("\n");
    end
    $display("Matriz Maxpooling>> \n");
    for(integer i = 0; i < SIZEOUTCONV - SIZEPOOLING + 1; i++)begin
        for(integer j = 0; j < SIZEOUTCONV - SIZEPOOLING + 1; j++)begin
            $write(maxPoolingOut[i][j]);
        end
        $display("\n");
    end
    $writememh("simulation/maxIxKernelPooling.txt",maxPoolingOut);
    $display("Tempo de exerc %.2fns OK... ",timestop);


end
endmodule
