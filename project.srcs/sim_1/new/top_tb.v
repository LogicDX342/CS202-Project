`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2023 12:11:36 AM
// Design Name: 
// Module Name: top_tb
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


// module CPU_TOP_tb;

// // Parameters

// // Ports
// reg fpga_rst = 0;
// reg fpga_clk = 0;
// reg [15:0] switch2N4_in;
// wire [15:0] led2N4;
// reg start_pg_in = 0;
// reg rx = 0;
// wire tx;
// wire hsync;
// wire vsync;
// wire [11:0] vga_rgb;

// CPU_TOP 
// CPU_TOP_dut (
  // .fpga_rst (fpga_rst ),
  // .fpga_clk (fpga_clk ),
  // .switch2N4_in (switch2N4_in ),
  // .led2N4 (led2N4 ),
  // .start_pg_in (start_pg_in ),
  // .rx (rx ),
  // .tx (tx ),
  // .hsync (hsync ),
  // .vsync (vsync ),
  // .vga_rgb  ( vga_rgb)
// );

// initial begin
  // begin
    // $finish;
  // end
// end

// always
  // #5  fpga_clk = ! fpga_clk ;

// endmodule

`timescale 1ns / 1ps

module CPU_TOP_tb();
reg clk = 0;
reg rst = 1'b1;
reg  [23:0] switch2N4 = 8'b10101010;
wire [23:0]led2N4;
reg start_pg_in = 0;
reg rx ;
wire tx;
wire hsync;
wire vsync;
wire [11:0] vga_rgb;

CPU_TOP test(
.fpga_rst_in(rst),
.fpga_clk(clk),
.switch2N4_in(switch2N4),
.led2N4(led2N4),
  .start_pg_in (start_pg_in ),
  .rx (rx ),
  .tx (tx ),
  .hsync (hsync ),
  .vsync (vsync ),
  .vga_rgb  ( vga_rgb)
);
initial begin
#10 rx=0;

#4000
rst = 0;
switch2N4 = 24'b00100000_1110_1110_1101_0000;
#10000 $finish;
end
always #10 clk = ~clk;
endmodule