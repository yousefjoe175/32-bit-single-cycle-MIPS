module Ins_memory(
    output reg  [31:0] 		Instruction,
    input  wire	[31:0]    	PC
);
	localparam MEMORY_SIZE = 100;
	
	reg [31:0] 	mem [MEMORY_SIZE - 1 : 0];

	initial 
		begin
			$readmemh("Code.txt", mem);
		end

	always @(PC) 
		begin
			Instruction = mem[PC>>2];
		end

endmodule