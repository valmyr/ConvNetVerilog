module conv2D#(parameter SIZE =7, SIZEKer = 3, WIDTH_BIT = 8)(
    input  logic                             clock                                                          ,
    input logic                              nreset                                                         ,
    input logic  signed  [WIDTH_BIT-1:0]     inpMatrixI1          [SIZE-1:0][SIZE-1:0]                      ,
    input logic  signed  [WIDTH_BIT-1:0]     inpMatrixI2          [SIZE-1:0][SIZE-1:0]                      ,
    output logic                             done                                                           ,
    output logic  signed  [WIDTH_BIT-1:0]    convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0]           ,
    input   logic  signed  [WIDTH_BIT-1:0]   Kernel1 [SIZEKer-1:0][SIZEKer-1:0]                             ,
    input   logic  signed  [WIDTH_BIT-1:0]   Kernel2 [SIZEKer-1:0][SIZEKer-1:0]                             ,
    input logic signed    [WIDTH_BIT-1:0]    bias 
);

logic ena;
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer1    [SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] inpMatrixIdinKer2    [SIZEKer-1:0][SIZEKer-1:0];
logic  signed [WIDTH_BIT-1:0] convIxKernel1 ;
logic  signed [WIDTH_BIT-1:0] convIxKernel2 ;
logic [WIDTH_BIT-1:0] i, j, next,current;


    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN1(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer1)          ,
        .convIxKernel(convIxKernel1)            ,
        .Kernel                 (Kernel1 )
        
    );

    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN2(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer2)          ,
        .convIxKernel(convIxKernel2)            ,
        .Kernel                 (Kernel2)
        
    );
    indexMatrix #(.SIZELin(SIZE-SIZEKer+1),.SIZECol(SIZE-SIZEKer+1),.WIDTH_BIT(WIDTH_BIT))slicedIndex(
        .nreset(nreset),
        .clock(clock),
        .i(i),
        .ena(ena),
        .j(j)
    );
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin
            for(integer k=0; k < SIZEKer; k++)
                for(integer l = 0; l < SIZEKer; l++)begin
                    inpMatrixIdinKer1[k][l] <= 0;
                    inpMatrixIdinKer2[k][l] <= 0;
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
                        inpMatrixIdinKer1[k][l] <= inpMatrixI1[k+i][l+j];
                        inpMatrixIdinKer2[k][l] <= inpMatrixI2[k+i][l+j];
                    end

                done<= 0;
             end
             1:begin 
                ena <= 1;
                done<= 0;
             end
             2:begin 
                convIxKernelOut[i][j] <= convIxKernel1+convIxKernel2+bias >= 0  ? convIxKernel1+convIxKernel2+bias: 0; //Relu+
                done <= i == SIZE-SIZEKer && j == SIZE-SIZEKer;
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