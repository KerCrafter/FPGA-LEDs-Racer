library ieee;
use ieee.std_logic_1164.all;

package timer_pkg is

  type t_TIMER is record
    enable : std_logic;
    tick : std_logic;
  end record;

end package;
