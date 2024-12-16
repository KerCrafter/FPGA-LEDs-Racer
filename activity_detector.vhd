library ieee;
use ieee.std_logic_1164.all;

entity activity_detector is
  port(
    A : in std_logic;
    B : in std_logic;
    C : in std_logic;
    D : in std_logic;
    
    R : out std_logic
  );
end entity;


architecture beha of activity_detector is
begin

  process(A, B, C, D)
  begin
    R <= A or B or C or D;
  end process;

end architecture;
