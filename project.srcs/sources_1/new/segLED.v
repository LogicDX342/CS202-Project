`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/30/2023 08:28:20 AM
// Design Name:
// Module Name: seg0LED
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


module segLED (
        input             clk,
        input             rst_n,
        input      [15:0] inputA,
        input      [15:0] inputB,
        output reg [ 7:0] seg0,
        output reg [ 7:0] seg1,
        output reg [ 7:0] an
    );
    reg[15:0] divclk_cnt = 0;
    reg divclk = 0;
    always@(posedge clk)
    begin
        if(divclk_cnt==16'd5000)
        begin
            divclk=~divclk;
            divclk_cnt=0;
        end
        else
        begin
            divclk_cnt=divclk_cnt+1'b1;
        end
    end

    reg [3:0] a_1;
    reg [3:0] b_1;
    reg [3:0] c_1;
    reg [3:0] d_1;
    reg [3:0] a_2;
    reg [3:0] b_2;
    reg [3:0] c_2;
    reg [3:0] d_2;

    integer i;
    always @(inputA, inputB)
    begin
        a_1 = 4'b0;
        b_1 = 4'b0;
        c_1 = 4'b0;
        d_1 = 4'b0;
        a_2 = 4'b0;
        b_2 = 4'b0;
        c_2 = 4'b0;
        d_2 = 4'b0;
        for (i = 0; i < 16; i = i + 1)
        begin
            if (4'd5 <= a_1)
                a_1 = a_1 + 4'd3;
            if (4'd5 <= b_1)
                b_1 = b_1 + 4'd3;
            if (4'd5 <= c_1)
                c_1 = c_1 + 4'd3;
            if (4'd5 <= d_1)
                d_1 = d_1 + 4'd3;
            d_1 = {d_1[2:0], c_1[3]};
            c_1 = {c_1[2:0], b_1[3]};
            b_1 = {b_1[2:0], a_1[3]};
            a_1 = {a_1[2:0], inputA[15-i]};

            if (4'd5 <= a_2)
                a_2 = a_2 + 4'd3;
            if (4'd5 <= b_2)
                b_2 = b_2 + 4'd3;
            if (4'd5 <= c_2)
                c_2 = c_2 + 4'd3;
            if (4'd5 <= d_2)
                d_2 = d_2 + 4'd3;
            d_2 = {d_2[2:0], c_2[3]};
            c_2 = {c_2[2:0], b_2[3]};
            b_2 = {b_2[2:0], a_2[3]};
            a_2 = {a_2[2:0], inputB[15-i]};

        end
    end



    reg [3:0] digit_cnt = 3'b0;
    reg [7:0] data = 8'b0;


    always @(posedge divclk)
    begin
        if (digit_cnt >= 3'b111)
            digit_cnt = 0;
        else
            digit_cnt = digit_cnt + 1'b1;
        case (digit_cnt)
            3'b000:
            begin
                an   = 8'h01;
                data = a_1;
            end
            3'b001:
            begin
                an   = 8'h02;
                data = b_1;
            end
            3'b010:
            begin
                an   = 8'h04;
                data = c_1;
            end
            3'b011:
            begin
                an   = 8'h08;
                data = d_1;
            end
            3'b100:
            begin
                an   = 8'h10;
                data = a_2;
            end
            3'b101:
            begin
                an   = 8'h20;
                data = b_2;
            end
            3'b110:
            begin
                an   = 8'h40;
                data = c_2;
            end
            3'b111:
            begin
                an   = 8'h80;
                data = d_2;
            end
            default:
            begin
                an   = 0;
                data = 0;
            end
        endcase
    end

    always @(*)
    begin
        if (~rst_n)
        begin
            seg0 = 8'h02;
            seg1 = 8'h02;
        end
        else
        begin
            if (an > 8'h08)
            begin
                case (data)
                    4'h0:
                        seg0 = 8'hfc;
                    4'h1:
                        seg0 = 8'h60;
                    4'h2:
                        seg0 = 8'hda;
                    4'h3:
                        seg0 = 8'hf2;
                    4'h4:
                        seg0 = 8'h66;
                    4'h5:
                        seg0 = 8'hb6;
                    4'h6:
                        seg0 = 8'hbe;
                    4'h7:
                        seg0 = 8'he0;
                    4'h8:
                        seg0 = 8'hfe;
                    4'h9:
                        seg0 = 8'hf6;
                    default:
                        seg0 = 8'h02;
                endcase
            end
            else
            begin

                case (data)
                    4'h0:
                        seg1 = 8'hfc;
                    4'h1:
                        seg1 = 8'h60;
                    4'h2:
                        seg1 = 8'hda;
                    4'h3:
                        seg1 = 8'hf2;
                    4'h4:
                        seg1 = 8'h66;
                    4'h5:
                        seg1 = 8'hb6;
                    4'h6:
                        seg1 = 8'hbe;
                    4'h7:
                        seg1 = 8'he0;
                    4'h8:
                        seg1 = 8'hfe;
                    4'h9:
                        seg1 = 8'hf6;
                    default:
                        seg1 = 8'h02;
                endcase
            end


        end
    end
endmodule
