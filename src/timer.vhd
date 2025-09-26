library ieee;
use ieee.std_logic_1164.all;

entity timer is
  port (
    clk : in std_logic;
    enable : in std_logic;
    tick : out std_logic
  );
end entity;

architecture beh of timer is
  signal cnt : integer range 0 to 49999999;
begin

  process(clk)
  begin
    
    if rising_edge(clk) then

      if enable = '1' and cnt = 0 then
        cnt <= 1;
      elsif enable = '1' and cnt = 49999999 then
        cnt <= 0;
      elsif enable = '1' then
        cnt <= cnt + 1;
      else
        cnt <= 0;
      end if;

    end if;

  end process;

  tick <= '1' when enable = '1' and cnt = 0 else '0';

end architecture;
