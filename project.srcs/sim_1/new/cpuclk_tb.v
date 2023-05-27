`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/27 14:26:55
// Design Name: 
// Module Name: cpuclk_tb
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

module cpuclk_tb( ); // a reference testbench for 'cpuclk' reg clkin;
wire clkout1;
wire clkout2;
wire clkout3;
reg clkin;
cpuclk clk1( .clk_out1(clkout1),.clk_out2(clkout2), .clk_out3(clkout3),.clk_in1(clkin));
initial clkin = 1'b0;
always #5 clkin=~clkin;
endmodule