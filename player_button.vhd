library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button is
  generic(
    max_pos : integer := 16
  );

  port (
    game_started : in std_logic := '1';
    btn : in std_logic;
    clk: in std_logic;
    cur_pos : buffer integer range 0 to max_pos-1;
    activity : out std_logic := '0'
  );
end entity;

architecture beh of player_button is
  signal lock : std_logic;
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if btn = '1' and btn /= lock then
        if cur_pos /= max_pos-1 then
          lock <= btn;
          activity <= '1';
          
          if game_started = '1' then
            cur_pos <= cur_pos + 1;
          end if;
        end if;
      elsif btn = '0' and btn /= lock then
        lock <= btn;
      else
        activity <= '0';
      end if;
    end if;
  end process;
  
end architecture;
