library ieee;
use ieee.std_logic_1164.all;

entity is_in_menu is
  port(
    clk : in std_logic;

    green_ready_to_play : in std_logic;
    red_ready_to_play : in std_logic;
    blue_ready_to_play : in std_logic;
    yellow_ready_to_play : in std_logic;
  
    result : out std_logic;
    D_two_players_ready : out std_logic
  );
end entity;

architecture behaviour of is_in_menu is
  signal two_players_ready : std_logic := '0';
begin
  process ( clk )
  begin
    if rising_edge(clk) then
      if blue_ready_to_play = '1' and red_ready_to_play = '1' then
        two_players_ready <= '1';
      end if;
    end if;
  end process;

  result <= '0';
  D_two_players_ready <= two_players_ready;
end architecture;
