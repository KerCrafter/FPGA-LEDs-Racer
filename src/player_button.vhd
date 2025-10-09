library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button is
  generic(
    max_pos : integer := 16
  );

  port (
    clk : in std_logic;
    btn : in std_logic;
    current_screen : in std_logic_vector(1 downto 0);
    reset : in std_logic;
    cur_pos : out integer range 0 to max_pos-1;
    activity : out std_logic := '0';
    ready_to_play : buffer std_logic := '0'
  );
end entity;

architecture beh of player_button is
  signal cur_pos_s : integer range 0 to max_pos-1;

  type state_t is (WAIT_INTERACT, WHEN_BTN, WHEN_RESET, WAIT_RELEASE_BTN);
  signal state : state_t := WAIT_INTERACT;
begin

  process(clk)
  begin
    if rising_edge(clk) then
      case state is
        when WAIT_INTERACT =>
          if btn = '1' then
            state <= WHEN_BTN;
          end if;

          if reset = '1' then
            state <= WHEN_RESET;
          end if;

        when WHEN_BTN =>
          state <= WAIT_RELEASE_BTN;

          if current_screen = "00" then
            ready_to_play <= '1';
          end if;

          if current_screen = "01" and ready_to_play = '1' then
            cur_pos_s <= cur_pos_s + 1;
          end if;

        when WAIT_RELEASE_BTN =>
          if btn = '0' then
            state <= WAIT_INTERACT;
          end if;

        when WHEN_RESET =>
          state <= WAIT_INTERACT;

          cur_pos_s <= 0;
          ready_to_play <= '0';

      end case;

    end if;
  end process;

  cur_pos <= cur_pos_s;
  activity <= btn;
end architecture;
