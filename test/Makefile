# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SIM ?= icarus
FST ?= -fst # Use more efficient FST format
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES += devices_entry/tt_um_kercrafter_leds_racer.v
PROJECT_SOURCES += LEDs_racer_main.v
PROJECT_SOURCES += LEDs_racer_core.v
PROJECT_SOURCES += activity_detector.v
PROJECT_SOURCES += display_unit.v
PROJECT_SOURCES += domain_unit.v
PROJECT_SOURCES += end_game_logics.v
PROJECT_SOURCES += menu_manager.v
PROJECT_SOURCES += player_button.v
PROJECT_SOURCES += screen_manager.v
PROJECT_SOURCES += button-debouncer/button_debouncer.v
PROJECT_SOURCES += WS2812B-driver/WS2812B_driver.v
PROJECT_SOURCES += WS2812B-driver/NRZ_sequence.v
PROJECT_SOURCES += WS2812B-driver/pipe_tri_bus.v
PROJECT_SOURCES += pipe-pulse-generator/pipe_pulse_generator.v
PROJECT_SOURCES += timer/timer.v
PROJECT_SOURCES += menu_manager/ready_trigger_countdown.v
PROJECT_SOURCES += screen_manager/router.v
PROJECT_SOURCES += screen_manager/screens/end_screen.v
PROJECT_SOURCES += screen_manager/screens/gameplay_screen.v
PROJECT_SOURCES += screen_manager/screens/menu_screen.v
PROJECT_SOURCES += screen_manager/screens.v
PROJECT_SOURCES += screen_manager/is_game_finished.v
PROJECT_SOURCES += screen_manager/is_game_started.v

ifneq ($(GATES),yes)

# RTL simulation:
SIM_BUILD				= sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

else

# Gate level simulation:
SIM_BUILD				= sim_build/gl
COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DUSE_POWER_PINS
COMPILE_ARGS    += -DSIM
COMPILE_ARGS    += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# Allow sharing configuration between design and testbench via `include`:
COMPILE_ARGS 		+= -I$(SRC_DIR)

# Include the testbench sources:
VERILOG_SOURCES += $(PWD)/tb.v
TOPLEVEL = tb

# List test modules to run, separated by commas and without the .py suffix:
COCOTB_TEST_MODULES = test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
