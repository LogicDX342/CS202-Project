`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2023 11:21:12 AM
// Design Name: 
// Module Name: cache_tb
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

module Ifetc32_tb;

    // Parameters

    // Ports
    wire [31:0] Instruction;
    wire [31:0] branch_base_addr;
    wire [31:0] link_addr;
    reg [31:0] Addr_result;
    reg [31:0] Read_data_1;
    reg Branch = 0;
    reg nBranch = 0;
    reg Jmp = 0;
    reg Jal = 0;
    reg Jr = 0;
    reg Zero = 0;
    reg clock = 0;
    reg reset = 0;

    Ifetc32 Ifetc32_dut (
        .Instruction     (Instruction),
        .branch_base_addr(branch_base_addr),
        .link_addr       (link_addr),
        .Addr_result     (Addr_result),
        .Read_data_1     (Read_data_1),
        .Branch          (Branch),
        .nBranch         (nBranch),
        .Jmp             (Jmp),
        .Jal             (Jal),
        .Jr              (Jr),
        .Zero            (Zero),
        .clock           (clock),
        .reset           (reset)
    );

    initial begin
        begin
            reset = 1;
            #10
            reset = 0;
            #50 $finish;
        end
    end

    always #5 clock = !clock;

endmodule
