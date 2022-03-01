module Register_file(
    output	wire	[31 : 0] RD1,
    output	wire	[31 : 0] RD2,
    input  	wire	[31 : 0] WD3,
    input  	wire	[ 4 : 0] A1,
    input  	wire	[ 4 : 0] A2,
    input  	wire	[ 4 : 0] A3,
    input   wire       		 CLK, 
    input   wire       		 WE3,
    input   wire       		 reset
);

	localparam 	FILE_SIZE = 32;

	integer 			k;
	
	reg		[31:0]		regfile [FILE_SIZE - 1 : 0];


	assign	RD1 = regfile[A1];
	assign	RD2 = regfile[A2];
	
	always @(posedge CLK, negedge reset ) 
		begin
			if (~reset) 
				begin
					for(k = 0; k < 32; k = k + 1) 
						begin
							regfile[k] <= 0;
						end
				end
			else 
				begin
					if (WE3) regfile[A3] <= WD3;
				end
		end



endmodule