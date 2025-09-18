library ieee;
use ieee.std_logic_1164.all;
use work.timer_pkg.all;

entity timer is
  port (
    timer_interface : inout t_TIMER
  );
end entity;

architecture beh of timer is
begin

  timer_interface.tick <= timer_interface.enable;

end architecture;
