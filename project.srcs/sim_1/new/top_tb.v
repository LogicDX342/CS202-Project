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


module CPU_TOP_tb;

// Parameters

// Ports
reg fpga_rst = 0;
reg fpga_clk = 0;
reg [15:0] switch2N4_in;
wire [15:0] led2N4;
reg start_pg_in = 0;
reg rx = 0;
wire tx;
wire hsync;
wire vsync;
wire [11:0] vga_rgb;

CPU_TOP 
CPU_TOP_dut (
  .fpga_rst (fpga_rst ),
  .fpga_clk (fpga_clk ),
  .switch2N4_in (switch2N4_in ),
  .led2N4 (led2N4 ),
  .start_pg_in (start_pg_in ),
  .rx (rx ),
  .tx (tx ),
  .hsync (hsync ),
  .vsync (vsync ),
  .vga_rgb  ( vga_rgb)
);

initial begin
  begin
    $finish;
  end
end

always
  #5  fpga_clk = ! fpga_clk ;

endmodule

