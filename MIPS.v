//MIPS module is the top module of the sytem which contains the interfacing
//between control unit, datapath unit, instruction memory, data memory
//it takes CLK and reset as input and test_value as an output 

module MIPS(
    input   wire            CLK,
    input   wire            reset,
    output  wire     [15:0]  test_value 
);

    wire    [31:0]  Instr;        
    wire            Jmp             ;
    wire            MemtoReg;
    wire            PCSrc;
    wire            ALUSrc;
    wire            RegDst;
    wire            RegWrite        ;    //WE3
    wire    [2:0]   ALUControl;
    wire            MemWrite;
    wire    [31:0]  PC;                 
    wire    [31:0]  ALUResult;      //ALUOut
    wire    [31:0]  ReadData;
    wire    [31:0]  WriteData;      
    wire            Zero;
    
    ControlUnit C1(
        .Instruction(Instr),
        .Zero(Zero),
        .Jmp(Jmp),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    DatapathUnit D1 (
    .CLK(CLK),
    .reset(reset),
    .Instr(Instr),
    .Jmp(Jmp),
    .MemtoReg(MemtoReg),
    .PCSrc(PCSrc),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .RegWrite(RegWrite),
    .ALUControl(ALUControl),
    .ReadData(ReadData),
    .PC(PC),
    .ALUResult(ALUResult),
    .WriteData(WriteData),    
    .Zero(Zero)
);

data_memory M1 (
    .A(ALUResult),          
	.WD(WriteData),
    .CLK(CLK),
	.reset(CLK),
	.WE(MemWrite),
    .RD(ReadData),
	.test_value(test_value)
);

Ins_memory M2(
    .Instruction(Instr),
    .PC(PC)
);

endmodule