project_new -family "Cyclone IV E" -overwrite LEDs-racer
set_global_assignment -name DEVICE EP4CE22F17C6

set_global_assignment -name TOP_LEVEL_ENTITY DE0_NANO_LEDs_racer_main

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

set_global_assignment -name VHDL_FILE src/devices_entry/DE0_NANO_LEDs_racer_main.vhd 
set_global_assignment -name VHDL_FILE src/LEDs_racer_main.vhd 
set_global_assignment -name VHDL_FILE src/LEDs_racer_core.vhd
set_global_assignment -name VHDL_FILE src/LEDs_racer_core.vhd
set_global_assignment -name VHDL_FILE src/activity_detector.vhd
set_global_assignment -name VHDL_FILE src/display_unit.vhd
set_global_assignment -name VHDL_FILE src/domain_unit.vhd
set_global_assignment -name VHDL_FILE src/end_game_logics.vhd
set_global_assignment -name VHDL_FILE src/menu_manager.vhd
set_global_assignment -name VHDL_FILE src/player_button.vhd
set_global_assignment -name VHDL_FILE src/players_commands_pkg.vhd
set_global_assignment -name VHDL_FILE src/screen_manager.vhd
set_global_assignment -name VHDL_FILE src/button-debouncer/button_debouncer.vhd
set_global_assignment -name VHDL_FILE src/WS2812B-driver/WS2812B_driver.vhd
set_global_assignment -name VHDL_FILE src/WS2812B-driver/NRZ_sequence.vhd
set_global_assignment -name VHDL_FILE src/WS2812B-driver/pipe_tri_bus.vhd
set_global_assignment -name VHDL_FILE src/pipe-pulse-generator/pipe_pulse_generator.vhd
set_global_assignment -name VHDL_FILE src/timer/timer.vhd
set_global_assignment -name VHDL_FILE src/menu_manager/ready_trigger_countdown.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/router.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/screens/end_screen.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/screens/gameplay_screen.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/screens/menu_screen.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/screens.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/is_game_finished.vhd
set_global_assignment -name VHDL_FILE src/screen_manager/is_game_started.vhd

set_location_assignment PIN_R8 -to clk
set_location_assignment PIN_T14 -to leds_line
set_location_assignment PIN_R14 -to yellow_input
set_location_assignment PIN_J16 -to red_input
set_location_assignment PIN_N12 -to green_input
set_location_assignment PIN_R13 -to blue_input

project_close
