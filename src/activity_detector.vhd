library ieee;
use ieee.std_logic_1164.all;

entity activity_detector is
  port(
    clk : in std_logic;
    A : in std_logic;
    B : in std_logic;
    C : in std_logic;
    D : in std_logic;
    
    R : out std_logic
  );
end entity;


architecture beha of activity_detector is
  signal boot_activity : std_logic := '0';
  signal boot_end : std_logic := '0';
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if boot_end = '0' then
        boot_activity <= '1';
        boot_end <= '1';
      end if;

      if boot_end = '1' then
        boot_activity <= '0';
      end if;
    end if;
  end process;

  R <= A or B or C or D or boot_activity;

end architecture;
