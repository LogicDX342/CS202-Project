`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/19/2023 09:55:16 PM
// Design Name:
// Module Name: Debonuce
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


module Debounce (
        clock,
        rst_n,
        key_in,
        key_out
    );
    parameter key_num = 4'd11;
    input clock;
    input rst_n;
    input [key_num-1:0] key_in;
    output reg [key_num-1:0] key_out = 11'b0;


    reg [key_num-1:0] key_pre = 11'b0;
    reg [key_num-1:0] key_cur = 11'b0;
    reg [7:0] cnt = 8'b0;
    wire [key_num-1:0] key_edge;

    always @(posedge clock)
    begin
        if (~rst_n)
        begin
            key_pre <= 11'b0;
            key_cur <= 11'b0;
        end
        else
        begin
            key_cur <= key_in;
            key_pre <= key_cur;
        end
    end
    assign key_edge = (key_cur & ~key_pre) | (~key_cur & key_pre);

    always @(posedge clock)
    begin
        if (~rst_n)
        begin
            cnt = 8'b0;
        end
        else if (key_edge || cnt == 8'd10)
        begin
            cnt = 8'b0;
        end
        else
        begin
            cnt = cnt + 1'b1;
        end
    end

    always @(posedge clock)
    begin
        if (~rst_n)
        begin
            key_out <= 12'b0;
        end
        else if (cnt == 8'd9)
        begin
            key_out <= key_in;
        end
    end
endmodule
