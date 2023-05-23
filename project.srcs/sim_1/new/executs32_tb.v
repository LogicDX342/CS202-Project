`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/28 23:04:50
// Design Name: 
// Module Name: sim_executs32
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


module sim_executs32();
   reg[31:0]  Read_data_1 = 32'h00000005;		//r-form rs
   reg[31:0]  Read_data_2 = 32'h00000006;        //r-form rt
   reg[31:0]  Imme_extend = 32'hffffff40;        //i-form
   reg[5:0]   Function_opcode = 6'b100000;      //add 
   reg[5:0]   opcode = 6'b000000;          //op code
   reg[1:0]   ALUOp = 2'b10;
   reg[4:0]   Shamt = 5'b00000;
   reg        Sftmd = 1'b0;
   reg        ALUSrc = 1'b0;
   reg        I_format = 1'b0;
   reg        Jr = 1'b0;
   reg[31:0]  PC_plus_4 = 32'h00000004;
   // output
   wire       Zero;
   wire[31:0] ALU_Result;
   wire[31:0] Addr_Result;        //pc op        
 
    wire       Zero_t;
   wire[31:0] ALU_Result_t;
   wire[31:0] Addr_Result_t;        //pc op    
    
   executs32 Uexe(.Read_data_1(Read_data_1),.Read_data_2(Read_data_2),.Sign_extend(Imme_extend),.Function_opcode(Function_opcode),.Exe_opcode(opcode),.ALUOp(ALUOp),
                     .Shamt(Shamt),.ALUSrc(ALUSrc),.I_format(I_format),.Zero(Zero),.Sftmd(Sftmd),.ALU_Result(ALU_Result),.Addr_Result(Addr_Result),.PC_plus_4(PC_plus_4),
                     .Jr(Jr));

   integer i=0;           
   initial begin
           /////////////////////////////////////////////////////////////////////////////////////////
           #10 begin opcode = 6'b000000;          // 
                   Read_data_1 = 32'h00000001;        //r-form rs
                   Read_data_2 = 32'h00000001;        //r-form rt
                   Imme_extend = 32'h00000001;  
                   Function_opcode = 6'b100000;       // add
                   ALUOp = 2'b10;
                   Shamt = 5'b00000;
                   Sftmd = 1'b0;
                   ALUSrc = 1'b0;
                   I_format = 1'b0;
                   PC_plus_4 = 32'h0000_1230;
                   
               end
               i=i+1;
               $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
               $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
           /////////////////////////////////////////////////////////////////////////////////////////
           #10 begin opcode = 6'b000000;          // 
                   Read_data_1 = 32'h00000001;        //r-form rs
                   Read_data_2 = 32'h00000002;        //r-form rt
                   Imme_extend = 32'hffffffff;  
                   Function_opcode = 6'b100000;       // add
                   ALUOp = 2'b10;
                   Shamt = 5'b00000;
                   Sftmd = 1'b0;
                   ALUSrc = 1'b0;
                   I_format = 1'b0;
                   PC_plus_4 = 32'h0000_1230;
               end
               i=i+1;
               $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
               $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
           /////////////////////////////////////////////////////////////////////////////////////////
           #10 begin opcode = 6'b000000;          // 
                   Read_data_1 = 32'h00000001;        //r-form rs
                   Read_data_2 = 32'h00000002;        //r-form rt
                   Imme_extend = 32'hffffffff;  
                   Function_opcode = 6'b100000;       // add
                   ALUOp = 2'b10;
                   Shamt = 5'b00000;
                   Sftmd = 1'b0;
                   ALUSrc = 1'b0;
                   I_format = 1'b0;
                   PC_plus_4 = 32'h0000_1230;
               end
               i=i+1;
               $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
               $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
           /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001000;           //addi 
                           Read_data_1 = 32'h00000003;           //r-form rs
                           Read_data_2 = 32'h00000006;        //r-form rt
                           Imme_extend = 32'hffffff40;  
                           Function_opcode = 6'b100000;       //addi 
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000008;
                   end
                   i=i+1;
                   $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                   $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001000;           //addi 
                            Read_data_1 = 32'h00000001;           //r-form rs
                            Read_data_2 = 32'h00000006;        //r-form rt
                            Imme_extend = 32'hffffffff;  
                            Function_opcode = 6'b100000;       //addi 
                            ALUOp = 2'b10;
                            Shamt = 5'b00000;
                            Sftmd = 1'b0;
                            ALUSrc = 1'b1;
                            I_format = 1'b1;
                            PC_plus_4 = 32'h00000008;
                   end
                   i=i+1;
                   $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                   $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001001;           // 
                           Read_data_1 = 32'h00000003;           //r-form rs
                           Read_data_2 = 32'h00000006;        //r-form rt
                           Imme_extend = 32'hffffff40;  
                           Function_opcode = 6'b100000;       // addiu
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001001;           // 
                            Read_data_1 = 32'h00000001;           //r-form rs
                            Read_data_2 = 32'h00000006;        //r-form rt
                            Imme_extend = 32'hffffffff;  
                            Function_opcode = 6'b100000;       // addiu
                            ALUOp = 2'b10;
                            Shamt = 5'b00000;
                            Sftmd = 1'b0;
                            ALUSrc = 1'b1;
                            I_format = 1'b1;
                            PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001100;           // 
                           Read_data_1 = 32'h00ffff00;           //r-form rs
                           Read_data_2 = 32'h00000006;        //r-form rt
                           Imme_extend = 32'h0000ffff;  
                           Function_opcode = 6'b100000;       // andi
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001101;           // 
                            Read_data_1 = 32'h00ffff00;           //r-form rs
                            Read_data_2 = 32'h00000006;        //r-form rt
                            Imme_extend = 32'h0000ffff;  
                            Function_opcode = 6'b100000;       // ori
                            ALUOp = 2'b10;
                            Shamt = 5'b00000;
                            Sftmd = 1'b0;
                            ALUSrc = 1'b1;
                            I_format = 1'b1;
                            PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001111;           // 
                           Read_data_1 = 32'h00000000;           //r-form rs
                           Read_data_2 = 32'h00000006;        //r-form rt
                           Imme_extend = 32'h12345678;  
                           Function_opcode = 6'b100000;       // lui
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b100011;           // 
                           Read_data_1 = 32'h00000000;           //r-form rs
                           Read_data_2 = 32'h00000006;        //r-form rt
                           Imme_extend = 32'h12345678;  
                           Function_opcode = 6'b100000;       // lw
                           ALUOp = 2'b00;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b0;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b101011;          // 
                           Read_data_1 = 32'h00000000;        //r-form rs
                           Read_data_2 = 32'h00000006;        //r-form rt
                           Imme_extend = 32'h12345678;  
                           Function_opcode = 6'b100000;       // sw
                           ALUOp = 2'b00;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b0;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b000100;          // 
                           Read_data_1 = 32'h00000001;        //r-form rs
                           Read_data_2 = 32'h00000001;        //r-form rt
                           Imme_extend = 32'h12345670;  
                           Function_opcode = 6'b100000;       // beq
                           ALUOp = 2'b01;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b0;
                           I_format = 1'b0;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);;
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b000100;          // 
                           Read_data_1 = 32'h00000001;        //r-form rs
                           Read_data_2 = 32'h00000002;        //r-form rt
                           Imme_extend = 32'h12345670;  
                           Function_opcode = 6'b100000;       // beq
                           ALUOp = 2'b01;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b0;
                           I_format = 1'b0;
                           PC_plus_4 = 32'h00000004;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b000101;          // 
                           Read_data_1 = 32'h00000001;        //r-form rs
                           Read_data_2 = 32'h00000001;        //r-form rt
                           Imme_extend = 32'h12345670;  
                           Function_opcode = 6'b100000;       // bne
                           ALUOp = 2'b01;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b0;
                           I_format = 1'b0;
                           PC_plus_4 = 32'h00000008;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b000101;          // 
                           Read_data_1 = 32'h00000001;        //r-form rs
                           Read_data_2 = 32'h00000002;        //r-form rt
                           Imme_extend = 32'h12345670;  
                           Function_opcode = 6'b100000;       // bne
                           ALUOp = 2'b01;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b0;
                           I_format = 1'b0;
                           PC_plus_4 = 32'h00000004;
                       end
                   i=i+1;
                       $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                       $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b0001010; // SLTI SLTI          
                           Read_data_1 = 32'h00000001;        // r-form rs
                           Read_data_2 = 32'h00000011;        // r-form rt
                           Imme_extend = 32'h00000011;  
                           Function_opcode = 6'b001010;      // SLTI 2a
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000022;
                      end
                   i=i+1;
                      $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                      $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001010;    // SLTI
                           Read_data_1 = 32'h00000011;        // r-form rs
                           Read_data_2 = 32'h00000001;        // r-form rt
                           Imme_extend = 32'h00000001;  
                           Function_opcode = 6'b000000;      // SLTI 2a
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000022;
                     end
                   i=i+1;
                     $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                     $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001010;    // SLTI
                           Read_data_1 = 32'hffffffff;        // r-form rs
                           Read_data_2 = 32'h00000001;        // r-form rt
                           Imme_extend = 32'h00000001;  
                           Function_opcode = 6'b000000;      // SLTI 2a
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000022;
                     end
                   i=i+1;
                     $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                     $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                   #10 begin opcode = 6'b001011;    // SLTIU
                           Read_data_1 = 32'hffffffff;        // r-form rs
                           Read_data_2 = 32'h00000001;        // r-form rt
                           Imme_extend = 32'h00000001;  
                           Function_opcode = 6'b000000;      // SLTIU 2a
                           ALUOp = 2'b10;
                           Shamt = 5'b00000;
                           Sftmd = 1'b0;
                           ALUSrc = 1'b1;
                           I_format = 1'b1;
                           PC_plus_4 = 32'h00000022;
                     end
                   i=i+1;
                     $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                     $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                   /////////////////////////////////////////////////////////////////////////////////////////
                    #10 begin 
                              opcode = 6'b000000;  //
                              Read_data_1 = 32'h00000004;        //r-form rs
                              Read_data_2 = 32'h000000f0;        //r-form rt
                              Imme_extend = 32'hffffff40;  
                              Function_opcode = 6'b000110;      // srlv��00_0110��
                              ALUOp = 2'b10;
                              Shamt = 5'b00000;
                              Sftmd = 1'b1;
                              ALUSrc = 1'b0;
                              I_format = 1'b0;
                              PC_plus_4 = 32'h00000010;
                          end 
                   i=i+1;
                            $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                            $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                              opcode = 6'b000000;  //
                              Read_data_1 = 32'h00000004;        //r-form rs
                              Read_data_2 = 32'hfffffff0;        //r-form rt
                              Imme_extend = 32'hffffff40;  
                              Function_opcode = 6'b000110;      //srlv 
                              ALUOp = 2'b10;
                              Shamt = 5'b00000;
                              Sftmd = 1'b1;
                              ALUSrc = 1'b0;
                              I_format = 1'b0;
                              PC_plus_4 = 32'h00000010;
                          end 
                   i=i+1;
                            $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                            $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                              opcode = 6'b000000;  //
                              Read_data_1 = 32'h00000004;        //r-form rs
                              Read_data_2 = 32'h000000f0;        //r-form rt
                              Imme_extend = 32'hffffff40;  
                              Function_opcode = 6'b000111;      //srav
                              ALUOp = 2'b10;
                              Shamt = 5'b00000;
                              Sftmd = 1'b1;
                              ALUSrc = 1'b0;
                              I_format = 1'b0;
                              PC_plus_4 = 32'h00000010;
                          end 
                   i=i+1;
                            $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                            $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                              opcode = 6'b000000;  //
                              Read_data_1 = 32'h00000004;        //r-form rs
                              Read_data_2 = 32'hfffffff0;        //r-form rt
                              Imme_extend = 32'hffffff40;  
                              Function_opcode = 6'b000111;      //srav
                              ALUOp = 2'b10;
                              Shamt = 5'b00000;
                              Sftmd = 1'b1;
                              ALUSrc = 1'b0;
                              I_format = 1'b0;
                              PC_plus_4 = 32'h00000010;
                          end 
                   i=i+1;
                            $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                            $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                                  opcode = 6'b000000;  //sll
                                  Read_data_1 = 32'h00000001;        //r-form rs
                                  Read_data_2 = 32'h00000002;        //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b000000;      //sll
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00011;
                                  Sftmd = 1'b1;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h00000010;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                                  opcode = 6'b000000;  //srl
                                  Read_data_1 = 32'h00000001;        //r-form rs
                                  Read_data_2 = 32'h00000002;        //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b000010;      //srl
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00001;
                                  Sftmd = 1'b1;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h00000000;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                         /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                                  opcode = 6'b000000;  //srl
                                  Read_data_1 = 32'h00000001;        //r-form rs
                                  Read_data_2 = 32'hfffffff0;        //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b000010;      //srl
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00100;
                                  Sftmd = 1'b1;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h00000000;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin 
                                  opcode = 6'b000000;
                                  Read_data_1 = 32'h00000001;        //r-form rs
                                  Read_data_2 = 32'hfffffff0;        //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b000011; //sra
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00100;
                                  Sftmd = 1'b1;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h00000000;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000; // SLT SLT          
                                Read_data_1 = 32'h00000001;        // r-form rs
                                Read_data_2 = 32'h00000011;        // r-form rt
                                Imme_extend = 32'h00000004;  
                                Function_opcode = 6'b101010;      // SLT 2a
                                ALUOp = 2'b10;
                                Jr = 1'b0;
                                Shamt = 5'b00000;
                                Sftmd = 1'b0;
                                ALUSrc = 1'b0;
                                I_format = 1'b0;
                                PC_plus_4 = 32'h00000022;
                            end
                   i=i+1;
                              $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                              $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;    // SLT
                               Read_data_1 = 32'h00000011;        // r-form rs
                               Read_data_2 = 32'h00000001;        // r-form rt
                               Imme_extend = 32'h00000004;  
                               Function_opcode = 6'b101010;      // SLT 2a
                               ALUOp = 2'b10;
                               Shamt = 5'b00000;
                               Sftmd = 1'b0;
                               ALUSrc = 1'b0;
                               I_format = 1'b0;
                               PC_plus_4 = 32'h00000022;
                           end
                   i=i+1;
                             $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                             $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;    // SLT
                               Read_data_1 = 32'hffffffff;        // r-form rs
                               Read_data_2 = 32'h00000001;        // r-form rt
                               Imme_extend = 32'h00000004;  
                               Function_opcode = 6'b101010;      // SLT 2a
                               ALUOp = 2'b10;
                               Shamt = 5'b00000;
                               Sftmd = 1'b0;
                               ALUSrc = 1'b0;
                               I_format = 1'b0;
                               PC_plus_4 = 32'h00000022;
                           end
                   i=i+1;
                             $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                             $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);                        
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //and
                                  Read_data_1 = 32'h00ffff00;         //r-form rs
                                  Read_data_2 = 32'h0000ffff;         //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b100100;        //and 
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //
                                  Read_data_1 = 32'h00ffff00;         //r-form rs
                                  Read_data_2 = 32'h0000ffff;         //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b100101;        // or
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //
                                  Read_data_1 = 32'h00ffff00;         //r-form rs
                                  Read_data_2 = 32'h0000ffff;         //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b100110;        // xor
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //
                                  Read_data_1 = 32'h00ffff00;         //r-form rs
                                  Read_data_2 = 32'h0000ffff;         //r-form rt
                                  Imme_extend = 32'hffffff40;  
                                  Function_opcode = 6'b100111;        // nor
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          
                                  Read_data_1 = 32'h00000001;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100010;       //sub
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          
                                  Read_data_1 = 32'h0fffffff;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100010;        //sub
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //
                                  Read_data_1 = 32'hfffffff1;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100011;        // subu
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //
                                  Read_data_1 = 32'hffffffff;         //r-form rs
                                  Read_data_2 = 32'hffffffff;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100011;        // subu
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                  
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          
                                  Read_data_1 = 32'hfffffff0;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100001;       //addu
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          
                                  Read_data_1 = 32'hffffffff;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100001;        //addu
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //ADD
                                  Read_data_1 = 32'hfffffff0;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100000;        //and 
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);
                          /////////////////////////////////////////////////////////////////////////////////////////
                          #10 begin opcode = 6'b000000;          //ADD
                                  Read_data_1 = 32'hffffffff;         //r-form rs
                                  Read_data_2 = 32'h00000001;         //r-form rt
                                  Imme_extend = 32'h0f0f0f0f;  
                                  Function_opcode = 6'b100000;        //and 
                                  ALUOp = 2'b10;
                                  Shamt = 5'b00000;
                                  Sftmd = 1'b0;
                                  ALUSrc = 1'b0;
                                  I_format = 1'b0;
                                  PC_plus_4 = 32'h0000000c;
                              end 
                   i=i+1;
                                $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
                                $strobe($time,",%d %d %d",Zero,ALU_Result,Addr_Result);      
           #10 $finish;
         end
endmodule
