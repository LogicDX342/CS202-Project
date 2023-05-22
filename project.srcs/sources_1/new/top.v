`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2023 11:22:10 PM
// Design Name: 
// Module Name: top
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


module CPU_TOP (
    input         fpga_rst,      //Active High
    input         fpga_clk,
    input  [15:0] switch2N4_in,
    output [15:0] led2N4,
    // UART Programmer Pinouts
    // start Uart communicate at high level
    input         start_pg_in,   // Active High
    input         rx,            // receive data by UART
    output        tx             // send data by UART
);
    wire clk;
    wire rst;

    cpuclk clock (
        .clk_in  (fpga_clk),
        .clk_out1(clk),
        .clk_out2(upg_clk)
    );

    wire [23:0] switch2N4;
    wire start_pg;

    Debounce #(
        .key_num(10'd18)
    ) debounce_dut (
        .clk    (clk),
        .rst_n  (1'b1),
        .key_in ({fpga_rst, switch2N4_in, start_pg_in}),
        .key_out({rst, switch2N4, start_pg})
    );

    // UART Programmer Pinouts
    wire upg_clk;
    wire upg_clk_o;
    wire upg_wen_o;  //Uart write out enable
    wire upg_done_o;  //Uart rx data have done
    //data to which memory unit of program_rom/dmemory32
    wire [14:0] upg_adr_o;
    //data to program_rom or dmemory32
    wire [31:0] upg_dat_o;

    uart_bmpg_0 uart (
        .upg_clk_i (upg_clk),     // 10MHz
        .upg_rst_i (upg_rst_i),   // High active
        // blkram signals
        .upg_clk_o (upg_clk_o),
        .upg_wen_o (upg_wen_o),
        .upg_adr_o (upg_adr_o),
        .upg_dat_o (upg_dat_o),
        .upg_done_o(upg_done_o),
        // UART Pinouts
        .upg_rx_i  (rx),
        .upg_tx_o  (tx)
    );

    // Generate UART Programmer reset signal
    reg upg_rst;
    always @(posedge fpga_clk) begin
        if (start_pg) upg_rst = 0;
        if (fpga_rst) upg_rst = 1;
    end
    //used for other modules which don't relateto UART wire rst;
    assign rst = fpga_rst | !upg_rst;




    wire [31:0] Read_data_1;
    wire [31:0] Read_data_2;
    wire [31:0] Sign_extend;
    wire [5:0] Function_opcode;
    wire [5:0] Exe_opcode;
    wire [1:0] ALUOp;
    wire [4:0] Shamt;
    wire [31:0] PC_plus_4;
    wire Sftmd;
    wire ALUSrc;
    wire I_format;
    wire Jr;
    wire Zero;
    wire [31:0] ALU_Result;
    wire [31:0] Addr_Result;

    executs32 executs32_dut (
        .Read_data_1    (Read_data_1),
        .Read_data_2    (Read_data_2),
        .Sign_extend    (Sign_extend),
        .Function_opcode(Function_opcode),
        .Exe_opcode     (Exe_opcode),
        .ALUOp          (ALUOp),
        .Shamt          (Shamt),
        .PC_plus_4      (PC_plus_4),
        .Sftmd          (Sftmd),
        .ALUSrc         (ALUSrc),
        .I_format       (I_format),
        .Jr             (Jr),
        .Zero           (Zero),
        .ALU_Result     (ALU_Result),
        .Addr_Result    (Addr_Result)
    );
    control32 control32_dut (
        .Opcode         (Opcode),
        .Function_opcode(Function_opcode),
        .Jr             (Jr),
        .RegDST         (RegDST),
        .ALUSrc         (ALUSrc),
        .MemtoReg       (MemtoReg),
        .RegWrite       (RegWrite),
        .MemWrite       (MemWrite),
        .Branch         (Branch),
        .nBranch        (nBranch),
        .Jmp            (Jmp),
        .Jal            (Jal),
        .I_format       (I_format),
        .Sftmd          (Sftmd),
        .ALUOp          (ALUOp)
    );


    //   vga_colorbar vga_top(
    //     .sys_clk(clk),
    //     .sys_rst_n(1'b1),
    //     .engine_state(1),
    //     .mode(1),
    //     .miles_bin(1),
    //     .hsync(hsync),
    //     .vsync(vsync),
    //     .vga_rgb(vga_rgb));

endmodule
