`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/13 23:49:33
// Design Name:
// Module Name: control32
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module control32 (
        Opcode,
        Function_opcode,
        Jr,
        RegDST,
        ALUSrc,
        MemorIOtoReg,
        RegWrite,
        MemRead,
        MemWrite,
        IORead,
        IOWrite,
        Branch,
        nBranch,
        Jmp,
        Jal,
        I_format,
        Sftmd,
        ALUOp,
        AlU_resultHigh
    );
    input [5:0] Opcode;  // 来自IFetch模块的指令高6bit
    input [5:0] Function_opcode;  // 来自IFetch模块的指令低6bit，用于区分r-类型中的指令
    output Jr;  // 为1表明当前指令是jr，为0表示当前指令不是jr
    output RegDST;  // 为1表明目的寄存器是rd，为0时表示目的寄存器是rt
    output ALUSrc;  // 为1表明第二个操作数（ALU中的Binput）来自立即数（beq，bne除外），为0时表示第二个操作数来自寄存器
    output MemorIOtoReg;  // 为1表明从存储器或I/O读取数据写到寄存器，为0时表示将ALU模块输出数据写到寄存器
    output RegWrite;  // 为1表明该指令需要写寄存器，为0时表示不需要写寄存器
    output MemRead;  //1 indicates that the instruction needs to read from the memory
    output MemWrite;  // 为1表明该指令需要写存储器，为0时表示不需要写储存器
    output IORead;  // 1 indicates  I/O read
    output IOWrite;  // 1 indicates  I/O write

    output Branch;  // 为1表明是beq指令，为0时表示不是beq指令
    output nBranch;  // 为1表明是bne指令，为0时表示不是bne指令
    output Jmp;  // 为1表明是j指令，为0时表示不是j指令
    output Jal;  // 为1表明是jal指令，为0时表示不是jal指令
    output I_format;  // 为1表明该指令是除beq，bne，lw，sw之外的I-类型指令，其余情况为0
    output Sftmd;  // 为1表明是移位指令，为0表明不是移位指令
    output [1:0] ALUOp;  // 当指令为R-type或I_format为1时，ALUOp的高比特位为1，否则高比特位为0; 当指令为beq或bne时，ALUOp的低比特位为1，否则低比特位为0
    input [21:0] AlU_resultHigh;  // From the execution unit Alu_Result[31..10]

    wire R_format;
    wire Lw;
    wire Sw;

    assign R_format = (Opcode == 6'b000000) ? 1'b1 : 1'b0;
    assign Lw = (Opcode == 6'b100011) ? 1'b1 : 1'b0;
    assign Sw = (Opcode == 6'b101011) ? 1'b1 : 1'b0;

    assign Jr = ((R_format) && (Function_opcode == 6'b001000)) ? 1'b1 : 1'b0;
    assign RegDST = R_format;
    assign ALUSrc = (I_format || Lw || Sw);
    assign MemorIOtoReg = IORead || MemRead;
    assign RegWrite = (R_format || Lw || Jal || I_format) && !(Jr);
    assign MemWrite = ((Sw == 1) && (AlU_resultHigh[21:0] != 22'h0FFFFF)) ? 1'b1 : 1'b0;
    assign MemRead = ((Lw == 1) && (AlU_resultHigh[21:0] != 22'h0FFFFF)) ? 1'b1 : 1'b0;
    assign IORead = ((Lw == 1) && (AlU_resultHigh[21:0] == 22'h0FFFFF)) ? 1'b1 : 1'b0;
    assign IOWrite = ((Sw == 1) && (AlU_resultHigh[21:0] == 22'h0FFFFF)) ? 1'b1 : 1'b0;
    assign Branch = (Opcode == 6'b000100) ? 1'b1 : 1'b0;
    assign nBranch = (Opcode == 6'b000101) ? 1'b1 : 1'b0;
    assign Jmp = (Opcode == 6'b000010) ? 1'b1 : 1'b0;
    assign Jal = (Opcode == 6'b000011) ? 1'b1 : 1'b0;
    assign I_format = (Opcode[5:3] == 3'b001) ? 1'b1 : 1'b0;
    assign Sftmd = (((Function_opcode == 6'b000000) || (Function_opcode == 6'b000010) ||
                     (Function_opcode == 6'b000011) || (Function_opcode == 6'b000100) ||
                     (Function_opcode == 6'b000110) || (Function_opcode == 6'b000111)) && R_format) ? 1'b1 : 1'b0;
    assign ALUOp = {(R_format || I_format), (Branch || nBranch)};

endmodule
