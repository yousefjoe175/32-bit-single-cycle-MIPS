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
    input   wire    [ 2:0]  ALUControl,
    input   wire    [31:0]  ReadData,

    output  wire    [31:0]  PC,
    output  wire    [31:0]  ALUResult,
    output  wire    [31:0]  WriteData,      
    output  wire            Zero

);
          

    
    //inputs of register file
    wire            \[ 4:0]   A1 ;
    wire            [ 4:0]   A2 ;
    wire            [ 4:0]   A3 ;
    wire            [31:0]   WD3;   //WD3  is the output of rData_MUX
    //outputs of regster file
    wire            [31:0]   RD1;
    wire            [31:0]   RD2;

    //inputs of ALU
    wire            [31:0]   SrcA   ;
    wire            [31:0]   SrcB   ;  //will be multuplexed between RD2 and signImm
    
    //input of sign extension
    wire            [15:0]  Imm     ;
    //output of sign extension
    wire            [31:0]  SignImm ;

    //PCBranch input
    wire            [31:0]  PCBranch_in  ;

    //inputs of PC_MUX
    wire            [31:0]  PCPlus4  ;
    wire            [31:0]  PCBranch ;
    //output of PC_MUX
    wire            [31:0]  PC_in    ;
    wire            [31:0]  PC4      ;

    //inputs to PC_J_MUX
    wire            [31:0]  PC_JUMP  ;

    //outputs to PC_J_MUX
    wire            [31:0]  PC_JIn   ;
    wire            [27:0]  JUMP_IMM ;

    assign A1 = Instr[25:21];
    assign A2 = Instr[20:16];
    
/*************************      Register File      *************************/
    Register_file M1
    (   
        .RD1(RD1),
        .RD2(RD2),
        .WD3(WD3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .CLK(CLK), 
        .WE3(RegWrite),
        .reset(reset)
    );

/*************************      DataRead_MUX     *************************/
    MUX #(.WIDTH(32))   rData_MUX 
    ( 
        .In1(ALUResult), 
        .In2(ReadData), 
        .sel(MemtoReg), 
        .Out(WD3)
    );            

/*************************      RegisterWrite_MUX     *************************/
    MUX #(.WIDTH(5))    wReg_MUX 
    (  
        .In1(Instr[20:16]), 
        .In2(Instr[15:11]), 
        .sel(RegDst), 
        .Out(A3)
    );            

    
/*************************      Sign Extension     *************************/
    SignExtend S1
    (
        .Inst(Instr[15:0]),
        .SignImm(SignImm)
    );

    //SrC A (output from Register File and input to ALU)
    assign  SrcA = RD1  ;

/*************************      ALU SRCB MUX     *************************/
    MUX #(.WIDTH(32))   SrcB_mux 
    (  
        .In1(RD2), 
        .In2(SignImm), 
        .sel(ALUSrc), 
        .Out(SrcB)
    ); 
    
    //set the output WriteData which is connected to the data memory to RD2
    assign WriteData = RD2;

/*************************      ALU     *************************/
    ALU AL1
    (
        .SrcA(SrcA), 
        .SrcB(SrcB), 
        .ALUControl(ALUControl), 
        .Zero(Zero), 
        .ALUResult(ALUResult) 
    );     
   
   // connected to Adder with current PC value as we increase a full word which is equal to 4 bytes
    assign PC4 = 32'b100    ;

/*************************      generating PC + 4     *************************/
    Adder ADD1 
    (    
        .A  (PC),
        .B  (PC4),
        .C  (PCPlus4)
    );
    
    //since we are calculating the offset of the target address so we need sign extended 32-bit value of the branch offset address
    assign  PCBranch_in = SignImm<<32'd2    ;

/*************************      generating the target of Branch     *************************/
    Adder ADD2 
    (    
        .A(PCBranch_in),
        .B(PCPlus4),
        .C(PCBranch)
    );
    
/*************************      Program Counter source MUX     *************************/
    MUX #(.WIDTH(32))   PC_MUX 
    (
        .In1(PCPlus4), 
        .In2(PCBranch), 
        .sel(PCSrc), 
        .Out(PC_in)
    );
    
    //setting the absolute address of the Jump instruction by setting 2 MSBs as 00 and take the 4 MSB from current PC value
    assign JUMP_IMM     =   Instr[25:0] ;
    assign PC_JUMP      =   {PCPlus4[31:28],JUMP_IMM<<2}    ;
    
/*************************      Program Counter source with JUMP MUX     *************************/
    MUX #(.WIDTH(32))   PC_J_MUX 
    (
        .In1(PC_in), 
        .In2(PC_JUMP), 
        .sel(Jmp), 
        .Out(PC_JIn)
    );
    
/*************************      Program Counter Module     *************************/
    ProgramCounter PC1 
    (
        .CLK(CLK), 
        .reset(reset), 
        .PC_in(PC_JIn), 
        .PC(PC)
    );



endmodule