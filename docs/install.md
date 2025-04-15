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

## Mapping inputs/outputs

From Pin Planner tool you can specify the matching pins for DE0_nano

| Node Name | Direction | Location |
| - | - | - |
| clk | input | PIN_R8 |
| green_input | input | PIN_T13 |
| red_input | input | PIN_T15 |
| blue_input | input | PIN_T12 |
| yellow_input | input | PIN_T14 |
| leds_line | output | PIN_D3 |

## Setup simulation

I currently use Questa to simulate component execution. You need to configure the free license correctly, otherwise the simulation won't run.

Once your account has been created, your PC registered, a license requested and collected by email from intel.
- [Intel® FPGA Licensing Support Center](https://www.intel.com/content/www/us/en/support/programmable/licensing/support-center.html)
- [Setup Quartus License Windows](https://www.terasic.com.tw/wiki/Setup_Quartus_License_Windows)

### Configure a simulation

In Quartus, go to `Assignments > Settings...`

Go to `EDA Tool Settings > Simulation` tab

**Tool name:** must be Questa Intel FPGA
in NativeLink settings section, press in `Test Benches...` button

`New...` button to add a new testbench configuration

**Test bench name** match with the name of the testbench. for instance `LEDs_racer_core_tb`

**Top level module in test bench** match with the name of the top level module typicaly same **Test bench name**

Need include the file for this test bench, for instance `LEDs_racer_core_tb.vhd`

### Run simulation

In root of Quartus, go to `Tools > Run Simulation Tool > RTL Simulation` should run Questa for your setup testbench.
