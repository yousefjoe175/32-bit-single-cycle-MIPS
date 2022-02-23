module ProgramCounter
(
    input   wire            CLK,
    input   wire            rst,

    output  reg    [31:0]   PC
);

always @(posedge CLK , negedge rst)
    begin
        if (~rst)
            begin
                PC = 32'b0;
            end
        else
            begin
                PC = PC + 32'b100;
            end
    end
endmodule