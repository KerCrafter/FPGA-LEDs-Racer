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

  signal a_prc : std_logic := '0';
  signal a_lock : std_logic := '0';
  signal b_prc : std_logic := '0';
  signal b_lock : std_logic := '0';
  signal c_prc : std_logic := '0';
  signal c_lock : std_logic := '0';
  signal d_prc : std_logic := '0';
  signal d_lock : std_logic := '0';
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

      if b_prc = '0' and B = '1' then
        b_prc <= '1';
        b_lock <= '1';
      end if;

      if b_lock = '1' then
        b_prc <= '0';
      end if;

      if b_lock = '1' and B = '0' then
        b_lock <= '0';
      end if;

      if c_prc = '0' and C = '1' then
        c_prc <= '1';
        c_lock <= '1';
      end if;

      if c_lock = '1' then
        c_prc <= '0';
      end if;

      if c_lock = '1' and C = '0' then
        c_lock <= '0';
      end if;

      if a_prc = '0' and A = '1' then
        a_prc <= '1';
        a_lock <= '1';
      end if;

      if a_lock = '1' then
        a_prc <= '0';
      end if;

      if a_lock = '1' and A = '0' then
        a_lock <= '0';
      end if;

      if d_prc = '0' and D = '1' then
        d_prc <= '1';
        d_lock <= '1';
      end if;

      if d_lock = '1' then
        d_prc <= '0';
      end if;

      if d_lock = '1' and D = '0' then
        d_lock <= '0';
      end if;

    end if;
  end process;

  R <= a_prc or b_prc or c_prc or d_prc or boot_activity;

end architecture;
