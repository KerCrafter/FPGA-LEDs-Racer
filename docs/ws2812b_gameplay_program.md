# WS2812B Gameplay Program

Displaying logic per LEDs. designed to work with WS2812B Driver.


## Responsabilities :

- Receive Positions of the 4 players
- Reveive LED should be coded
- Send Green/Red/Blue values to the WS2812B driver

## RTL Architecture 

![WS2812B Gameplay Program Architecture](./../assets/WS2812B_gameplay_program_arch.png)

|  pin input   | input description  |   output description             |  pin output                    |
|  :---   |  :--- | ---:                         |  ---:                    |
|  **led_number[1..0]**  |  Position of the current coded led  |  Green light intensity emited (0 - 255) |  **green_intensity[7..0]**  |
|  **red_pos[1..0]**  |  Position of Red player  | Red light intensity emited (0 - 255) | **red_intensity[7..0]** |
|  **green_pos[1..0]**  |  Position of Green player  | Blue light intensity emited (0 - 255) | **blue_intensity[7..0]** |
|  **blue_pos[1..0]**  |  Position of Blue player  | | |
|  **yellow_pos[1..0]**  |  Position of Yellow player  | | |
