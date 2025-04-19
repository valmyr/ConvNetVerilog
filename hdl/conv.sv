module conv#(parameter SIZE = 3,WIDTH_BIT = 8)(
    input   logic                 clock                               ,
    input   logic                 nreset                              ,
    input   logic ena                                                 ,
    input   logic [WIDTH_BIT-1:0] inpMatrixI    [SIZE-1:0][SIZE-1:0]  ,
    output  logic [WIDTH_BIT-1:0] convIxKernel
);
    logic [WIDTH_BIT-1:0] Kernel [SIZE-1:0][SIZE-1:0];
    initial $readmemb("simulation/Kernel.txt",Kernel);
    always_comb convIxKernel = ena ? (inpMatrixI[0][0]*Kernel[0][0]+inpMatrixI[0][1]*Kernel[0][1]+inpMatrixI[0][2]*Kernel[0][2]+
                                     inpMatrixI[1][0]*Kernel[1][0]+inpMatrixI[1][1]*Kernel[1][1]+inpMatrixI[1][2]*Kernel[1][2]+
                                     inpMatrixI[2][0]*Kernel[2][0]+inpMatrixI[2][1]*Kernel[2][1]+inpMatrixI[2][2]*Kernel[2][2]):0;                                
endmodule
