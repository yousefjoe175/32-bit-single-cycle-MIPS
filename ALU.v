module ALU 
(
    input   wire    [31:0]   SrcA,
    input   wire    [31:0]   SrcB,
    input   wire    [2:0]    ALUControl,

    output  reg     [31:0]  ALUResult,   
    output  wire            Zero
);

//note: don't register neither the output nor the inputs

localparam AND  = 3'b000;
localparam OR   = 3'b001;
localparam PLS  = 3'b010;
localparam MIN  = 3'b100;
localparam MUL  = 3'b101;
localparam SLT  = 3'b110;

    always @ (*)
        begin
            case (ALUControl)
                AND :   ALUResult <= SrcA & SrcB ;
                OR  :   ALUResult <= SrcA | SrcB ;
                PLS :   ALUResult <= SrcA + SrcB ;
                MIN :   ALUResult <= SrcA - SrcB ;
                MUL :   ALUResult <= SrcA * SrcB ;
                SLT :   ALUResult <= (SrcA < SrcB);

                default :   ALUResult <= ALUResult ;
            endcase
        end
    assign  Zero  = ~|ALUResult;
endmodule