`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module leds (
        input			ledrst,		// reset, active high (�?�?信�?�,高电平有效)
        input			led_clk,	// clk for led (时钟信�?�)
        input			ledwrite,	// led write enable, active high (写信�?�,高电平有效)
        input			ledcs,		// 1 means the leds are selected as output (从memorio�?�的，由低至高�?形�?的LED片选信�?�)
        // input	[1:0]	ledaddr,	// 2'b00 means updata the low 16bits of ledout, 2'b10 means updata the high 8 bits of ledout
        input	[15:0]	ledwdata,	// the data (from register/memorio)  waiting for to be writen to the leds of the board
        output	reg[15:0]	ledout		// the data writen to the leds  of the board
    );


    always @ (posedge led_clk or posedge ledrst)
    begin
        if (~ledrst)
            ledout <= 16'h000000;
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        else if (ledcs && ledwrite)
        begin
            ledout <= ledwdata;
        end
        else
        begin
            ledout <= ledout;
        end
    end

endmodule
