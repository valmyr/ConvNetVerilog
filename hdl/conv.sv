module mulp#(parameter SIZE = 3,WIDTH_BIT = 8)(
    input logic  signed  [WIDTH_BIT-1:0] a,b,
    output logic  signed [WIDTH_BIT-1:0] c
);
    assign c = a*b;
endmodule
module sum#(parameter SIZE = 3,WIDTH_BIT = 8)(
        input logic  signed [WIDTH_BIT-1:0] a,b,
        output logic  signed [WIDTH_BIT-1:0] c
);
    assign c = a+b;
endmodule
module conv#(parameter SIZE = 3,WIDTH_BIT = 8)(
    input   logic                 clock                               ,
    input   logic                 nreset                              ,
    input   logic  signed  [WIDTH_BIT-1:0] inpMatrixI    [SIZE-1:0][SIZE-1:0]  ,
    output  logic  signed  [WIDTH_BIT-1:0] convIxKernel
);
    logic  signed  [WIDTH_BIT-1:0] Kernel [SIZE-1:0][SIZE-1:0];
    initial $readmemh("simulation/Kernel7.txt",Kernel);
    // always_comb convIxKernel = ena ? (inpMatrixI[0][0]*Kernel[0][0]+inpMatrixI[0][1]*Kernel[0][1]+inpMatrixI[0][2]*Kernel[0][2]+
                                    //  inpMatrixI[1][0]*Kernel[1][0]+inpMatrixI[1][1]*Kernel[1][1]+inpMatrixI[1][2]*Kernel[1][2]+
                                    //  inpMatrixI[2][0]*Kernel[2][0]+inpMatrixI[2][1]*Kernel[2][1]+inpMatrixI[2][2]*Kernel[2][2]):0;  

    logic signed [WIDTH_BIT-1:0] ProducMx[SIZE-1:0][SIZE-1:0];
    logic signed [WIDTH_BIT-1:0] SumHoriz[SIZE-1:0][SIZE-1:0];
    logic signed [WIDTH_BIT-1:0] SumVertic[SIZE-1:0];
    generate 
        genvar i,j;
        for(i =0; i < SIZE; i++)begin:MULTI_A
            for(j = 0; j < SIZE; j++)begin:MULTI_A
                mulp #(.SIZE(SIZE),.WIDTH_BIT(WIDTH_BIT))mlp(inpMatrixI[i][j],Kernel[i][j],ProducMx[i][j]);
            end
        end
        for(i =0; i< SIZE; i++)begin:SUM_HOR
            for(j = 0; j < SIZE; j++)begin:SUM_HOR
                if(!j)
                    assign SumHoriz[i][0] = ProducMx[i][0];
                else
                    sum #(.SIZE(SIZE),.WIDTH_BIT(WIDTH_BIT))  sumhoriz (SumHoriz[i][j-1],ProducMx[i][j],SumHoriz[i][j]);
            end
        end
        for(i = 0; i < SIZE; i++)begin:SUM_VERT
            if(!i)assign SumVertic[0] = SumHoriz[0][SIZE-1];
            else sum #(.SIZE(SIZE),.WIDTH_BIT(WIDTH_BIT)) sumvertic(SumVertic[i-1],SumHoriz[i][SIZE-1],SumVertic[i]);
        end
    endgenerate
    assign convIxKernel = SumVertic[SIZE-1];


endmodule