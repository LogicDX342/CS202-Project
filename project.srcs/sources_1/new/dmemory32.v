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

    wire [15:0] m_a;
    wire [31:0] m_dout;
    wire [31:0] m_din;
    wire m_rw;

    RAM ram (
    .clka(clk), // input wire clka
    .wea(m_rw), // input wire [0 : 0] wea
    .addra(m_a[15:2]), // input wire [13 : 0] addra
    .dina(m_din), // input wire [31 : 0] dina
    .douta(m_dout) // output wire [31 : 0] douta
    );

    cache d_cache_dut (
        .clk     (clk),
        // .rst_n   (~reset),
        .p_a     (address[15:0]),
        .p_dout  (writeData),
        .p_din   (readData),
        .p_strobe(1'b1),
        .p_rw    (memWrite),
        // .p_ready (p_ready),
        .m_a     (m_a),
        .m_dout  (m_dout),
        .m_din   (m_din),
        // .m_strobe(m_strobe),
        .m_rw    (m_rw),
        .m_ready (1'b1)
    );
    
endmodule
