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
module cache_tb;

    // Parameters
    localparam A_WIDTH = 16;
    localparam C_INDEX = 6;
    localparam D_WIDTH = 32;

    // Ports
    reg clk = 0;
    reg rst_n = 0;
    reg [A_WIDTH-1:0] p_a;
    reg [D_WIDTH-1:0] p_dout;
    wire [D_WIDTH-1:0] p_din;
    reg p_strobe = 0;
    reg p_rw = 0;
    wire p_ready;
    wire [A_WIDTH-1:0] m_a;
    reg [D_WIDTH-1:0] m_dout;
    wire [D_WIDTH-1:0] m_din;
    wire m_strobe;
    wire m_rw;
    reg m_ready = 1;

    cache cache_dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .p_a     (p_a),
        .p_dout  (p_dout),
        .p_din   (p_din),
        .p_strobe(p_strobe),
        .p_rw    (p_rw),
        .p_ready (p_ready),
        .m_a     (m_a),
        .m_dout  (m_dout),
        .m_din   (m_din),
        .m_strobe(m_strobe),
        .m_rw    (m_rw),
        .m_ready (m_ready)
    );

    initial begin
        begin
            rst_n = 0;
            #10;
            rst_n = 1;
            p_a= 4'b1111;
            p_dout= 4'b1010;
            p_strobe= 1;
            p_rw= 0;
            m_dout=4'b1100;
            #10;
            p_strobe= 0;
            #10;
            p_strobe= 1;
            p_rw= 1;
            p_a=4'b0;
            p_dout=4'b1111;
            #10;
            p_strobe= 1;
            p_rw= 0;
            p_a=4'b0;
            m_dout=4'b0;
            #10;
            p_a=4'b1111;
            #10;
            $finish;

        end
    end

    always #1 clk = !clk;

endmodule
