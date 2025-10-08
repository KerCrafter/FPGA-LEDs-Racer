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

  signal a_prc : std_logic := '0';
  signal b_prc : std_logic := '0';
  signal b_lock : std_logic := '0';
  signal c_prc : std_logic := '0';
  signal c_lock : std_logic := '0';
  signal d_prc : std_logic := '0';
  signal d_lock : std_logic := '0';
  signal e_prc : std_logic := '0';
  signal e_lock : std_logic := '0';
  signal f_prc : std_logic := '0';
  signal f_lock : std_logic := '0';
begin

  A_PIPE_PULSE : entity work.pipe_pulse_generator
    port map(
      clk => clk,
      pipe_out => a_prc,
      s => A
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

      if e_prc = '0' and E = '1' then
        e_prc <= '1';
        e_lock <= '1';
      end if;

      if e_lock = '1' then
        e_prc <= '0';
      end if;

      if e_lock = '1' and E = '0' then
        e_lock <= '0';
      end if;

      if f_prc = '0' and F = '1' then
        f_prc <= '1';
        f_lock <= '1';
      end if;

      if f_lock = '1' then
        f_prc <= '0';
      end if;

      if f_lock = '1' and F = '0' then
        f_lock <= '0';
      end if;
    end if;
  end process;

  R <= a_prc or b_prc or c_prc or d_prc or e_prc or f_prc or boot_activity;

end architecture;
