library ieee;
use ieee.std_logic_1164.all;

entity timer is
  generic (
    CLK_COUNT : integer;
    FIRST_TICK_AFTER_DELAY : boolean := false
  );
  port (
    clk : in std_logic;
    enable : in std_logic;
    tick : out std_logic
  );
end entity;

architecture beh of timer is
  signal cnt : integer range 0 to CLK_COUNT - 1;
begin

  process(clk)
  begin
    
    if rising_edge(clk) then

      if enable = '1' and cnt = 0 then
        cnt <= 1;
      elsif enable = '1' and cnt = CLK_COUNT - 1 then
        cnt <= 0;
      elsif enable = '1' then
        cnt <= cnt + 1;
      else
        cnt <= 0;
      end if;

    end if;

  end process;

  tick <= '1' when (FIRST_TICK_AFTER_DELAY = false and enable = '1' and cnt = 1) or (FIRST_TICK_AFTER_DELAY = true and enable = '1' and cnt = CLK_COUNT - 1) else '0';

end architecture;
