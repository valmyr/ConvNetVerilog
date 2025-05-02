module maxpooling#(parameter SIZE= 28,SIZEOUTCONV = 16, SIZEPOOLING = 2, WIDTH_BIT = 16)(
    input  logic clock                                                                                                ,
    input  logic nreset                                                                                               ,
    output  logic done                                                                                               ,
    input  logic  signed               [WIDTH_BIT-1:0] convIxKernelOut [SIZE:0][SIZE:0]                   ,
    output logic  signed               [WIDTH_BIT-1:0] maxPoolingOut  [SIZEOUTCONV:0][SIZEOUTCONV:0]  
);
    logic [WIDTH_BIT-1:0] i, j, current, next;
    logic ena;
    indexMatrix #(.SIZELin(SIZEOUTCONV +1),.SIZECol(SIZEOUTCONV  +1),.WIDTH_BIT(WIDTH_BIT))indexadorMaxPooling(
        .clock  (clock      )       ,
        .nreset (nreset     )       ,
        .ena    (ena        )       ,
        .i      (i          )       ,
        .j      (j          )
    );
    logic signed [WIDTH_BIT-1:0] bufferMaxPooling [SIZEPOOLING-1:0][SIZEPOOLING-1:0];
    logic signed [WIDTH_BIT-1:0] maxBuffer [SIZEPOOLING-1:0];
    logic signed [WIDTH_BIT-1:0] maxValue  [SIZEPOOLING/2:0];
    logic signed [WIDTH_BIT-1:0] tempMax;
                                 
    assign maxValue[0]   = maxBuffer[0];
    assign tempMax = maxValue[SIZEPOOLING/2];
    generate
        genvar p,x;
        for(p = 0; p < SIZEPOOLING; p++)begin:MAXVALUELIN1
            for(x = 1;x < (SIZEPOOLING/2)+1; x++)begin
                max2num #(.WIDTH_BIT(WIDTH_BIT)) comp1(.a(bufferMaxPooling[p][x-1]),.b(bufferMaxPooling[p][x]), .c(maxBuffer[p]),.ena(ena));
            end    
        end
        for(p = 1; p < (SIZEPOOLING/2)+1; p++)begin:MAXVALUECOL
            max2num #(.WIDTH_BIT(WIDTH_BIT))comp2(.a(maxValue[p-1]),.b(maxBuffer[p]),.c(maxValue[p]),.ena(ena));
        end
    
    endgenerate
    
    always_ff@(posedge clock, negedge nreset)begin
        if(!nreset)begin
            for(integer k = 0; k < SIZEPOOLING; k++)
                for(integer l = 0 ; l < SIZEPOOLING; l++)
                    bufferMaxPooling[k][l] <= 0;
            ena <= 0;
            current <= 0;
            done <= 0;
        end else begin
            current <= next;
            case(current)
                0:begin
                    ena <= 0;
                    done <= 0;
                    for(integer k = 0; k < SIZEPOOLING; k++)
                        for(integer l = 0 ; l < SIZEPOOLING; l++)
                            bufferMaxPooling[k][l] <= convIxKernelOut[k+i][l+j];
                end
                1:begin
                    ena  <= 1;
                    done <= 0;
                end    
                2:begin
                    maxPoolingOut[i][j] <= tempMax; 
                    done <= i == SIZEOUTCONV && j == SIZEOUTCONV;
                    ena <= 0;
                end
            endcase
        end
    end
    always_comb case(current)
        0:next = 1;
        1:next = 2;
        2:next = 0;
    endcase
endmodule
