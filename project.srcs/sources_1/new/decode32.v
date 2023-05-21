`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/15 10:47:01
// Design Name:
// Module Name: Decoder
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

module decode32( read_data_1, read_data_2, Instruction, mem_data, ALU_result, Jal, RegWrite, MemtoReg, RegDst, Sign_extend, clock, reset, opcplus4 );
//input
input clock, reset;              // 时钟和复�??
input[ 31: 0 ] Instruction;      // 取指单元来的指令
input[ 31: 0 ] mem_data;         // 从DATA RAM or I/O port取出的数
input[ 31: 0 ] ALU_result;       // 从执行单元来的运算的结果
input[ 31: 0 ] opcplus4;         // 来自取指单元，JAL中用
input Jal;                       // 来自控制单元，说明是JAL指令
input RegWrite;                  // 来自控制单元
input MemtoReg;                  // 来自控制单元
input RegDst;                    // 1表明目的寄存器是rd，为0时表示目的寄存器是rt

//output
output[ 31: 0 ] Sign_extend;               // 扩展后的32位立即数
output[ 31: 0 ] read_data_1;               // 输出的第�?操作�??
output[ 31: 0 ] read_data_2;               // 输出的第二操作数

wire[ 5: 0 ] opcode;
wire[ 4: 0 ] rs;
wire[ 4: 0 ] rt;
wire[ 4: 0 ] rd;
wire[ 4: 0 ] shamt;
wire[ 5: 0 ] funct;
wire[ 15: 0 ] immediate;
wire[ 25: 0 ] address;

assign opcode = Instruction[ 31: 26 ];
assign rs = Instruction[ 25: 21 ];
assign rt = Instruction[ 20: 16 ];
assign rd = Instruction[ 15: 11 ];
assign shamt = Instruction[ 10: 6 ];
assign funct = Instruction[ 5: 0 ];
assign immediate = Instruction[ 15: 0 ];
assign address = Instruction[ 25: 0 ];

//32个寄存器
reg[ 31: 0 ] register[ 0: 31 ];

//写寄存器
reg[ 4: 0 ] write_register_address;
reg[ 31: 0 ] write_data;

//符号位拓�?
wire sign_bit;
wire[ 15: 0 ] sign_bit_extend;
assign sign_bit = Instruction[ 15 ];
assign sign_bit_extend = ( sign_bit == 1'b1 ) ? 16'b1111_1111_1111_1111 : 16'b0000_0000_0000_0000;

//立即数拓�?
assign Sign_extend = ( opcode == 6'b00_1100 || opcode == 6'b00_1101 || opcode == 6'b00_1110 || opcode == 6'b00_1011 ) ? { 16'b0000_0000_0000_0000, immediate } : { sign_bit_extend, immediate };




//读寄存器
assign read_data_1 = register[ rs ];
assign read_data_2 = register[ rt ];

//写寄存器

//写到哪里
always @ * begin
  if ( RegWrite == 1'b1 ) begin
    if ( Jal == 1'b1 ) begin
      write_register_address = 5'b11111;
    end
    else if ( RegDst == 1'b1 ) begin
      write_register_address = rd;
    end
    else if ( RegDst == 1'b0 ) begin
      write_register_address = rt;
    end
  end
end

//写哪个数�??
always @ * begin
  if ( RegWrite == 1'b1 ) begin
    if ( Jal == 1'b1 )
      write_data = opcplus4;
    else if ( MemtoReg == 1'b1 )
      write_data = mem_data;
    else if ( MemtoReg == 1'b0 )
      write_data = ALU_result;
  end
end

//写操�??
integer count;
always @( posedge clock ) begin
  if ( reset == 1'b1 ) begin
    for ( count = 0;count < 32;count = count + 1 )
      register[ count ] <= 0;
  end
  else if ( RegWrite == 1'b1 ) begin
    register[ write_register_address ] <= write_data;
  end
end


endmodule