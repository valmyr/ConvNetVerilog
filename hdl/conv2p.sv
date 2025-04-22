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

logic [WIDTH_BIT-1:0] i, j, next,current;


    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN1(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer0)          ,
        .convIxKernel(convIxKernel0)            
    );
    indexMatrix #(.SIZE(SIZE/2-SIZEKer+1),.WIDTH_BIT(WIDTH_BIT))slicedIndex(
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
                        inpMatrixIdinKer0[k][l] <= inpMatrixI[k+i+0][l+j+0];
                        inpMatrixIdinKer1[k][l] <= inpMatrixI[k+i+0][l+j+4];
                        inpMatrixIdinKer2[k][l] <= inpMatrixI[k+i+4][l+j+0];
                        inpMatrixIdinKer3[k][l] <= inpMatrixI[k+i+4][l+j+4];
                    end

                done<= 0;
             end
             1:begin 
                ena <= 1;
                done<= 0;
             end
             2:begin 
                convIxKernelOut[i+0][j+0] <= convIxKernel0 >= 0  ? convIxKernel1/3: 0; //Relu+
                convIxKernelOut[i+0][j+4] <= convIxKernel1 >= 0  ? convIxKernel2/3: 0; //Relu+
                convIxKernelOut[i+4][j+0] <= convIxKernel2 >= 0  ? convIxKernel2/3: 0; //Relu+
                convIxKernelOut[i+4][j+4] <= convIxKernel3 >= 0  ? convIxKernel3/3: 0; //Relu+
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
