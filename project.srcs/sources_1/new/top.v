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
    output        tx,            // send data by UART
    output        hsync,
    output        vsync,
    output [11:0] vga_rgb
);
    wire clk;
    wire rst;

    // UART Programmer Pinouts
    wire upg_clk;
    wire upg_wen;  //Uart write out enable
    wire upg_done;  //Uart rx data have done
    //data to which memory unit of program_rom/dmemory32
    wire [14:0] upg_adr;
    //data to program_rom or dmemory32
    wire [31:0] upg_dat;

    wire vga_clk;
    cpuclk clock (
        .clk_in1 (fpga_clk),
        .clk_out1(clk),
        .clk_out2(upg_clk),
        .clk_out3(vga_clk)
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



    uart_bmpg_0 uart (
        .upg_clk_i (upg_clk),   // 10MHz
        .upg_rst_i (fpga_rst),  // High active
        // blkram signals
        .upg_clk_o (upg_clk),
        .upg_wen_o (upg_wen),
        .upg_adr_o (upg_adr),
        .upg_dat_o (upg_dat),
        .upg_done_o(upg_done),
        // UART Pinouts
        .upg_rx_i  (rx),
        .upg_tx_o  (tx)
    );



    reg spg_bufg = 0;
    always @(posedge start_pg) begin
        if (fpga_rst) spg_bufg <= 0;
        else spg_bufg <= ~spg_bufg;
    end

    // Generate UART Programmer reset signal
    reg upg_rst;
    always @(posedge fpga_clk) begin
        if (spg_bufg) upg_rst = 0;
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
    wire Jmp;
    wire Jal;
    wire Zero;
    wire RegDst;
    wire Branch;
    wire nBranch;
    wire MemtoReg;
    wire RegWrite;
    wire memWrite;
    wire RegDST;
    wire [31:0] ALU_Result;
    wire [31:0] Addr_Result;
    wire [31:0] Instruction;
    wire [15:0] rom_adr;
    wire [31:0] branch_base_addr;
    wire [31:0] link_addr;
    wire [31:0] Addr_result;
    wire [31:0] mem_data;

    programrom programrom_dut (
        .rom_clk_i    (clk),
        .rom_adr_i    (rom_adr),
        .Instruction_o(Instruction),
        .upg_rst_i    (upg_rst),
        .upg_clk_i    (upg_clk),
        .upg_wen_i    (upg_wen & upg_adr[14]),
        .upg_adr_i    (upg_adr),
        .upg_dat_i    (upg_dat),
        .upg_done_i   (upg_done)
    );

    Ifetc32 Ifetc32_dut (
        .Instruction     (Instruction),
        .rom_adr_o       (rom_adr),
        .branch_base_addr(branch_base_addr),
        .link_addr       (link_addr),
        .Addr_result     (Addr_result),
        .Read_data_1     (Read_data_1),
        .Branch          (Branch),
        .nBranch         (nBranch),
        .Jmp             (Jmp),
        .Jal             (Jal),
        .Jr              (Jr),
        .Zero            (Zero),
        .clock           (clk),
        .reset           (rst)
    );


    decode32 decode32_dut (
        .clock      (clk),
        .reset      (rst),
        .Instruction(Instruction),
        .mem_data   (mem_data),
        .ALU_result (ALU_Result),
        .opcplus4   (link_addr),
        .Jal        (Jal),
        .RegWrite   (RegWrite),
        .MemtoReg   (MemtoReg),
        .RegDst     (RegDst),
        .Sign_extend(Sign_extend),
        .read_data_1(Read_data_1),
        .read_data_2(Read_data_2)
    );


    control32 control32_dut (
        .Opcode         (Instruction[31:26]),
        .Function_opcode(Instruction[5:0]),
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

    executs32 executs32_dut (
        .Read_data_1    (Read_data_1),
        .Read_data_2    (Read_data_2),
        .Sign_extend    (Sign_extend),
        .Function_opcode(Instruction[5:0]),
        .Exe_opcode     (Instruction[31:26]),
        .ALUOp          (ALUOp),
        .Shamt          (Shamt),
        .PC_plus_4      (branch_base_addr),
        .Sftmd          (Sftmd),
        .ALUSrc         (ALUSrc),
        .I_format       (I_format),
        .Jr             (Jr),
        .Zero           (Zero),
        .ALU_Result     (ALU_Result),
        .Addr_Result    (Addr_Result)
    );

    dmemory32 dmemory32_dut (
        .clock    (clk),
        .memWrite (memWrite),
        .address  (address),
        .writeData(writeData),
        .readData (readData)
    );


    MemOrIO MemOrIO_dut (
        .mRead     (mRead),
        .mWrite    (mWrite),
        .ioRead    (ioRead),
        .ioWrite   (ioWrite),
        .addr_in   (addr_in),
        .addr_out  (addr_out),
        .m_rdata   (m_rdata),
        .io_rdata  (io_rdata),
        .r_wdata   (r_wdata),
        .r_rdata   (r_rdata),
        .write_data(write_data),
        .LEDCtrl   (LEDCtrl),
        .SwitchCtrl(SwitchCtrl)
    );

    vga_colorbar vga_colorbar_dut (
        .vga_clk  (vga_clk),
        .sys_rst_n(~rst),
        .input_a  (input_a),
        .input_b  (input_b),
        .output_a (output_a),
        .hsync    (hsync),
        .vsync    (vsync),
        .vga_rgb  (vga_rgb)
    );

endmodule
