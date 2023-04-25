`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/25/2023 08:27:06 PM
// Design Name:
// Module Name: RegFile
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


module RegFile (
    clk,
    writeEnable,
    readReg1,
    readReg2,
    writeReg,
    writeData,
    readData1,
    readData2
);

    input wire clk;
    input wire writeEnable;
    input wire [4:0] readReg1, readReg2, writeReg;
    input wire [31:0] writeData;
    output wire [31:0] readData1, readData2;


    reg [31:0] regFile[31:0];

    always @(posedge clk) begin
        if (writeEnable) begin
            regFile[writeReg] <= writeData;
        end
    end

    assign readData1 = (readReg1 != 0) ? regFile[readReg1] : 0;
    assign readData2 = (readReg2 != 0) ? regFile[readReg2] : 0;
endmodule
