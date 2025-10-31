project_new -family "Cyclone IV E" -overwrite LEDs-racer-verilog
set_global_assignment -name DEVICE EP4CE22F17C6

set_global_assignment -name TOP_LEVEL_ENTITY DE0_NANO_LEDs_racer_main

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

set_global_assignment -name VERILOG_FILE src/devices_entry/DE0_NANO_LEDs_racer_main.v 
set_global_assignment -name VERILOG_FILE src/LEDs_racer_main.v 
set_global_assignment -name VERILOG_FILE src/LEDs_racer_core.v
set_global_assignment -name VERILOG_FILE src/LEDs_racer_core.v
set_global_assignment -name VERILOG_FILE src/activity_detector.v
set_global_assignment -name VERILOG_FILE src/display_unit.v
set_global_assignment -name VERILOG_FILE src/domain_unit.v
set_global_assignment -name VERILOG_FILE src/end_game_logics.v
set_global_assignment -name VERILOG_FILE src/menu_manager.v
set_global_assignment -name VERILOG_FILE src/player_button.v
set_global_assignment -name VERILOG_FILE src/screen_manager.v
set_global_assignment -name VERILOG_FILE src/button-debouncer/button_debouncer.v
set_global_assignment -name VERILOG_FILE src/WS2812B-driver/WS2812B_driver.v
set_global_assignment -name VERILOG_FILE src/WS2812B-driver/NRZ_sequence.v
set_global_assignment -name VERILOG_FILE src/WS2812B-driver/pipe_tri_bus.v
set_global_assignment -name VERILOG_FILE src/pipe-pulse-generator/pipe_pulse_generator.v
set_global_assignment -name VERILOG_FILE src/timer/timer.v
set_global_assignment -name VERILOG_FILE src/menu_manager/ready_trigger_countdown.v
set_global_assignment -name VERILOG_FILE src/screen_manager/router.v
set_global_assignment -name VERILOG_FILE src/screen_manager/screens/end_screen.v
set_global_assignment -name VERILOG_FILE src/screen_manager/screens/gameplay_screen.v
set_global_assignment -name VERILOG_FILE src/screen_manager/screens/menu_screen.v
set_global_assignment -name VERILOG_FILE src/screen_manager/screens.v
set_global_assignment -name VERILOG_FILE src/screen_manager/is_game_finished.v
set_global_assignment -name VERILOG_FILE src/screen_manager/is_game_started.v

set_location_assignment PIN_R8 -to clk
set_location_assignment PIN_T14 -to leds_line
set_location_assignment PIN_R14 -to yellow_input
set_location_assignment PIN_J16 -to red_input
set_location_assignment PIN_N12 -to green_input
set_location_assignment PIN_R13 -to blue_input

project_close
