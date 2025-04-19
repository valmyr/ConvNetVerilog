module mulp#(parameter SIZE = 3,WIDTH_BIT = 8)(
    input logic [WIDTH_BIT-1:0] a,b,
    output logic [WIDTH_BIT-1:0] c
);
    assign c = a*b;
endmodule
module sum#(parameter SIZE = 3,WIDTH_BIT = 8)(
        input logic [WIDTH_BIT-1:0] a,b,
        output logic [WIDTH_BIT-1:0] c
);
    assign c = a+b;
endmodule
module conv#(parameter SIZE = 3,WIDTH_BIT = 8)(
    input   logic                 clock                               ,
    input   logic                 nreset                              ,
    input   logic ena                                                 ,
    input   logic [WIDTH_BIT-1:0] inpMatrixI    [SIZE-1:0][SIZE-1:0]  ,
    output  logic [WIDTH_BIT-1:0] convIxKernel
);
    logic [WIDTH_BIT-1:0] Kernel [SIZE-1:0][SIZE-1:0];
    initial $readmemb("simulation/Kernel.txt",Kernel);
    // always_comb convIxKernel = ena ? (inpMatrixI[0][0]*Kernel[0][0]+inpMatrixI[0][1]*Kernel[0][1]+inpMatrixI[0][2]*Kernel[0][2]+
                                    //  inpMatrixI[1][0]*Kernel[1][0]+inpMatrixI[1][1]*Kernel[1][1]+inpMatrixI[1][2]*Kernel[1][2]+
                                    //  inpMatrixI[2][0]*Kernel[2][0]+inpMatrixI[2][1]*Kernel[2][1]+inpMatrixI[2][2]*Kernel[2][2]):0;  

    logic [WIDTH_BIT-1:0] ProducMx[SIZE-1:0][SIZE-1:0];
    logic [WIDTH_BIT-1:0] SumHoriz[SIZE-1:0][SIZE-1:0];
    logic [WIDTH_BIT-1:0] SumVertic[SIZE-1:0];
    generate 
        genvar i,j;
        for(i =0; i< SIZE; i=i+1)begin:MULTI_A
            for(j = 0; j < SIZE; j++)begin:MULTI_A
                mulp mlp(inpMatrixI[i][j],Kernel[i][j],ProducMx[i][j]);
            end
        end
        for(i =0; i< SIZE; i=i+1)begin:SUM_HOR
            for(j = 0; j < SIZE; j++)begin:SUM_HOR
                if(j == 0)
                    assign SumHoriz[i][0] = ProducMx[i][0];
                else
                    sum s(SumHoriz[i][j-1],ProducMx[i][j],SumHoriz[i][j]);
            end
        end

        for(i = 0; i < SIZE; i++)begin:SUM_VERT
            if(i == 0)assign SumVertic[0] = SumHoriz[0][2];
            else sum si(SumVertic[i-1],SumHoriz[i][2],SumVertic[i]);
        end
    endgenerate
    // assign convIxKernel = O[0][2]+O[1][2]+O[2][2];
    assign convIxKernel = SumVertic[2];


endmodule

/*
    sum s(O[0][1-1],W[0][1],O[0][1]);
    sum s(O[0][2-1],W[0][2],O[0][2]);


    O[0],W[1],O[1]
    O[1],W[2],O[2]
    O[2],W[3],O[3]
    O[3],W[4],O[4]
    O[4],W[5],O[5]
    O[5],W[6],O[6]
    O[6],W[7],O[7]
    O[7],W[8],O[8]



    00 01 02 
    10 11 12
    20 21 22
    
    11 12 13
    21 22 23
    31 32 33

    2 3 4
    3 4 5 
    4 5 6
*/