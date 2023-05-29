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


module dmemory32 (
        input ram_rst_i, // from CPU top
        input ram_clk_i, // from CPU top
        input ram_wen_i, // from Controller
        input [15:0] ram_adr_i, // from alu_result of ALU
        input [31:0] ram_dat_i, // from read_data_2 of Decoder
        output [31:0] ram_dat_o, // the data read from data-ram
        // UART Programmer Pinouts
        input upg_rst_i, // UPG reset (Active High)
        input upg_clk_i, // UPG ram_clk_i (10MHz)
        input upg_wen_i, // UPG write enable
        input [13:0] upg_adr_i, // UPG write address
        input [31:0] upg_dat_i, // UPG write data
        input upg_done_i // 1 if programming is finished
    );

    wire ram_clk = ~ram_clk_i;
    /* CPU work on normal mode when kickOff is 1. CPU work on Uart communicate mode when kickOff is 0.*/
    wire kickOff = ~upg_rst_i | (upg_rst_i & upg_done_i);

    wire [15:0] m_a;
    wire [31:0] m_dout;
    wire [31:0] m_din;
    wire m_rw;

    RAM ram (
            .clka (kickOff ? ram_clk : upg_clk_i),
            .wea (kickOff ? m_rw : upg_wen_i),
            .addra (kickOff ? m_a[15:2] : upg_adr_i),
            .dina (kickOff ? m_din : upg_dat_i),
            .douta (m_dout)
        );

    cache d_cache_dut (
              .clk     (ram_clk),
              .rst_n   (ram_rst_i),
              .p_a     (ram_adr_i),
              .p_dout  (ram_dat_i),
              .p_din   (ram_dat_o),
              .p_strobe(1'b1),
              .p_rw    (ram_wen_i),
              // .p_ready (p_ready),
              .m_a     (m_a),
              .m_dout  (m_dout),
              .m_din   (m_din),
              // .m_strobe(m_strobe),
              .m_rw    (m_rw),
              .m_ready (1'b1)
          );
endmodule
