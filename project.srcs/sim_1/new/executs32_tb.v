`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 10:20:57 PM
// Design Name: 
// Module Name: tb_ALU
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

module executs32_tb;

// Parameters

// Ports
reg [31:0] Read_data_1;
reg [31:0] Read_data_2;
reg [31:0] Sign_extend;
reg [5:0] Function_opcode;
reg [5:0] Exe_opcode;
reg [1:0] ALUOp;
reg [4:0] Shamt;
reg [31:0] PC_plus_4;
reg Sftmd = 0;
reg ALUSrc = 0;
reg I_format = 0;
reg Jr = 0;
wire Zero;
wire [31:0] ALU_Result;
wire [31:0] Addr_Result;

executs32 
executs32_dut (
  .Read_data_1 (Read_data_1 ),
  .Read_data_2 (Read_data_2 ),
  .Sign_extend (Sign_extend ),
  .Function_opcode (Function_opcode ),
  .Exe_opcode (Exe_opcode ),
  .ALUOp (ALUOp ),
  .Shamt (Shamt ),
  .PC_plus_4 (PC_plus_4 ),
  .Sftmd (Sftmd ),
  .ALUSrc (ALUSrc ),
  .I_format (I_format ),
  .Jr (Jr ),
  .Zero (Zero ),
  .ALU_Result (ALU_Result ),
  .Addr_Result  ( Addr_Result)
);

initial begin
  begin
    Read_data_1 = 32'h00000000;
    Read_data_2 = 32'h00000000;
    Sign_extend = 32'h00000000;
    Function_opcode = 6'h00;
    Exe_opcode = 6'h00;
    ALUOp = 2'h0;
    Shamt = 5'h00;
    PC_plus_4 = 32'h00000000;
    Sftmd = 1'b0;
    ALUSrc = 1'b0;
    I_format = 1'b0;
    Jr = 1'b0;
    #10;
    //add $t0, $t1, $t2
    Read_data_1 = 32'h00000006;
    Read_data_2 = 32'h00000008;
    Function_opcode = 6'h20;
    Exe_opcode=6'h00;
    ALUOp = 2'h2;
    Shamt = 5'h00;
    PC_plus_4 = 32'h00000004;
    Sftmd = 1'b0;
    ALUSrc = 1'b0;
    I_format = 1'b0;
    Jr = 1'b0;
    #10;
    Function_opcode=6'h22;
    #10
    //sll $t0, $t1, 2
    Function_opcode=6'h00;
    Exe_opcode=6'h00;
    Sign_extend= 32'h00000000;
    ALUOp = 2'h2;
    Shamt = 5'h02;
    PC_plus_4 = 32'h00000004;
    Sftmd = 1'b1;
    ALUSrc = 1'b0;
    #10;
    $finish;
  end
end


endmodule
