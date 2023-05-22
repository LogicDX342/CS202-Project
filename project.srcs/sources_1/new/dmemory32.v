`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/21 16:20:33
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(clock, memWrite, address, writeData, readData);
    input clock;   //Clock signal.
    input memWrite;  //From controller. 1'b1 indicates write operations to data-memory.
    input [31:0] address;  //The unit is byte. The address of memory unit which is to be read/writen.
    input [31:0] writeData; //Data to be wirten to the memory unit.
    output[31:0] readData;  //Data read from memory unit.
    wire clk;
    assign clk = !clock;
    RAM ram (
    .clka(clk), // input wire clka
    .wea(memWrite), // input wire [0 : 0] wea
    .addra(address[15:2]), // input wire [13 : 0] addra
    .dina(writeData), // input wire [31 : 0] dina
    .douta(readData) // output wire [31 : 0] douta
    );
    
endmodule
