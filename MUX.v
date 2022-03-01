module MUX #(
    parameter WIDTH = 32
) (
    input   wire [WIDTH - 1 : 0]  In1,
    input   wire [WIDTH - 1 : 0]  In2,
    input   wire                  sel,
    output  wire [WIDTH - 1 : 0]  Out
);

assign Out = !sel ? In1 : In2;   //if sel = 0 out = in1, sel = 1 out = in2
    
endmodule