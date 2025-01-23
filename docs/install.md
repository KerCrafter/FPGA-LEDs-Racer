# Install

## Clone this repository and submodules

run `git clone --recurse-submodules https://github.com/KerCrafter/FPGA-LEDs-Racer.git`

## Create Quartus Project

From this project repository we ignore Quartus Project files. we includes only sources files.

You need open Quartus IDE and go to `File > New Project Wizard...` 

### Directory, Name, Top-Level Entity

**Directory:** select the folder where you have cloned the project
**Name:** name the project as you wish, personally I put `LEDs-racer`
**Top-Level Entity:** put `DE0_NANO_LEDs_racer_main`

### Project Type

select `Empty project`

### Add Files

click to the `...` button, and add each `.vhd` files, except `*_tb.vhd` dedicated to the simulation.

### Family, Device & Board Settings

**Family:** Cyclone IV E

In `Available devices` search the model `EP4CE22F17C6` (as a precaution, check the reference on your DE0 Nano's chip)


And press on Finish, congratulations the project is ready
