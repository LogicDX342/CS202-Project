`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/21 17:08:20
// Design Name:
// Module Name: programrom
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


module programrom (
        // Program ROM Pinouts
        input		 rom_rst_i,      // Reset (Active High)
        input         rom_clk_i,      // ROM clock
        input  [15:0] rom_adr_i,      // From IFetch
        output [31:0] Instruction_o,  // To IFetch
        // UART Programmer Pinouts
        input         upg_rst_i,      // UPG reset (Active High)
        input         upg_clk_i,      // UPG clock (10MHz)
        input         upg_wen_i,      // UPG write enable
        input  [13:0] upg_adr_i,      // UPG write address
        input  [31:0] upg_dat_i,      // UPG write data
        input         upg_done_i      // 1 if program finished
    );

    wire [15:0] m_a;
    wire [31:0] m_dout;

    /* if  kickOff is 1 means  CPU work on normal mode,
    otherwise CPU work on Uart communication mode */
    wire rom_clk = !rom_clk_i;
    wire kickOff = !upg_rst_i | (upg_rst_i & upg_done_i);
    prgrom instmem (
               .clka (kickOff ? rom_clk : upg_clk_i),
               .wea  (kickOff ? 1'b0 : upg_wen_i),
               .addra(kickOff ? m_a[15:2] : upg_adr_i),
               .dina (kickOff ? 32'h00000000 : upg_dat_i),
               .douta(m_dout)
           );

    cache i_cache_dut (
              .clk     (rom_clk),
              .rst_n   (~rom_rst_i),
              .p_a     (rom_adr_i),
              //   .p_dout  (),
              .p_din   (Instruction_o),
              .p_strobe(1'b1),
              .p_rw    (1'b0),
              //    .p_ready (),
              .m_a     (m_a),
              .m_dout  (m_dout),
              //    .m_din   (),
              //    .m_strobe(),
              //    .m_rw    (),
              .m_ready (1'b1)
          );
endmodule
