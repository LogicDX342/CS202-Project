`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2023 11:21:12 AM
// Design Name: 
// Module Name: cache_tb
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


module x_core_info_tb;

    // Parameters

    // Ports
    reg clka = 0;
    reg  wea = 0;
    reg [13:0] addra = 0;
    reg [31:0] dina = 0;
    wire [31:0] douta;

    RAM x_core_info_dut (
        .clka (clka),
        .wea  (wea),
        .addra(addra),
        .dina (dina),
        .douta(douta)
    );

    // initial begin
    //   begin
    //     #4
    //     addra = 14'h0000;
    //     dina = 32'h00000011;
    //     wea = 0;
    //     #10;
    //     addra = 14'h0001;
    //     dina = 32'h00000f01;
    //     wea = 1;
    //     #10;
    //     addra = 14'h0002;
    //     dina = 32'h00000000;
    //     wea = 0;
    //     #10;
    //     addra = 14'h0001;
    //     dina = 32'h00000000;
    //     wea = 0;
    //     #10;
    //     $finish;
    //   end
    // end
    always @(posedge clka) begin
        dina <= dina + 1'b1;
    end
    always @(posedge clka) begin
        addra <= addra + 1'b1;
    end

    always #5 clka = !clka;

    initial begin
        wea = 1'b0;
        #14
        wea = 1'b1;
        #9
        wea = 1'b0;
        #11
        wea = 1'b1;
        #9
        wea = 1'b0;
        #11
         $finish;
    end

endmodule

