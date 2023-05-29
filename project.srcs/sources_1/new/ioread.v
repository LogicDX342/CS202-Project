`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module ioread (
        input			reset,				// reset, active high �?�?信�?� (高电平有效)
        input			ior,				// from Controller, 1 means read from input device(从控制器�?�的I/O读)
        input			switchctrl,			// means the switch is selected as input device (从memorio�?过地�?�高端线获得的拨�?开关模�?�片选)
        input	[15:0]	ioread_data_switch,	// the data from switch(从外设�?�的读数�?�，此处�?�自拨�?开关)
        output	reg[15:0]	ioread_data 		// the data to memorio (将外设�?�的数�?��?给memorio)
    );

    always @*
    begin
        if (~reset)
            ioread_data = 16'h0;
        else if (ior == 1)
        begin
            if (switchctrl == 1)
                ioread_data = ioread_data_switch;
            else
                ioread_data = ioread_data;
        end
        else
        begin
            ioread_data = ioread_data;
        end
    end

endmodule
