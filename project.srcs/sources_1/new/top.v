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
    input         fpga_rst_in,   //Active High
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
    wire vga_clk;
    cpuclk clock (
        .clk_in1 (fpga_clk),
        .clk_out1(clk),
        .clk_out2(upg_clk)
    );
    wire [15:0] switch2N4;
    wire fpga_rst;
    wire start_pg;

    Debounce #(
        .key_num(10'd18)
    ) debounce_dut (
        .clock  (clk),
        .rst_n  (1'b1),
        .key_in ({fpga_rst_in, switch2N4_in, start_pg_in}),
        .key_out({fpga_rst, switch2N4, start_pg})
    );


    wire spg_bufg;
    BUFG U1 (
        .I(start_pg),
        .O(spg_bufg)
    );

    wire upg_wen;  //Uart write out enable
    wire upg_done;  //Uart rx data have done
    //data to which memory unit of program_rom/dmemory32
    wire [14:0] upg_adr;
    //data to program_rom or dmemory32
    wire [31:0] upg_dat;
    // Generate UART Programmer reset signal
    reg upg_rst;
    always @(posedge fpga_clk) begin
        if (spg_bufg) upg_rst = 0;
        if (fpga_rst) upg_rst = 1;
    end
    //used for other modules which don't relateto UART wire rst;
    assign rst = fpga_rst | !upg_rst;

    wire upg_clk_o;
    uart_bmpg_0 uart (
        .upg_clk_i (upg_clk),    // 10MHz
        .upg_rst_i (upg_rst),    // High active
        // blkram signals
        .upg_clk_o (upg_clk_o),
        .upg_wen_o (upg_wen),
        .upg_adr_o (upg_adr),
        .upg_dat_o (upg_dat),
        .upg_done_o(upg_done),
        // UART Pinouts
        .upg_rx_i  (rx),
        .upg_tx_o  (tx)
    );

    wire [15:0] rom_adr;
    wire [31:0] Instruction;

    programrom programrom_dut (
        .rom_clk_i    (clk),
        .rom_adr_i    (rom_adr),
        .Instruction_o(Instruction),
        .upg_rst_i    (upg_rst),
        .upg_clk_i    (upg_clk),
        .upg_wen_i    (upg_wen & upg_adr[14]),
        .upg_adr_i    (upg_adr[13:0]),
        .upg_dat_i    (upg_dat),
        .upg_done_i   (upg_done)
    );
    wire [31:0] branch_base_addr;
    wire [31:0] link_addr;
    wire [31:0] Addr_Result;
    wire [31:0] Read_data_1;
    wire [31:0] Read_data_2;
    wire Branch;
    wire nBranch;
    wire Jmp;
    wire Jal;
    wire Jr;
    wire Zero;

    Ifetc32 Ifetc32_dut (
        .Instruction     (Instruction),
        .rom_adr_o       (rom_adr),
        .branch_base_addr(branch_base_addr),
        .link_addr       (link_addr),
        .Addr_result     (Addr_Result),
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

    wire [31:0] mem_data;
    wire [31:0] ALU_Result;
    wire RegWrite;
    wire MemorIOtoReg;
    wire RegDst;
    wire [31:0] Sign_extend;

    decode32 decode32_dut (
        .clock      (clk),
        .reset      (rst),
        .Instruction(Instruction),
        .mem_data   (mem_data),
        .ALU_result (ALU_Result),
        .opcplus4   (link_addr),
        .Jal        (Jal),
        .RegWrite   (RegWrite),
        .MemtoReg   (MemorIOtoReg),
        .RegDst     (RegDst),
        .Sign_extend(Sign_extend),
        .read_data_1(Read_data_1),
        .read_data_2(Read_data_2)
    );

    wire ALUSrc;
    wire MemRead;
    wire MemWrite;
    wire IORead;
    wire IOWrite;
    wire I_format;
    wire Sftmd;
    wire [1:0] ALUOp;

    control32 control32_dut (
        .Opcode         (Instruction[31:26]),
        .Function_opcode(Instruction[5:0]),
        .Jr             (Jr),
        .RegDST         (RegDst),
        .ALUSrc         (ALUSrc),
        .MemorIOtoReg   (MemorIOtoReg),
        .RegWrite       (RegWrite),
        .MemRead        (MemRead),
        .MemWrite       (MemWrite),
        .IORead         (IORead),
        .IOWrite        (IOWrite),
        .Branch         (Branch),
        .nBranch        (nBranch),
        .Jmp            (Jmp),
        .Jal            (Jal),
        .I_format       (I_format),
        .Sftmd          (Sftmd),
        .ALUOp          (ALUOp),
        .AlU_resultHigh (ALU_Result[31:10])
    );


    executs32 executs32_dut (
        .Read_data_1    (Read_data_1),
        .Read_data_2    (Read_data_2),
        .Sign_extend    (Sign_extend),
        .Function_opcode(Instruction[5:0]),
        .Exe_opcode     (Instruction[31:26]),
        .ALUOp          (ALUOp),
        .Shamt          (Instruction[10:6]),
        .PC_plus_4      (branch_base_addr),
        .Sftmd          (Sftmd),
        .ALUSrc         (ALUSrc),
        .I_format       (I_format),
        .Jr             (Jr),
        .Zero           (Zero),
        .ALU_Result     (ALU_Result),
        .Addr_Result    (Addr_Result)
    );

    wire [31:0] write_data;
    wire [31:0] ram_adr_i;
    wire [31:0] ram_dat_o;

    dmemory32 dmemory32_dut (
        .ram_clk_i (clk),
        .ram_wen_i (MemWrite),
        .ram_adr_i (ram_adr_i[15:0]),
        .ram_dat_i (write_data),
        .ram_dat_o (ram_dat_o),
        .upg_rst_i (upg_rst),
        .upg_clk_i (upg_clk),
        .upg_wen_i (upg_wen & upg_adr[14]),
        .upg_adr_i (upg_adr[13:0]),
        .upg_dat_i (upg_dat),
        .upg_done_i(upg_done)
    );

    wire [31:0] ioread_data;
    wire LEDCtrl;
    wire SwitchCtrl;

    MemOrIO MemOrIO_dut (
        .mRead     (MemRead),
        .mWrite    (MemWrite),
        .ioRead    (IORead),
        .ioWrite   (IOWrite),
        .addr_in   (Addr_Result),
        .addr_out  (ram_adr_i),
        .m_rdata   (ram_dat_o),
        .io_rdata  (ioread_data),
        .r_wdata   (mem_data),
        .r_rdata   (Read_data_2),
        .write_data(write_data),
        .LEDCtrl   (LEDCtrl),
        .SwitchCtrl(SwitchCtrl)
    );

    leds leds_dut (
        .ledrst  (rst),
        .led_clk (clk),
        .ledwrite(1'b1),
        .ledcs   (LEDCtrl),
        .ledwdata(write_data[15:0]),
        .ledout  (led2N4)
    );

    ioread ioread_dut (
        .reset             (rst),
        .ior               (IORead),
        .switchctrl        (SwitchCtrl),
        .ioread_data_switch(switch2N4),
        .ioread_data       (ioread_data)
    );


    // vga_colorbar vga_colorbar_dut (
    //     .sys_clk  (fpga_clk),
    //     .sys_rst_n(~rst),
    //     .input_a  (ioread_data[7:0]),
    //     .input_b  (ioread_data[7:0]),
    //     .output_a (led2N4[7:0]),
    //     .hsync    (hsync),
    //     .vsync    (vsync),
    //     .vga_rgb  (vga_rgb)
    // );


endmodule
