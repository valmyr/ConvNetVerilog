module flatten_mod#(parameter WIDTH_BIT=32, SIZEOUTCONV2 = 5, SIZEFLATTEN = 4)(
    input  logic signed [WIDTH_BIT-1:0] maxPoolingOutF1[SIZEOUTCONV2-1:0][SIZEOUTCONV2-1:0]              ,
    input  logic signed [WIDTH_BIT-1:0] maxPoolingOutF2[SIZEOUTCONV2-1:0][SIZEOUTCONV2-1:0]              ,
    input  logic signed [WIDTH_BIT-1:0] maxPoolingOutF3[SIZEOUTCONV2-1:0][SIZEOUTCONV2-1:0]              ,
    input  logic signed [WIDTH_BIT-1:0] maxPoolingOutF4[SIZEOUTCONV2-1:0][SIZEOUTCONV2-1:0]              ,
    output logic signed [WIDTH_BIT-1:0] flattenOut  [SIZEOUTCONV2*SIZEOUTCONV2*SIZEFLATTEN-1:0]
);
    
    always_comb for(integer i = 0, mmm = 0; i < SIZEOUTCONV2; i++)
        for(integer j = 0; j < SIZEOUTCONV2 ; j++)begin
            flattenOut[mmm+0] = maxPoolingOutF1[i][j];
            flattenOut[mmm+1] = maxPoolingOutF2[i][j];
            flattenOut[mmm+2] = maxPoolingOutF3[i][j];
            flattenOut[mmm+3] = maxPoolingOutF4[i][j];
            mmm+=4;
        end
endmodule