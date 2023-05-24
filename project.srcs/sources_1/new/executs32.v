`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/25/2023 09:33:21 AM
// Design Name:
// Module Name: ALU
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


module executs32 (
        Read_data_1,
        Read_data_2,
        Sign_extend,
        Function_opcode,
        Exe_opcode,
        ALUOp,
        Shamt,
        ALUSrc,
        I_format,
        Zero,
        Jr,
        Sftmd,
        ALU_Result,
        Addr_Result,
        PC_plus_4
    );
    input [31:0] Read_data_1;  // from Read_data_1 of the decoding unit
    input [31:0] Read_data_2;  // from Read_data_2 of the decoder unit
    input [31:0] Sign_extend;  // the immediate number of extensions from the decoder unit
    input [5:0]
          Function_opcode;  // The function code of the r-form instruction from the finger unit, r-form instructions[5:0]
    input [5:0] Exe_opcode;  // the opcode from the finger unit
    input [1:0] ALUOp;  // control code of the operation instruction from the control unit
    input [4:0] Shamt;  // instruction[10:6] from the fetch unit, specifying the number of shifts
    input Sftmd;  // from the control unit, indicating that it is a shift instruction
    input ALUSrc;  // from the control unit, indicating that the second operand is an immediate number (except beq, bne)
    input I_format;  // from the control unit, indicating that it is an I-type instruction other than beq, bne, LW, SW
    input Jr;  // from the control unit, indicating a JR instruction
    output Zero;  // A value of 1 indicates that the calculated value is 0
    output reg [31:0] ALU_Result;  // Calculated data result
    output [31:0] Addr_Result;  // Calculated address result
    input [31:0] PC_plus_4;  // PC+4 from the fetch unit

    wire [31:0] Ainput, Binput;  // two operands for calculation
    wire [5:0] Exe_code;  // use to generate ALU_ctrl. (I_format == 0) ? Function_opcode : { 3'b000 , Opcode[2:0] };
    wire [2:0] ALU_ctl;  // the control signals which affact operation in ALU directely
    wire [2:0] Sftm;  // identify the types of shift instruction, equals to Function_opcode[2:0]
    reg [31:0] Shift_Result;  // the result of shift operation
    reg [31:0] ALU_output_mux;  // the result of arithmetic or logic calculation
    wire [31:0] Branch_Addr;  // the calculated address of the instruction, Addr_Result is Branch_Addr[31:0]

    assign Ainput     = Read_data_1;
    assign Binput     = (ALUSrc == 0) ? Read_data_2 : Sign_extend[31:0];

    assign Exe_code   = (I_format == 0) ? Function_opcode : {3'b000, Exe_opcode[2:0]};
    assign ALU_ctl[0] = (Exe_code[0] | Exe_code[3]) & ALUOp[1];
    assign ALU_ctl[1] = ((!Exe_code[2]) | (!ALUOp[1]));
    assign ALU_ctl[2] = (Exe_code[1] & ALUOp[1]) | ALUOp[0];
    assign Sftm       = Function_opcode[2:0];
    always @(ALU_ctl or Ainput or Binput)
    begin
        case (ALU_ctl)
            3'b000:
                ALU_output_mux = Ainput & Binput;
            3'b001:
                ALU_output_mux = Ainput | Binput;
            3'b010:
                ALU_output_mux = $signed(Ainput) + $signed(Binput);
            3'b011:
                ALU_output_mux = Ainput + Binput;
            3'b100:
                ALU_output_mux = Ainput ^ Binput;
            3'b101:
                ALU_output_mux = ~(Ainput | Binput);
            3'b110:
                ALU_output_mux = $signed(Ainput) - $signed(Binput);
            3'b111:
                ALU_output_mux = Ainput - Binput;
            default:
                ALU_output_mux = 0;
        endcase
    end
    always @*
    begin  // six types of shift instructions
        if (Sftmd)
        case (Sftm[2:0])
            3'b000:
                Shift_Result = Binput << Shamt;  //Sll rd,rt,shamt 00000
            3'b010:
                Shift_Result = Binput >> Shamt;  //Srl rd,rt,shamt 00010
            3'b100:
                Shift_Result = Binput << Ainput;  //Sllv rd,rt,rs 00100
            3'b110:
                Shift_Result = Binput >> Ainput;  //Srlv rd,rt,rs 00110
            3'b011:
                Shift_Result = $signed(Binput) >>> Shamt;  //Sra rd,rt,shamt 00011
            3'b111:
                Shift_Result = $signed(Binput) >>> Ainput;  //Srav rd,rt,rs 00111
            default:
                Shift_Result = Binput;
        endcase
        else
            Shift_Result = Binput;
    end
    always @*
    begin
        //set type operation (slt, slti, sltu, sltiu)
        if (((ALU_ctl == 3'b111) && (Exe_code[3] == 1'b1)) || ((ALU_ctl[2:1] == 2'b11) && (I_format == 1)))
            ALU_Result = ALU_output_mux[31] == 1 ? 1 : 0;
        //lui operation
        else if ((ALU_ctl == 3'b101) && (I_format == 1))
            ALU_Result[31:0] = {Binput[15:0], 16'b0};
        //shift operation
        else if (Sftmd == 1)
            ALU_Result = Shift_Result;
        //other types of operation in ALU (arithmatic or logic calculation)
        else
            ALU_Result = ALU_output_mux[31:0];
    end
    assign Zero        = (ALU_output_mux == 32'h0000_0000) ? 1'b1 : 1'b0;
    assign Branch_Addr = ALUOp[0] ? {{14{Binput[15]}}, Binput[15:0], 2'b0} : PC_plus_4;
    assign Addr_Result = PC_plus_4 + (Sign_extend << 2);
endmodule
