module Ins_memory(
    output reg  [31:0] 		Instr,
    input  wire	[31:0]    	PC
);
	localparam MEMORY_SIZE = 100;
	
	reg [31:0] 	mem [MEMORY_SIZE - 1 : 0];

	initial 
		begin
			$readmemh("code.dat", mem);
		end

	always @(PC) 
		begin
			Instr = mem[PC>>4];
		end

endmodule