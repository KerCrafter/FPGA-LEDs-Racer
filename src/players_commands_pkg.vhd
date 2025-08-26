library ieee;
use ieee.std_logic_1164.all;

package players_commands_pkg is

  type t_PLAYERS_COMMANDS is record
    green : std_logic;
    blue : std_logic;
    red : std_logic;
    yellow : std_logic;
  end record;

  constant PLAYERS_COMMANDS_INIT : t_PLAYERS_COMMANDS := (
    red => '0',
    blue => '0',
    green => '0',
    yellow => '0'
  );

end package;
