//the datapath unit contains (register file, ALU, PC, sign extension, Adder(PC+4), Adder(PC branch), SrcB_MUX, wReg_MUX, PC_MUX, rData_MUX)
//the datapath receives signals from the control unit to control the ALU, registers, Muxes, and PC input
//the datapath ouputs/inputs data to/from data memory, instruction memory 

module DatapathUnit (
    input   wire            CLK,
    input   wire            reset,
    input   wire    [31:0]  Instr,
    input   wire            Jmp,
    input   wire            MemtoReg,
    input   wire            PCSrc,
    input   wire            ALUSrc,
    input   wire            RegDst,
    input   wire            RegWrite,   //WE3
    input   wire    [2:0]   ALUControl,
    input   wire            ReadData,

    output  reg     [31:0]  PC,
    output  reg     [31:0]  ALUResult,
    output  wire    [31:0]  WriteData,      
    output  wire            Zero

);
               

    //inputs of register file
    wire            [ 4:0]   A1;
    wire            [ 4:0]   A2;
    wire            [ 4:0]   A3;
    wire            [31:0]   WD3;   //WD3  is the output of rData_MUX
    //outputs of regster file
    wire            [31:0]   RD1;
    wire            [31:0]   RD2;

    assign A1 = Instr[25:21];
    assign A2 = Instr[20:16];
    
    //register file instantiation
    Register_file M1(   .RD1(RD1),
                        .RD2(RD2),
                        .WD3(WD3),
                        .A1(A1),
                        .A2(A2),
                        .A3(A3),
                        .CLK(CLK), 
                        .WE3(WE3),
                        .reset(reset)
    );

    //rData_MUX
    MUX #(.WIDTH(32))   rData_MUX (.In1(ALUResult), .In2(ReadData), .sel(MemtoReg), .Out(WD3));            

    //wReg_MUX
    MUX #(.WIDTH(5))    wReg_MUX (.In1(Instr[20:16]), .In2(Instr[15:11]), .sel(RegDst), .Out(A3));            

    //inputs of ALU
    wire            [31:0]   SrcA;
    wire            [31:0]   SrcB;  //will be multuplexed between RD2 and signImm
    
    //input of sign extension
    wire            [15:0]  Imm ;
    //output of sign extension
    wire            [31:0]  SignImm;
    //sign extenstion instnatiation
    SignExtend S1(
                    .Inst(Instr[15:0]),
                    .SignImm(SignImm)
    );

    //SrC A
    assign  SrcA = RD1; //RD1 will 

    //SrcB_mux instantiation
    MUX #(.WIDTH(32))   SrcB_mux (.In1(RD2), .In2(SignImm), .sel(ALUSrc), .Out(SrcB)); 
    assign WriteData = RD2;

    //ALU instantiation
    ALU AL1(.SrcA(SrcA), .SrcB(SrcB), .ALUControl(ALUControl), .Zero(Zero), .ALUResult(ALUResult) );     //note between the () is the current module port
   
    //inputs of PC_MUX
    wire    [31:0] PCPlus4;
    wire    [31:0] PCBranch;
    //output of PC_MUX
    wire    [31:0] PC_in;

    //PCPlus4
    Adder ADD1 (    .A(PC),
                    .B(32'd4),
                    .C(PCPlus4)
                );
    //PCBranch input
    wire    [31:0] PCBranch_in;
    assign  PCBranch_in = SignImm<<32'd2 ;

    Adder ADD2 (    .A(PCBranch_in),
                    .B(PCPlus4),
                    .C(PCBranch)
                );
    
    //PC_MUX instantiation
    MUX #(.WIDTH(32))   PC_MUX (.In1(PCPlus4), .In2(PCBranch), .sel(PCSrc), .Out(PC_in));
    
    //inputs to PC_J_MUX
    wire    [31:0] PC_JUMP;
    //outputs to PC_J_MUX
    wire    [31:0] PC_JIn;

    assign PC_JUMP = {PCPlus4[31:28],Instr[25:0]<<2};
    
    //PC_J_MUX instantiation
    MUX #(.WIDTH(32))   PC_J_MUX (.In1(PC_in), .In2(PC_JUMP), .sel(Jmp), .Out(PC_JIn));
    
    //PC module
    ProgramCounter PC1 (.CLK(CLK), .reset(reset), .PC_in(PC_JIn), .PC(PC));



endmodule