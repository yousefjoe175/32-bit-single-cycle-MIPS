module clock_divider (
    output    wire     clk_div1, clk_div2,
    input     wire     ref_clk,
    input     wire     rst
);

reg    [31:0]    counter;

assign clk_div1 = counter[23];
assign clk_div2 = counter[16];


always @(posedge ref_clk or negedge rst)
    begin
        if (!rst)
            begin
                counter <= 32'b0;
            end
        else
            begin
                counter <= counter + 32'b1;
            end
    end
endmodule