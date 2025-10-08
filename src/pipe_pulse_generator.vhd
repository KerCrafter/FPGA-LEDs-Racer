library ieee;
use ieee.std_logic_1164.all;

entity pipe_pulse_generator is
  port (
    clk : in std_logic;
    s : in std_logic;
    pipe_in : in std_logic := '0';
    pipe_out : out std_logic
  );
end entity;

architecture beha of pipe_pulse_generator is
  type t_state is (WAIT_UP, PULSE, WAIT_DOWN);
  signal state : t_state := WAIT_UP;

  signal sig_pulse : std_logic;
begin

  process(clk)
  begin

    if rising_edge(clk) then 

      case state is
        when WAIT_UP =>
          if s = '1' then
            state <= PULSE;
            sig_pulse <= '1';
          end if;

        when PULSE =>
          state <= WAIT_DOWN;
          sig_pulse <= '0';

        when WAIT_DOWN =>
          sig_pulse <= '0';

          if s = '0' then
            state <= WAIT_UP;
          end if;
      end case;
    end if;

  end process;

  pipe_out <= pipe_in or sig_pulse;

end architecture;
