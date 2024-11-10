# Player Button

Manage the input for ONE player, typically Yellow player implement one instance of this

![State Diagram of Player Button](../state_diagram_player_button.png)

## Responsabilities :

- Increments a counter at each press into the button
- Send a short impulsion just to inform that the displayed informations has changed

## RTL Architecture

![Player Button Architecture](./../assets/player_button_arch.png)

|  pin input   | input description  |   output description             |  pin output                    |
|  :---   |  :--- | ---:                         |  ---:                    |
|  **clk**  |  50 Mhz clock input signal  |  Up to HIGH during one clk cycle when button is pressed  |  **activity**  |
|  **btn**  |  Connected to the button  | Actual position of the player | **cur_pos[1..0]** |
