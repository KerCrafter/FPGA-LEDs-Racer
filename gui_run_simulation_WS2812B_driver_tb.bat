vsim -t 1ps -do "vlib work; vcom -93 -work work ./WS2812B_driver.vhd; vcom -93 -work work ./WS2812B_driver_tb.vhd; vsim WS2812B_driver_tb; vsim WS2812B_driver_tb; add wave *; view structure; view signals; run -all"