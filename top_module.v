module top_module (
    output    wire    [7:0]   Result,
    output    wire    [3:0]   tube_enables,
    input     wire            clk,
    input     wire            rst
);

wire  clk_div1, clk_div2;
wire  [15:0] test_value;
wire  [1:0]  pointer;

// Put your Instance Here
 MIPS U1_MIPS (
    .test_value(test_value),
    .CLK(clk_div1),
    .reset(rst)
); 
/*module MIPS(
    input   wire            CLK,
    input   wire            reset,
    output  wire     [15:0]  test_value 
);
MUPS 
*/


clock_divider U0_clock_divider (
    .clk_div1(clk_div1),
    .clk_div2(clk_div2),
    .ref_clk(clk),
    .rst(rst)
);


dig_pointer U2_pointer (
    .pointer(pointer),
    .clk(clk_div2),
    .rst(rst)
);

seg_disp U3_seg_disp (
    .Result(Result),
    .tube_enables(tube_enables),
    .count_val(test_value),
    .dig_pointer(pointer),
    .clk(clk_div2),
    .rst(rst)
);

endmodule