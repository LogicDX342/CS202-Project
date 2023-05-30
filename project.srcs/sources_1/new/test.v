`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2023 09:25:57 AM
// Design Name: 
// Module Name: test
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


module test (
    input           clka,   // input wire clka
    input           wea,    // input wire [0 : 0] wea
    input  [13 : 0] addra,  // input wire [13 : 0] addra
    input  [31 : 0] dina,   // input wire [31 : 0] dina
    output [31 : 0] douta   // output wire [31 : 0] douta
);

    RAM your_instance_name (
        .clka (clka),   // input wire clka
        .wea  (wea),    // input wire [0 : 0] wea
        .addra(addra),  // input wire [13 : 0] addra
        .dina (dina),   // input wire [31 : 0] dina
        .douta(douta)   // output wire [31 : 0] douta
    );

endmodule
