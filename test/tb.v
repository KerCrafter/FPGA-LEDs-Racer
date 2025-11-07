`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb (
  output wire tp_update_frame,
  output wire tp_blue_ready_to_play,
  output wire tp_cur_screen,
  output wire tp_red_ready_to_play,
  output wire tp_green_ready_to_play,
  output wire tp_yellow_ready_to_play
);

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Replace tt_um_example with your module name:
  tt_um_kercrafter_leds_racer #(
    .MAX_POS(109),
    .DEBOUNCE_CLK_CNT(30),
    .MENU_TIMER_CLK_COUNT(10),
    .END_TIMER_CLK_COUNT(20)
  ) user_project (
      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );


  wire _unused = &{1'b0, ui_in[7:4], uio_in, ena};

  assign tp_cur_screen = uo_out[1] & uo_out[2];
  assign tp_update_frame = uo_out[7];
  assign tp_blue_ready_to_play = uo_out[3];
  assign tp_red_ready_to_play = uo_out[4];
  assign tp_green_ready_to_play = uo_out[5];
  assign tp_yellow_ready_to_play = uo_out[6];

endmodule
