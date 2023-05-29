`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/01/05 21:42:46
// Design Name:
// Module Name: vga_ctrl
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


module vga_colorbar (
    input       sys_clk,    //25MHz
    input       sys_rst_n,
    input [7:0] input_a,
    input [7:0] input_b,
    input [7:0] output_a,

    output        hsync,
    output        vsync,
    output [11:0] vga_rgb
);


    wire locked;
    wire rst_n;
    wire [9:0] pix_x;
    wire [9:0] pix_y;
    wire [11:0] pix_data;


    assign rst_n = (sys_rst_n && locked);

    clk_wiz_0 clk_wiz_inst (
        // Clock out ports  
        .clk_out1(vga_clk),
        // Status and control signals               
        .reset   (~sys_rst_n),
        .locked  (locked),
        // Clock in ports
        .clk_in1 (sys_clk)
    );

    vga_ctrl vga_ctrl_inst (
        .vga_clk  (vga_clk),
        .sys_rst_n(rst_n),
        .pix_data (pix_data),
        .pix_x    (pix_x),
        .pix_y    (pix_y),
        .hsync    (hsync),
        .vsync    (vsync),
        .vga_rgb  (vga_rgb)
    );

    vga_pic vga_pic_inst (
        .vga_clk  (vga_clk),
        .sys_rst_n(rst_n),
        .pix_x    (pix_x),
        .pix_y    (pix_y),
        .input_a  (input_a),
        .input_b  (input_b),
        .output_a (output_a),
        .pix_data (pix_data)
    );

endmodule
