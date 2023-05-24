`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/21/2023 04:07:45 PM
// Design Name:
// Module Name: Ifetc32
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




module Ifetc32 (
        Instruction,
        rom_adr_o,
        branch_base_addr,
        Addr_result,
        Read_data_1,
        Branch,
        nBranch,
        Jmp,
        Jal,
        Jr,
        Zero,
        clock,
        reset,
        link_addr
    );
    input [31:0] Instruction;  // the instruction fetched from this module
    output [15:0] rom_adr_o;
    output [31:0] branch_base_addr;  // (pc+4) to ALU which is used by branch type instruction
    output reg [31:0] link_addr;  // (pc+4) to Decoder which is used by jal instruction

    input [31:0] Addr_result;  // the calculated address from ALU
    input [31:0] Read_data_1;  // the address of instruction used by jr instruction
    input Branch;  // while Branch is 1,it means current instruction is beq
    input nBranch;  // while nBranch is 1,it means current instruction is bnq
    input Jmp;  // while Jmp 1, it means current instruction is jump
    input Jal;  // while Jal is 1, it means current instruction is jal
    input Jr;  // while Jr is 1, it means current instruction is jr
    input Zero;  // while Zero is 1, it means the ALUresult is zero
    input clock, reset;  // Clock and reset (Synchronous reset signal, high level is effective, when reset=1, PC value is 0)

    reg [31:0] pc, next_pc;

    assign rom_adr_o = pc[15:0];


    always @*
    begin
        if (Jr == 1'b1)
        begin
            next_pc = Read_data_1;
        end
        else if ((Branch == 1'b1 && Zero == 1'b1) || (nBranch == 1'b1 && Zero == 1'b0))
        begin
            next_pc = Addr_result;
        end
        else
        begin
            next_pc = pc + 4;
        end
    end

    always @(negedge clock)
    begin
        if (reset == 1'b1)
        begin
            pc <= 32'h0000_0000;
        end
        else
        begin
            if (Jmp == 1'b1 || Jal == 1'b1)
            begin
                link_addr <= next_pc;
                pc        <= {pc[31:28], Instruction[25:0], 2'b00};
            end
            else
            begin
                pc <= next_pc;
            end
        end
    end

    assign branch_base_addr = pc + 4;

endmodule
