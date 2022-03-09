module dig_pointer (
    output   reg    [1:0]   pointer,
    input    wire           clk,
    input    wire           rst
);

always @(posedge clk or negedge rst)
    begin
        if (!rst)
            begin
                pointer <= 2'b00;
            end
        else 
            begin
                pointer <= pointer + 2'b01;
            end
    end
endmodule