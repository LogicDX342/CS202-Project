module CPU_TOP_tb;

  // Parameters

  // Ports
  reg fpga_rst_in = 1;
  reg fpga_clk = 0;
  reg [15:0] switch2N4_in=0;
  wire [15:0] led2N4;
  reg start_pg_in = 0;
  wire btn_in = switch2N4_in[0];
  reg rx = 1;
  wire tx;
  wire hsync;
  wire vsync;
  wire [11:0] vga_rgb;

  CPU_TOP 
  CPU_TOP_dut (
    .fpga_rst_in (fpga_rst_in ),
    .fpga_clk (fpga_clk ),
    .switch2N4_in (switch2N4_in ),
    .led2N4 (led2N4 ),
    .start_pg_in (start_pg_in ),
    .btn_in (btn_in ),
    .rx (rx ),
    .tx (tx ),
    .hsync (hsync ),
    .vsync (vsync ),
    .vga_rgb  ( vga_rgb)
  );

  initial begin
    begin
      #1000
      fpga_rst_in = 0;
      #1000
      fpga_rst_in = 1;
      #100
      // start_pg_in=1;
      // #1000
      // start_pg_in=0;
      // #1000
      // fpga_rst_in=1;
      // #1000
      // fpga_rst_in=0;
      //0000_data(8)_mod(3)_conf(1)
      switch2N4_in=16'b0000_0010_0000_0000;
      #1000

      switch2N4_in=16'b0000_0010_0000_1111;
      #1000
      switch2N4_in=16'b0000_0000_0000_1110;
      #1000
      switch2N4_in=16'b0000_0000_0011_1111;
      #1000
      switch2N4_in=16'b0000_0000_0011_1110;
      #1000
      switch2N4_in=16'b0000_0010_0110_1111;
      #1000
      switch2N4_in=16'b0000_0010_0110_1110;
      #1000
      switch2N4_in=16'b0000_0000_0000_0101;
      #1000
      switch2N4_in=16'b0000_0000_0000_0100;
      #10000
      $finish;
    end
  end

  always
    #1  fpga_clk = ! fpga_clk ;

endmodule
