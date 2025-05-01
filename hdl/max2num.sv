module max2num#(parameter WIDTH_BIT = 16)(
    input  logic signed [WIDTH_BIT-1:0] a           ,
    input  logic ena                                ,
    input  logic signed [WIDTH_BIT-1:0] b           ,
    output logic signed [WIDTH_BIT-1:0] c          
);

always_comb 
    if(ena)
        if(a >= b)      c = a   ;
        else            c = b   ;
    else                c = 0   ;
endmodule