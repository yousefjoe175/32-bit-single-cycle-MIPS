module ProgramCounter
(
    input   wire            CLK,
    input   wire            reset,
    input   wire   [31:0]   PC_in,
    output  reg    [31:0]   PC
);

always @(posedge CLK , negedge reset)
    begin
        if (~reset)
            begin
                PC <= 32'b0;
            end
        else
            begin
                PC <= PC_in;
            end
    end
endmodule