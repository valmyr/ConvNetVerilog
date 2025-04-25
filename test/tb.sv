module tb;
parameter SIZE =640, SIZEKer = 3, WIDTH_BIT = 16;
logic clock, nreset,ena,done;
logic signed [WIDTH_BIT-1:0] inpMatrixI          [SIZE-1:0][SIZE-1:0];
logic signed [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0];

logic signed  [WIDTH_BIT-1:0] convIxKernel;
real timestart, timestop;
logic signed  [WIDTH_BIT-1:0] convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0] ;
logic signed  [WIDTH_BIT-1:0] i, j, next,current;
conv2 #(.SIZE(SIZE),.SIZEKer(SIZEKer),.WIDTH_BIT(WIDTH_BIT))top_conv (
    .clock(clock)       ,
    .nreset(nreset)     ,
    .inpMatrixI(inpMatrixI),
    .done(done),
    .convIxKernelOut(convIxKernelOut)
);
initial begin
    $readmemh("simulation/I.txt",inpMatrixI);
    $readmemh("simulation/Kernel.txt",inpMatrixIdinKer);

        // $writememh("simulation/IxKernel.txt",convIxKernelOut);
    for(integer i = 0; i < SIZE; i++)begin
        for(integer j = 0; j < SIZE; j++)begin
            $write(inpMatrixI[i][j]);
        end
        $display("\n");
    end
    
    // $display("\n");
    // $display("\n");
    clock =0;
    #1nreset = 0;
    #1 nreset = 1;
    timestart = $realtime();
    do begin 
        #1 clock = ~clock;
    end while(!done);
    timestop= $realtime()-timestart;
    for(integer i = 0; i < SIZEKer; i++)begin
        for(integer j = 0; j < SIZEKer; j++)begin
            $write(inpMatrixIdinKer[i][j]);
        end
        $display("\n");
    end
    $writememh("simulation/IxKernel.txt",convIxKernelOut);
    for(integer i = 0; i < SIZE-SIZEKer+1; i++)begin
        for(integer j = 0; j < SIZE-SIZEKer+1; j++)begin
            $write(convIxKernelOut[i][j]);
        end
        $display("\n");
    end
    
    $display("Tempo de exerc %0t ",timestop);

end
endmodule
