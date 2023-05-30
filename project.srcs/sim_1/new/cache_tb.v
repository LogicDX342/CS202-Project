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
module test_tb;

    // Parameters

    // Ports
    reg clka = 0;
    reg wea = 0;
    reg [13 : 0] addra;
    reg [31 : 0] dina;
    wire [31 : 0] douta;

    test test_dut (
        .clka (clka),
        .wea  (wea),
        .addra(addra),
        .dina (dina),
        .douta(douta)
    );

    initial begin
        begin
            wea =1'b1;
            addra= 14'b10;
            dina= 32'b10101010101010101010101010101010;
            #2
            wea =1'b0;
            addra= 14'b11;
            #2
            wea =1'b0;
            addra= 14'b10;
            #2
            $finish;
        end
    end

    always #1 clka = !clka;

endmodule

