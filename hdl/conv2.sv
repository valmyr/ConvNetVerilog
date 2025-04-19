module conv2#(parameter SIZE =7, SIZEKer = 3, WIDTH_BIT = 8)(
    input logic                     clock                                                   ,
    input logic                     nreset                                                  ,
    input logic [WIDTH_BIT-1:0]     inpMatrixI          [SIZE-1:0][SIZE-1:0]                ,
    output logic                    done                                                    ,
    output logic [WIDTH_BIT-1:0]    convIxKernelOut [(SIZE-SIZEKer):0][(SIZE-SIZEKer):0]
);

logic ena;
logic [WIDTH_BIT-1:0] inpMatrixIdinKer    [SIZEKer-1:0][SIZEKer-1:0];
logic [WIDTH_BIT-1:0] convIxKernel ;
logic [WIDTH_BIT-1:0] i, j, next,current;
logic signed [WIDTH_BIT-1:0] k ;

    conv #(.SIZE(SIZEKer),.WIDTH_BIT(WIDTH_BIT))CNN1(
        .clock(clock)                          ,
        .nreset(nreset)                        ,
        .inpMatrixI(inpMatrixIdinKer)          ,
        .convIxKernel(convIxKernel)            ,
        .ena(ena)
    );
    indexMatrix #(.SIZE(SIZE-SIZEKer+1),.WIDTH_BIT(WIDTH_BIT))sliced(
        .nreset(nreset),
        .clock(clock),
        .i(i),
        .ena(ena),
        .j(j)
    );
    always_ff@(posedge clock,negedge nreset)begin
        if(!nreset)begin
            inpMatrixIdinKer[0][0] <= inpMatrixI[0+i][0+j];
            inpMatrixIdinKer[0][1] <= inpMatrixI[0+i][1+j];
            inpMatrixIdinKer[0][2] <= inpMatrixI[0+i][2+j];
            inpMatrixIdinKer[1][0] <= inpMatrixI[1+i][0+j];
            inpMatrixIdinKer[1][1] <= inpMatrixI[1+i][1+j];
            inpMatrixIdinKer[1][2] <= inpMatrixI[1+i][2+j];
            inpMatrixIdinKer[2][0] <= inpMatrixI[2+i][0+j];
            inpMatrixIdinKer[2][1] <= inpMatrixI[2+i][1+j];
            inpMatrixIdinKer[2][2] <= inpMatrixI[2+i][2+j];
            ena= 0;
            current<= 0;
        end else begin
            // $display("%d,%d,%d",convIxKernel,i,j);
            case(current)
             0:begin
                ena <=0;
                inpMatrixIdinKer[0][0] <= inpMatrixI[0+i][0+j];
                inpMatrixIdinKer[0][1] <= inpMatrixI[0+i][1+j];
                inpMatrixIdinKer[0][2] <= inpMatrixI[0+i][2+j];
                inpMatrixIdinKer[1][0] <= inpMatrixI[1+i][0+j];
                inpMatrixIdinKer[1][1] <= inpMatrixI[1+i][1+j];
                inpMatrixIdinKer[1][2] <= inpMatrixI[1+i][2+j];
                inpMatrixIdinKer[2][0] <= inpMatrixI[2+i][0+j];
                inpMatrixIdinKer[2][1] <= inpMatrixI[2+i][1+j];
                inpMatrixIdinKer[2][2] <= inpMatrixI[2+i][2+j];
             end
             1:begin 
                ena <= 1;
               
             end
             2:begin convIxKernelOut[i][j] <= convIxKernel;
                $display(convIxKernel);
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
