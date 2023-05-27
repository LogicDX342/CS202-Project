`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/01/05 21:42:46
// Design Name:
// Module Name: vga_ctrl
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


module vga_pic (
    input wire       vga_clk,
    input wire       sys_rst_n,
    input wire [9:0] pix_x,
    input wire [9:0] pix_y,
    input wire [7:0] input_a,
    input wire [7:0] input_b,
    input wire [7:0] output_a,

    output reg [11:0] pix_data
);

    parameter H_VALID = 10'd640, V_VALID = 10'D480;

    parameter RED = 12'hF10, ORANGE = 12'hFC0, YELLOW = 12'hFFE, GREEN = 12'h07E, CYAN = 12'h07F,
        BLUE = 12'hFFF, PURPPLE = 12'hF81, BLACK = 12'h000, WHITE = 12'hFFF, GRAY = 12'hD69;

        
    parameter HEIGHT = 10'd16, WIDTH = 10'd7;

    parameter POS_X_1 = 10'd100, POS_Y_1 = 10'd100, WIDTH_1 = 10'd32;
    wire [9:0] x_cnt_1;
    wire [9:0] y_cnt_1;
    assign x_cnt_1 = pix_x - POS_X_1;
    assign y_cnt_1 = pix_y - POS_Y_1;

    parameter POS_X_1_1 = POS_X_1 + 10'd8;
    wire [9:0] x_cnt_1_1;
    wire [9:0] y_cnt_1_1;
    assign x_cnt_1_1 = pix_x - POS_X_1_1;
    assign y_cnt_1_1 = pix_y - POS_Y_1;

    parameter POS_X_1_2 = POS_X_1 + 10'd16;
    wire [9:0] x_cnt_1_2;
    wire [9:0] y_cnt_1_2;
    assign x_cnt_1_2 = pix_x - POS_X_1_2;
    assign y_cnt_1_2 = pix_y - POS_Y_1;

    parameter POS_X_1_3 = POS_X_1 + 10'd24;
    wire [9:0] x_cnt_1_3;
    wire [9:0] y_cnt_1_3;
    assign x_cnt_1_3 = pix_x - POS_X_1_3;
    assign y_cnt_1_3 = pix_y - POS_Y_1;

    reg [WIDTH_1-1:0] char_1[15:0];


    
    parameter POS_X_2 = 10'd100, POS_Y_2 = 10'd200, WIDTH_2 = 10'd56;
    wire [9:0] x_cnt_2;
    wire [9:0] y_cnt_2;
    assign x_cnt_2 = pix_x - POS_X_2;
    assign y_cnt_2 = pix_y - POS_Y_2;

    parameter POS_X_2_1 = POS_X_2 + 10'd8;
    wire [9:0] x_cnt_2_1;
    wire [9:0] y_cnt_2_1;
    assign x_cnt_2_1 = pix_x - POS_X_2_1;
    assign y_cnt_2_1 = pix_y - POS_Y_2;

    parameter POS_X_2_2 = POS_X_2 + 10'd16;
    wire [9:0] x_cnt_2_2;
    wire [9:0] y_cnt_2_2;
    assign x_cnt_2_2 = pix_x - POS_X_2_2;
    assign y_cnt_2_2 = pix_y - POS_Y_2;

    parameter POS_X_2_3 = POS_X_2 + 10'd24;
    wire [9:0] x_cnt_2_3;
    wire [9:0] y_cnt_2_3;
    assign x_cnt_2_3 = pix_x - POS_X_2_3;
    assign y_cnt_2_3 = pix_y - POS_Y_2;

    parameter POS_X_2_4 = POS_X_2 + 10'd32;
    wire [9:0] x_cnt_2_4;
    wire [9:0] y_cnt_2_4;
    assign x_cnt_2_4 = pix_x - POS_X_2_4;
    assign y_cnt_2_4 = pix_y - POS_Y_2;

    parameter POS_X_2_5 = POS_X_2 + 10'd40;
    wire [9:0] x_cnt_2_5;
    wire [9:0] y_cnt_2_5;
    assign x_cnt_2_5 = pix_x - POS_X_2_5;
    assign y_cnt_2_5 = pix_y - POS_Y_2;

    parameter POS_X_2_6 = POS_X_2 + 10'd48;
    wire [9:0] x_cnt_2_6;
    wire [9:0] y_cnt_2_6;
    assign x_cnt_2_6 = pix_x - POS_X_2_6;
    assign y_cnt_2_6 = pix_y - POS_Y_2;

    parameter POS_X_2_7 = POS_X_2 + 10'd56;
    wire [9:0] x_cnt_2_7;
    wire [9:0] y_cnt_2_7;
    assign x_cnt_2_7 = pix_x - POS_X_2_7;
    assign y_cnt_2_7 = pix_y - POS_Y_2;

    parameter POS_X_2_8 = POS_X_2 + 10'd64;
    wire [9:0] x_cnt_2_8;
    wire [9:0] y_cnt_2_8;
    assign x_cnt_2_8 = pix_x - POS_X_2_8;
    assign y_cnt_2_8 = pix_y - POS_Y_2;

    reg [WIDTH_2-1:0] char_2[15:0];



    parameter POS_X_3 = 10'd100, POS_Y_3 = 10'd300, WIDTH_3 = 10'd56;
    wire [9:0] x_cnt_3;
    wire [9:0] y_cnt_3;
    assign x_cnt_3 = pix_x - POS_X_3;
    assign y_cnt_3 = pix_y - POS_Y_3;

    // wire [3:0] mile_thousand;
    // assign mile_thousand = miles_bin / 16'd1000;
    // wire [3:0] mile_hundreds;
    // assign mile_hundreds = (miles_bin % 16'd1000) / 16'd100;
    // wire [3:0] mile_tens;
    // assign mile_tens = (miles_bin % 16'd100) / 16'd10;
    // wire [3:0] mile_units;
    // assign mile_units = miles_bin % 10;

    parameter POS_X_3_1 = POS_X_3 + 10'd8;
    wire [9:0] x_cnt_3_1;
    wire [9:0] y_cnt_3_1;
    assign x_cnt_3_1 = pix_x - POS_X_3_1;
    assign y_cnt_3_1 = pix_y - POS_Y_3;

    parameter POS_X_3_2 = POS_X_3 + 10'd16;
    wire [9:0] x_cnt_3_2;
    wire [9:0] y_cnt_3_2;
    assign x_cnt_3_2 = pix_x - POS_X_3_2;
    assign y_cnt_3_2 = pix_y - POS_Y_3;

    parameter POS_X_3_3 = POS_X_3 + 10'd24;
    wire [9:0] x_cnt_3_3;
    wire [9:0] y_cnt_3_3;
    assign x_cnt_3_3 = pix_x - POS_X_3_3;
    assign y_cnt_3_3 = pix_y - POS_Y_3;

    parameter POS_X_3_4 = POS_X_3 + 10'd32;
    wire [9:0] x_cnt_3_4;
    wire [9:0] y_cnt_3_4;
    assign x_cnt_3_4 = pix_x - POS_X_3_4;
    assign y_cnt_3_4 = pix_y - POS_Y_3;

    parameter POS_X_3_5 = POS_X_3 + 10'd40;
    wire [9:0] x_cnt_3_5;
    wire [9:0] y_cnt_3_5;
    assign x_cnt_3_5 = pix_x - POS_X_3_5;
    assign y_cnt_3_5 = pix_y - POS_Y_3;

    parameter POS_X_3_6 = POS_X_3 + 10'd48;
    wire [9:0] x_cnt_3_6;
    wire [9:0] y_cnt_3_6;
    assign x_cnt_3_6 = pix_x - POS_X_3_6;
    assign y_cnt_3_6 = pix_y - POS_Y_3;

    parameter POS_X_3_7 = POS_X_3 + 10'd56;
    wire [9:0] x_cnt_3_7;
    wire [9:0] y_cnt_3_7;
    assign x_cnt_3_7 = pix_x - POS_X_3_7;
    assign y_cnt_3_7 = pix_y - POS_Y_3;

    parameter POS_X_3_8 = POS_X_3 + 10'd64;
    wire [9:0] x_cnt_3_8;
    wire [9:0] y_cnt_3_8;
    assign x_cnt_3_8 = pix_x - POS_X_3_8;
    assign y_cnt_3_8 = pix_y - POS_Y_3;

    reg [WIDTH_3-1:0] char_3[15:0];



    reg [WIDTH-1:0] num_0[15:0];
    reg [WIDTH-1:0] num_1[15:0];
    // reg [WIDTH-1:0] num_2[15:0];
    // reg [WIDTH-1:0] num_3[15:0];
    // reg [WIDTH-1:0] num_4[15:0];
    // reg [WIDTH-1:0] num_5[15:0];
    // reg [WIDTH-1:0] num_6[15:0];
    // reg [WIDTH-1:0] num_7[15:0];
    // reg [WIDTH-1:0] num_8[15:0];
    // reg [WIDTH-1:0] num_9[15:0];


    always @(posedge vga_clk) begin

        char_1[0]  <= 64'h00000000;  //mod:
        char_1[1]  <= 64'h00000000;
        char_1[2]  <= 64'h00000000;
        char_1[3]  <= 64'h00000000;
        char_1[4]  <= 64'h00000600;
        char_1[5]  <= 64'h00000200;
        char_1[6]  <= 64'h00000218;
        char_1[7]  <= 64'hFE3C3E18;
        char_1[8]  <= 64'h49424200;
        char_1[9]  <= 64'h49424200;
        char_1[10] <= 64'h49424200;
        char_1[11] <= 64'h49424200;
        char_1[12] <= 64'h49424618;
        char_1[13] <= 64'hED3C3B18;
        char_1[14] <= 64'h00000000;
        char_1[15] <= 64'h00000000;

        char_2[0]  <= 56'h00000000000000;  //InputA:
        char_2[1]  <= 56'h00000000000000;
        char_2[2]  <= 56'h00000000000000;
        char_2[3]  <= 56'h7C000000001000;
        char_2[4]  <= 56'h10000000001000;
        char_2[5]  <= 56'h10000000101800;
        char_2[6]  <= 56'h10000000102818;
        char_2[7]  <= 56'h10DCD8C67C2818;
        char_2[8]  <= 56'h10626442102400;
        char_2[9]  <= 56'h10424242103C00;
        char_2[10] <= 56'h10424242104400;
        char_2[11] <= 56'h10424242104200;
        char_2[12] <= 56'h10426446124218;
        char_2[13] <= 56'h7CE7583B0CE718;
        char_2[14] <= 56'h00004000000000;
        char_2[15] <= 56'h0000E000000000;

        char_3[0]  <= 56'h00000000000000;  //InputB:
        char_3[1]  <= 56'h00000000000000;
        char_3[2]  <= 56'h00000000000000;
        char_3[3]  <= 56'h7C00000000F800;
        char_3[4]  <= 56'h10000000004400;
        char_3[5]  <= 56'h10000000104400;
        char_3[6]  <= 56'h10000000104418;
        char_3[7]  <= 56'h10DCD8C67C7818;
        char_3[8]  <= 56'h10626442104400;
        char_3[9]  <= 56'h10424242104200;
        char_3[10] <= 56'h10424242104200;
        char_3[11] <= 56'h10424242104200;
        char_3[12] <= 56'h10426446124418;
        char_3[13] <= 56'h7CE7583B0CF818;
        char_3[14] <= 56'h00004000000000;
        char_3[15] <= 56'h0000E000000000;

        num_0[0]   <= 8'h00;
        num_0[1]   <= 8'h00;
        num_0[2]   <= 8'h00;
        num_0[3]   <= 8'h18;
        num_0[4]   <= 8'h24;
        num_0[5]   <= 8'h42;
        num_0[6]   <= 8'h42;
        num_0[7]   <= 8'h42;
        num_0[8]   <= 8'h42;
        num_0[9]   <= 8'h42;
        num_0[10]  <= 8'h42;
        num_0[11]  <= 8'h42;
        num_0[12]  <= 8'h24;
        num_0[13]  <= 8'h18;
        num_0[14]  <= 8'h00;
        num_0[15]  <= 8'h00;

        num_1[0]   <= 8'h00;
        num_1[1]   <= 8'h00;
        num_1[2]   <= 8'h00;
        num_1[3]   <= 8'h08;
        num_1[4]   <= 8'h38;
        num_1[5]   <= 8'h08;
        num_1[6]   <= 8'h08;
        num_1[7]   <= 8'h08;
        num_1[8]   <= 8'h08;
        num_1[9]   <= 8'h08;
        num_1[10]  <= 8'h08;
        num_1[11]  <= 8'h08;
        num_1[12]  <= 8'h08;
        num_1[13]  <= 8'h3E;
        num_1[14]  <= 8'h00;
        num_1[15]  <= 8'h00;

        // num_2[0]   <= 8'h00;
        // num_2[1]   <= 8'h00;
        // num_2[2]   <= 8'h00;
        // num_2[3]   <= 8'h3C;
        // num_2[4]   <= 8'h42;
        // num_2[5]   <= 8'h42;
        // num_2[6]   <= 8'h42;
        // num_2[7]   <= 8'h02;
        // num_2[8]   <= 8'h04;
        // num_2[9]   <= 8'h08;
        // num_2[10]  <= 8'h10;
        // num_2[11]  <= 8'h20;
        // num_2[12]  <= 8'h42;
        // num_2[13]  <= 8'h7E;
        // num_2[14]  <= 8'h00;
        // num_2[15]  <= 8'h00;

        // num_3[0]   <= 8'h00;
        // num_3[1]   <= 8'h00;
        // num_3[2]   <= 8'h00;
        // num_3[3]   <= 8'h3C;
        // num_3[4]   <= 8'h42;
        // num_3[5]   <= 8'h42;
        // num_3[6]   <= 8'h02;
        // num_3[7]   <= 8'h04;
        // num_3[8]   <= 8'h18;
        // num_3[9]   <= 8'h04;
        // num_3[10]  <= 8'h02;
        // num_3[11]  <= 8'h42;
        // num_3[12]  <= 8'h42;
        // num_3[13]  <= 8'h3C;
        // num_3[14]  <= 8'h00;
        // num_3[15]  <= 8'h00;

        // num_4[0]   <= 8'h00;
        // num_4[1]   <= 8'h00;
        // num_4[2]   <= 8'h00;
        // num_4[3]   <= 8'h04;
        // num_4[4]   <= 8'h0C;
        // num_4[5]   <= 8'h0C;
        // num_4[6]   <= 8'h14;
        // num_4[7]   <= 8'h24;
        // num_4[8]   <= 8'h24;
        // num_4[9]   <= 8'h44;
        // num_4[10]  <= 8'h7E;
        // num_4[11]  <= 8'h04;
        // num_4[12]  <= 8'h04;
        // num_4[13]  <= 8'h1E;
        // num_4[14]  <= 8'h00;
        // num_4[15]  <= 8'h00;

        // num_5[0]   <= 8'h00;
        // num_5[1]   <= 8'h00;
        // num_5[2]   <= 8'h00;
        // num_5[3]   <= 8'h7E;
        // num_5[4]   <= 8'h40;
        // num_5[5]   <= 8'h40;
        // num_5[6]   <= 8'h40;
        // num_5[7]   <= 8'h78;
        // num_5[8]   <= 8'h44;
        // num_5[9]   <= 8'h02;
        // num_5[10]  <= 8'h02;
        // num_5[11]  <= 8'h42;
        // num_5[12]  <= 8'h44;
        // num_5[13]  <= 8'h38;
        // num_5[14]  <= 8'h00;
        // num_5[15]  <= 8'h00;

        // num_6[0]   <= 8'h00;
        // num_6[1]   <= 8'h00;
        // num_6[2]   <= 8'h00;
        // num_6[3]   <= 8'h18;
        // num_6[4]   <= 8'h24;
        // num_6[5]   <= 8'h40;
        // num_6[6]   <= 8'h40;
        // num_6[7]   <= 8'h5C;
        // num_6[8]   <= 8'h62;
        // num_6[9]   <= 8'h42;
        // num_6[10]  <= 8'h42;
        // num_6[11]  <= 8'h42;
        // num_6[12]  <= 8'h22;
        // num_6[13]  <= 8'h1C;
        // num_6[14]  <= 8'h00;
        // num_6[15]  <= 8'h00;

        // num_7[0]   <= 8'h00;
        // num_7[1]   <= 8'h00;
        // num_7[2]   <= 8'h00;
        // num_7[3]   <= 8'h7E;
        // num_7[4]   <= 8'h42;
        // num_7[5]   <= 8'h04;
        // num_7[6]   <= 8'h04;
        // num_7[7]   <= 8'h08;
        // num_7[8]   <= 8'h08;
        // num_7[9]   <= 8'h10;
        // num_7[10]  <= 8'h10;
        // num_7[11]  <= 8'h10;
        // num_7[12]  <= 8'h10;
        // num_7[13]  <= 8'h10;
        // num_7[14]  <= 8'h00;
        // num_7[15]  <= 8'h00;

        // num_8[0]   <= 8'h00;
        // num_8[1]   <= 8'h00;
        // num_8[2]   <= 8'h00;
        // num_8[3]   <= 8'h3C;
        // num_8[4]   <= 8'h42;
        // num_8[5]   <= 8'h42;
        // num_8[6]   <= 8'h42;
        // num_8[7]   <= 8'h24;
        // num_8[8]   <= 8'h18;
        // num_8[9]   <= 8'h24;
        // num_8[10]  <= 8'h42;
        // num_8[11]  <= 8'h42;
        // num_8[12]  <= 8'h42;
        // num_8[13]  <= 8'h3C;
        // num_8[14]  <= 8'h00;
        // num_8[15]  <= 8'h00;

        // num_9[0]   <= 8'h00;
        // num_9[1]   <= 8'h00;
        // num_9[2]   <= 8'h00;
        // num_9[3]   <= 8'h38;
        // num_9[4]   <= 8'h44;
        // num_9[5]   <= 8'h42;
        // num_9[6]   <= 8'h42;
        // num_9[7]   <= 8'h42;
        // num_9[8]   <= 8'h46;
        // num_9[9]   <= 8'h3A;
        // num_9[10]  <= 8'h02;
        // num_9[11]  <= 8'h02;
        // num_9[12]  <= 8'h24;
        // num_9[13]  <= 8'h18;
        // num_9[14]  <= 8'h00;
        // num_9[15]  <= 8'h00;
    end

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (sys_rst_n == 1'b0) begin
            pix_data <= BLACK;
        end else begin
            if ((pix_x >= POS_X_1) && (pix_x < POS_X_1 + WIDTH_1) && (pix_y >= POS_Y_1) &&
                (pix_y < POS_Y_1 + HEIGHT)) begin
                if (char_1[y_cnt_1][10'd47-x_cnt_1]) pix_data <= GRAY;
                else pix_data <= BLUE;
            end
            if ((pix_x >= POS_X_1_1) && (pix_x < POS_X_1_1 + WIDTH) && (pix_y >= POS_Y_1) &&
                (pix_y < POS_Y_1 + HEIGHT)) begin  
                case (input_a[2])
                    16'd0:
                    if (num_0[y_cnt_1_1][10'd7-x_cnt_1_1]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_1_1][10'd7-x_cnt_1_1]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_1_2) && (pix_x < POS_X_1_2 + WIDTH) && (pix_y >= POS_Y_1) &&
                (pix_y < POS_Y_1 + HEIGHT)) begin  
                case (input_a[1])
                    16'd0:
                    if (num_0[y_cnt_1_2][10'd7-x_cnt_1_2]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_1_2][10'd7-x_cnt_1_2]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end  
            if ((pix_x >= POS_X_1_3) && (pix_x < POS_X_1_3 + WIDTH) && (pix_y >= POS_Y_1) &&
                (pix_y < POS_Y_1 + HEIGHT)) begin  
                case (input_a[0])
                    16'd0:
                    if (num_0[y_cnt_1_3][10'd7-x_cnt_1_3]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_1_3][10'd7-x_cnt_1_3]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2) && (pix_x < POS_X_2 + WIDTH_2) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin
                if (char_2[y_cnt_2][10'd47-x_cnt_2]) pix_data <= GRAY;
                else pix_data <= BLUE;
            end
            if ((pix_x >= POS_X_2_1) && (pix_x < POS_X_2_1 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[7])
                    16'd0:
                    if (num_0[y_cnt_2_1][10'd7-x_cnt_2_1]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_1][10'd7-x_cnt_2_1]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2_2) && (pix_x < POS_X_2_2 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[6])
                    16'd0:
                    if (num_0[y_cnt_2_2][10'd7-x_cnt_2_2]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_2][10'd7-x_cnt_2_2]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end  
            if ((pix_x >= POS_X_2_3) && (pix_x < POS_X_2_3 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[5])
                    16'd0:
                    if (num_0[y_cnt_2_3][10'd7-x_cnt_2_3]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_3][10'd7-x_cnt_2_3]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2_4) && (pix_x < POS_X_2_4 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[4])
                    16'd0:
                    if (num_0[y_cnt_2_4][10'd7-x_cnt_2_4]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_4][10'd7-x_cnt_2_4]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2_5) && (pix_x < POS_X_2_5 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[3])
                    16'd0:
                    if (num_0[y_cnt_2_5][10'd7-x_cnt_2_5]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_5][10'd7-x_cnt_2_5]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2_6) && (pix_x < POS_X_2_6 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[2])
                    16'd0:
                    if (num_0[y_cnt_2_6][10'd7-x_cnt_2_6]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_6][10'd7-x_cnt_2_6]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2_7) && (pix_x < POS_X_2_7 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[1])
                    16'd0:
                    if (num_0[y_cnt_2_7][10'd7-x_cnt_2_7]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_7][10'd7-x_cnt_2_7]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_2_8) && (pix_x < POS_X_2_8 + WIDTH) && (pix_y >= POS_Y_2) &&
                (pix_y < POS_Y_2 + HEIGHT)) begin  
                case (input_b[0])
                    16'd0:
                    if (num_0[y_cnt_2_8][10'd7-x_cnt_2_8]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_2_8][10'd7-x_cnt_2_8]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            

            if ((pix_x >= POS_X_3) && (pix_x < POS_X_3 + WIDTH_3) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin
                if (char_3[y_cnt_3][10'd47-x_cnt_3]) pix_data <= GRAY;
                else pix_data <= BLUE;
            end
            if ((pix_x >= POS_X_3_1) && (pix_x < POS_X_3_1 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[7])
                    16'd0:
                    if (num_0[y_cnt_3_1][10'd7-x_cnt_3_1]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_1][10'd7-x_cnt_3_1]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_3_2) && (pix_x < POS_X_3_2 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[6])
                    16'd0:
                    if (num_0[y_cnt_3_2][10'd7-x_cnt_3_2]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_2][10'd7-x_cnt_3_2]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end  
            if ((pix_x >= POS_X_3_3) && (pix_x < POS_X_3_3 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[5])
                    16'd0:
                    if (num_0[y_cnt_3_3][10'd7-x_cnt_3_3]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_3][10'd7-x_cnt_3_3]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_3_4) && (pix_x < POS_X_3_4 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[4])
                    16'd0:
                    if (num_0[y_cnt_3_4][10'd7-x_cnt_3_4]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_4][10'd7-x_cnt_3_4]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_3_5) && (pix_x < POS_X_3_5 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[3])
                    16'd0:
                    if (num_0[y_cnt_3_5][10'd7-x_cnt_3_5]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_5][10'd7-x_cnt_3_5]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_3_6) && (pix_x < POS_X_3_6 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[2])
                    16'd0:
                    if (num_0[y_cnt_3_6][10'd7-x_cnt_3_6]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_6][10'd7-x_cnt_3_6]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_3_7) && (pix_x < POS_X_3_7 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[1])
                    16'd0:
                    if (num_0[y_cnt_3_7][10'd7-x_cnt_3_7]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_7][10'd7-x_cnt_3_7]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
            if ((pix_x >= POS_X_3_8) && (pix_x < POS_X_3_8 + WIDTH) && (pix_y >= POS_Y_3) &&
                (pix_y < POS_Y_3 + HEIGHT)) begin  
                case (output_a[0])
                    16'd0:
                    if (num_0[y_cnt_3_8][10'd7-x_cnt_3_8]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    16'd1:
                    if (num_1[y_cnt_3_8][10'd7-x_cnt_3_8]) pix_data <= GRAY;
                    else pix_data <= BLUE;
                    default: pix_data <= BLUE;
                endcase
            end
        end
    end
endmodule
