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
input clock, reset;              // æ¶éåå¤ä½??
input[ 31: 0 ] Instruction;      // åæååæ¥çæä»¤
input[ 31: 0 ] mem_data;         // ä»DATA RAM or I/O portååºçæ°
input[ 31: 0 ] ALU_result;       // ä»æ§è¡ååæ¥çè¿ç®çç»æ
input[ 31: 0 ] opcplus4;         // æ¥èªåæååï¼JALä¸­ç¨
input Jal;                       // æ¥èªæ§å¶ååï¼è¯´ææ¯JALæä»¤
input RegWrite;                  // æ¥èªæ§å¶åå
input MemtoReg;                  // æ¥èªæ§å¶åå
input RegDst;                    // 1è¡¨æç®çå¯å­å¨æ¯rdï¼ä¸º0æ¶è¡¨ç¤ºç®çå¯å­å¨æ¯rt

//output
output[ 31: 0 ] Sign_extend;               // æ©å±åç32ä½ç«å³æ°
output[ 31: 0 ] read_data_1;               // è¾åºçç¬¬ä¸?æä½æ??
output[ 31: 0 ] read_data_2;               // è¾åºçç¬¬äºæä½æ°

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

//32ä¸ªå¯å­å¨
reg[ 31: 0 ] register[ 0: 31 ];

//åå¯å­å¨
reg[ 4: 0 ] write_register_address;
reg[ 31: 0 ] write_data;

//ç¬¦å·ä½æå±?
wire sign_bit;
wire[ 15: 0 ] sign_bit_extend;
assign sign_bit = Instruction[ 15 ];
assign sign_bit_extend = ( sign_bit == 1'b1 ) ? 16'b1111_1111_1111_1111 : 16'b0000_0000_0000_0000;

//ç«å³æ°æå±?
assign Sign_extend = ( opcode == 6'b00_1100 || opcode == 6'b00_1101 || opcode == 6'b00_1110 || opcode == 6'b00_1011 ) ? { 16'b0000_0000_0000_0000, immediate } : { sign_bit_extend, immediate };




//è¯»å¯å­å¨
assign read_data_1 = register[ rs ];
assign read_data_2 = register[ rt ];

//åå¯å­å¨

//åå°åªé
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

//ååªä¸ªæ°æ??
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

//åæä½??
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