module matrixCountIndex#(parameter AROWS = 3,ACOLUMNS = 3,BROWS = 3,BCOLUMNS = 3, WIDTH_BIT=32)(
    input logic clock       ,
    input logic nreset      ,
    output logic [WIDTH_BIT-1:0] i,
    input logic ena,
    input logic standy,
    output logic [WIDTH_BIT-1:0] j,
    output logic [WIDTH_BIT-1:0] k
);

    logic [WIDTH_BIT-1:0] k_current;
    logic [WIDTH_BIT-1:0] i_current;
    logic [WIDTH_BIT-1:0] j_current;

    
    logic [WIDTH_BIT-1:0] k_next;
    logic [WIDTH_BIT-1:0] i_next;
    logic [WIDTH_BIT-1:0] j_next;

    logic flag_current;
    logic flag_next;
    always_ff@(posedge clock, negedge nreset) begin
        if(!nreset)begin
            k_current <= 0;
            j_current <= 0;
            i_current <= 0;
            flag_current <= 1;
        end else begin
            k_current <= k_next;
            j_current <= j_next;
            i_current <= i_next;
            flag_current <= flag_next;
        end
    end

    always_comb begin
        if(flag_current)begin
            k_next = !standy ? k_current: k_current;
            j_next = !standy ? j_current: j_current;
            i_next = !standy ? i_current: i_current;
            flag_next = 0;
        end
        else if(k_current < ACOLUMNS-1) begin 
            k_next = !standy ? k_current+1  :k_current;
            j_next = !standy ? j_current    :j_current;
            i_next = !standy ? i_current    :i_current;
            flag_next = 0;
        end
        else if(j_current < BCOLUMNS-1)begin
            k_next = 0 ;
            j_next = !standy ? j_current+1:j_current;
            i_next = !standy ? i_current:i_current;;
            flag_next = 0;
        end else if(i_current < AROWS-1) begin
            k_next = j_current == k_current ? 0 : k_current;
            j_next = 0;
            i_next = i_current+1;
            flag_next = 0;

        end else begin
            k_next = k_current == i_current ? 0: k_current ;
            j_next = j_current == i_current ? 0: j_current ;
            i_next = 0;
            flag_next = 0;

        end
    end
    assign doneAccess = i == AROWS-1 && j == BCOLUMNS-1 && k == ACOLUMNS;
    assign i = i_current;
    assign j = j_current;
    assign k = k_current;
endmodule