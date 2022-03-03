module data_memory (
    input 	wire	[31:0] 	A,
	input 	wire	[31:0] 	WD,
    input 	wire			CLK,
	input 	wire			reset,
	input 	wire			WE,
    output	wire	[31:0]  RD,
	output	wire	[15:0] 	test_value
);

	localparam MEMORY_SIZE = 100;
	integer k;

	reg [31:0] data_mem [MEMORY_SIZE - 1:0];


	assign RD = data_mem[A];

	always @(posedge CLK, negedge reset) 
		begin
			if(!reset) 
				begin
					for(k = 0; k < MEMORY_SIZE; k = k + 1) 
						begin
							data_mem[k] <= 0;
						end
				end
			else 
				begin
					if(WE) data_mem[A] <= WD;         
				end
		
		end

//needs to add the test_value functionality
assign test_value = data_mem[0];

endmodule