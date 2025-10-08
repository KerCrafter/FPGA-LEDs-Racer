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


library ieee;
use ieee.std_logic_1164.all;

entity activity_detector is
  port(
    clk : in std_logic;
    A : in std_logic;
    B : in std_logic;
    C : in std_logic;
    D : in std_logic;
    E : in std_logic;
    F : in std_logic;

    R : out std_logic
  );
end entity;


architecture beha of activity_detector is
  signal boot_activity : std_logic := '0';
  signal boot_end : std_logic := '0';

  signal activity_signals : std_logic := '0';

  signal pipe1 : std_logic; 
  signal pipe2 : std_logic; 
  signal pipe3 : std_logic; 
  signal pipe4 : std_logic; 
  signal pipe5 : std_logic; 
begin

  A_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_out => pipe1,
      s => A
    );

  B_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_in => pipe1,
      pipe_out => pipe2,
      s => B
    );

  C_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_in => pipe2,
      pipe_out => pipe3,
      s => C
    );

  D_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_in => pipe3,
      pipe_out => pipe4,
      s => D
    );

  E_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_in => pipe4,
      pipe_out => pipe5,
      s => E
    );

  F_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_in => pipe5,
      pipe_out => activity_signals,
      s => F
    );

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

  R <= activity_signals or boot_activity;

end architecture;
