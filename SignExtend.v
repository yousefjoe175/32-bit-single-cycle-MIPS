module SignExtend
(
    input   wire    [15:0]  Inst,

    output  wire    [31:0]  SignImm
);

    assign  SignImm = {{16{Inst[15]}},Inst};

endmodule