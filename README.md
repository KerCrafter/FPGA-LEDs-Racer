# FPGA Leds Racer

## Description

A fun little game, 4 players (Red, Blue, Green, Yellow) around a table, each with an arcade button, must challenge each other by pressing their button as fast as possible.

Pressing the button causes their led to progress to the center circle. The first to reach the center wins.

## Hardware

I'm putting here the material I used for the project, but of course if it's compatible this list can be adapted.

- 4 x **Arcade buttons** (https://www.amazon.fr/EG-STARTS-Nouveau-Boutons-poussoirs-lumineux/dp/B01MSNXLN0/)
- 1 x **LEDs Circles (with WS2812B Leds)** (https://www.amazon.fr/Treedix-anneaux-WS2812B-adressable-Raspberry/dp/B0CD3DYJRK/)
- 1 x **FPGA DE0 Nano** (https://www.mouser.fr/ProductDetail/Terasic-Technologies/P0082?qs=ePbE9GiMmvUo6nLfdjJv4g%3D%3D)

## Software IDE

I'm putting here the software I use for development to date. It's possible that these technical considerations may change depending on the target material.

- Quartus Prime Lite
- Questa Sim

## Actual State
**49** Logic Element (LE) - **27** Registers

I concentrated mainly on implementing the WS2812B LED driver. With the help of the testbench tool, I implemented tests as I went along in order to discover the communication algorithm with the WS2812B LED serial line. 
This enabled me to optimize the number of registers and logic elements used (120 to 51 LE).

### Identified problems

- Initial players position seems LED 1 instead LED 0 (probably caused by initial state of inputs from the FPGA)
- Pressing in button not jump to the next position (probably caused by hardware button bouncing on press)
- LEDs display multiple times (probably caused by WS2812B Driver, I think frame validation (RET code) acordingly the DataSheet should be LOW during **Treset** = Above 50µs. Is not implemented now. 

## Architecture (Top View Usage)

![Top View Architecture](./assets/top_level_arch.png)

|  pin input   | input description  |   output description             |  pin output                    |
|  :---   |  :--- | ---:                         |  ---:                    |
|  **clk**  |  50 Mhz clock input signal  |  WS2812B transmission  |  **leds_line**  |
|  **enable**  |  High state to start  | |  |
|  **red_input**  |  Player Red input (connected to Red button)  |    |  |
|  **green_input**  |  Player Green input (connected to Green button)  |    |  |
|  **blue_input**  |  Player Blue input (connected to Blue button)  |    |  |
|  **yellow_input**  |  Player Yellow input (connected to Yellow button)  |    |  |

### See more about sub-components

- [Player Button](./docs/player_button.md)
- [Activity Detector](./docs/activity_detector.md)
- [WS2812B Driver](./docs/ws2812b_driver.md)
- [WS2812B Gameplay Program](./docs/ws2812b_gameplay_program.md)
