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


module tb_ALU;

    // ALU Parameters
    parameter PERIOD = 10;

    reg         clk = 0;
    // ALU Inputs
    reg  [31:0] Read_data_1 = 0;
    reg  [31:0] Read_data_2 = 0;
    reg  [31:0] Sign_extend = 0;
    reg  [ 5:0] Opcode = 0;
    reg  [ 5:0] Function_opcode = 0;
    reg  [ 4:0] Shamt = 0;
    reg  [31:0] PC_plus_4 = 0;
    reg  [ 1:0] ALUOp = 0;
    reg         ALUSrc = 0;
    reg         I_format = 0;
    reg         Sftmd = 0;

    // ALU Outputs
    wire [31:0] ALU_Result;
    wire        Zero;
    wire [31:0] Addr_Result;


    initial begin
        forever #(PERIOD / 2) clk = ~clk;
    end



    ALU u_ALU (
        .Read_data_1    (Read_data_1[31:0]),
        .Read_data_2    (Read_data_2[31:0]),
        .Sign_extend    (Sign_extend[31:0]),
        .Opcode         (Opcode[5:0]),
        .Function_opcode(Function_opcode[5:0]),
        .Shamt          (Shamt[4:0]),
        .PC_plus_4      (PC_plus_4[31:0]),
        .ALUOp          (ALUOp[1:0]),
        .ALUSrc         (ALUSrc),
        .I_format       (I_format),
        .Sftmd          (Sftmd),

        .ALU_Result (ALU_Result[31:0]),
        .Zero       (Zero),
        .Addr_Result(Addr_Result[31:0])
    );

    initial begin
        // Initialize Inputs
        Read_data_1 = 16;
        Read_data_2 = 64;
        Sign_extend = 4;
        Opcode = 0;
        Function_opcode = 0;
        Shamt = 0;
        PC_plus_4 = 0;
        ALUOp = 0;
        ALUSrc = 0;
        I_format = 0;
        Sftmd = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        $finish;
    end

endmodule
