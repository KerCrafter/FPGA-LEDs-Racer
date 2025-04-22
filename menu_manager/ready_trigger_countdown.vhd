library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ready_trigger_countdown is
  port(
    green_ready_to_play : in std_logic;
    red_ready_to_play : in std_logic;
    blue_ready_to_play : in std_logic;
    yellow_ready_to_play : in std_logic;
  
    result : out std_logic;
    D_two_players_ready : out std_logic
  );
end entity;

architecture behaviour of ready_trigger_countdown is
 
  function std_logic_to_integer( s : std_logic ) return integer is
  begin
    if s = '1' then
      return 1;
    else
      return 0;
    end if;
  end function;

begin
  result <= '0';
  D_two_players_ready <= '1' when (std_logic_to_integer(green_ready_to_play) + std_logic_to_integer(blue_ready_to_play) + std_logic_to_integer(red_ready_to_play) + std_logic_to_integer(yellow_ready_to_play) ) > 1 else '0'; 
end architecture;
