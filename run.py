from vunit import VUnit

# Create VUnit instance by parsing command line arguments
vu = VUnit.from_argv()

# Optionally add VUnit's builtin HDL utilities for checking, logging, communication...
# See http://vunit.github.io/hdl_libraries.html.
vu.add_vhdl_builtins()
# or
# vu.add_verilog_builtins()

# Create library 'lib'
lib = vu.add_library("lib")

# Add all files ending in .vhd in current working directory to library
lib.add_source_files( "./src/**/*.vhd" )

lib.add_source_files( "./vunit_tb/**/*.vhd" )

vu.set_sim_option("vhdl_assert_stop_level", "failure")

# Run vunit function
vu.main()
