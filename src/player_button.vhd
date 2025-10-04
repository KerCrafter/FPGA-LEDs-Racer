library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button is
  generic(
    max_pos : integer := 16
  );

  port (
    btn : in std_logic;
    current_screen : in std_logic_vector(1 downto 0);
    cur_pos : out integer range 0 to max_pos-1;
    activity : out std_logic := '0';
    ready_to_play : out std_logic := '0'
  );
end entity;

architecture beh of player_button is
  signal cur_pos_s : integer range 0 to max_pos-1;
begin
  process(btn)
  begin
    if rising_edge(btn) then
      if current_screen = "00" then
        ready_to_play <= '1';
      end if;

      if current_screen = "01" and ready_to_play = '1' then
        cur_pos_s <= cur_pos_s + 1;
      end if;
    end if;
  end process;

  cur_pos <= cur_pos_s;
  activity <= btn;
  
end architecture;
