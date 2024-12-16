library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_main_tb is
end entity;

architecture simulation of LEDs_racer_main_tb is
  signal clk : std_logic;
  signal enable : std_logic := '0';
  signal red_input : std_logic;
  signal blue_input : std_logic;
  signal green_input : std_logic;
  signal yellow_input : std_logic;
  
  signal leds_line : std_logic;
  
  signal elapsed_clk_top : integer := 1;
  
  procedure assert_should_maintain_LOW_state_during_1_clk_edge is
  begin
    if clk = '1' then
      wait until clk = '0'; assert leds_line = '0' report "should maintain LOW during ...";
      wait until clk = '1'; assert leds_line = '0' report "should maintain LOW during ...";
    else
      wait until clk = '1'; assert leds_line = '0' report "should maintain LOW during ...";
    end if;
  end procedure;
  
  procedure assert_should_maintain_LOW_state_during( expected_clk_edge: integer ) is
    variable clk_checks : integer := 0;
  begin
    while clk_checks < expected_clk_edge loop
      assert_should_maintain_LOW_state_during_1_clk_edge;
      clk_checks := clk_checks + 1;
    end loop;
  end procedure;
  
  procedure assert_should_maintain_HIGH_state_during_1_clk_edge is
  begin
    if clk = '1' then
      wait until clk = '0'; assert leds_line = '1' report "should maintain HIGH during ...";
      wait until clk = '1'; assert leds_line = '1' report "should maintain HIGH during ...";
    else
      wait until clk = '1'; assert leds_line = '1' report "should maintain HIGH during ...";
    end if;
  end procedure;
  
  procedure assert_should_maintain_HIGH_state_during( expected_clk_edge: integer ) is
    variable clk_checks : integer := 0;
  begin
    while clk_checks < expected_clk_edge loop
      assert_should_maintain_HIGH_state_during_1_clk_edge;
      clk_checks := clk_checks + 1;
    end loop;
  end procedure;
  
  procedure assert_serial_line_change_to_LOW_after_clk_edge_counts( clk_edge: integer ) is
    variable cursor_start : integer;
  begin
    cursor_start := elapsed_clk_top;
    wait until leds_line = '0'; assert elapsed_clk_top - cursor_start = clk_edge report "to send first bit, should be 1 during around 0,80us";

  end procedure;
  
  procedure assert_serial_line_change_to_HIGH_after_clk_edge_counts( clk_edge: integer ) is
    variable cursor_start : integer;
  begin
    cursor_start := elapsed_clk_top;
    wait until leds_line = '1'; assert elapsed_clk_top - cursor_start = clk_edge report "serial line should change to HIGH after  clock rising edges"; -- to send first bit, should be 0 during around 0,45us

  end procedure;
  
  procedure assert_serial_NRZ_1_code_should_sent is
  begin
    assert_should_maintain_HIGH_state_during(40); -- ( 20ns * 40 => 800ns ) / 1000 = 0,8us (spec 0,80 )
    assert_should_maintain_LOW_state_during(23); -- ( 20ns * 23 => 460ns ) / 1000 = 0,46us ( Spec 0,45 )
  end procedure;
  
  procedure assert_serial_NRZ_0_code_should_sent is
  begin
    assert_should_maintain_HIGH_state_during(20); -- ( 20ns * 20 => 400ns ) / 1000 = 0,4us (spec 0,40 )
    assert_should_maintain_LOW_state_during(43); -- ( 20ns * 43 => 860ns ) / 1000 = 0,86us ( Spec 0,85 )
  end procedure;
  
  procedure assert_serial_led_signal_should_sent(
    green : integer range 0 to 255;
    red : integer range 0 to 255;
    blue : integer range 0 to 255
  ) is
    variable green_vector : std_logic_vector(1 to 8);
    variable red_vector : std_logic_vector(1 to 8);
    variable blue_vector : std_logic_vector(1 to 8);
  begin
    -- Green
    green_vector := std_logic_vector(to_unsigned(green, 8));
    
    if green_vector(1) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(2) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(3) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(4) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(5) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(6) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(7) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if green_vector(8) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    -- Red
    red_vector := std_logic_vector(to_unsigned(red, 8));

    if red_vector(1) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(2) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(3) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(4) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(5) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(6) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(7) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if red_vector(8) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    -- Blue
    blue_vector := std_logic_vector(to_unsigned(blue, 8));

    if blue_vector(1) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(2) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(3) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(4) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(5) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(6) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(7) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;
    
    if blue_vector(8) = '1' then
      assert_serial_NRZ_1_code_should_sent;
    else
      assert_serial_NRZ_0_code_should_sent;
    end if;

  end procedure;
  
  procedure assert_serial_white_led_signal_should_sent is
  begin
    assert_serial_led_signal_should_sent(5, 5, 5);
  end procedure;
  
  procedure assert_serial_black_led_signal_should_sent is
  begin
    assert_serial_led_signal_should_sent(0, 0, 0);
  end procedure;
  
  procedure assert_serial_green_led_signal_should_sent is
  begin
    assert_serial_led_signal_should_sent(10, 0, 0);
  end procedure;
  
  procedure assert_serial_red_led_signal_should_sent is
  begin
    assert_serial_led_signal_should_sent(0, 10, 0);
  end procedure;
  
  procedure assert_serial_blue_led_signal_should_sent is
  begin
    assert_serial_led_signal_should_sent(0, 0, 10);
  end procedure;
  
  procedure assert_serial_yellow_led_signal_should_sent is
  begin
    assert_serial_led_signal_should_sent(5, 5, 0);
  end procedure;
  
  procedure assert_next_black_leds_should_sent(leds_count : integer) is
  begin

    for i in 1 to leds_count loop
      assert_serial_black_led_signal_should_sent;
    end loop;

  end procedure;
  
begin
  UUT: entity work.LEDs_racer_main
    generic map(
      max_pos => 14,
      debounce_clk_cnt => 1
    )
    port map (
      clk => clk,
      enable => enable,
      
      red_input => red_input,
      blue_input => blue_input,
      green_input => green_input,
      yellow_input => yellow_input,

      leds_line => leds_line
    );
  
  STIM: process
  begin
    enable <= '0'; wait for 50 ns;
    enable <= '1'; wait for 50 ns;
    enable <= '0';
    wait;
  end process;
  
  PLAYS_STIM: process
  begin
    red_input <= '0';
    blue_input <= '0';
    green_input <= '0';
    yellow_input <= '0';
    
    wait for 15 ms;
    red_input <= '1'; wait for 0.5 ms; red_input <= '0'; --red position up to 1
    
    wait for 15 ms;
    red_input <= '1'; wait for 0.5 ms; red_input <= '0'; --red position up to 2
    
    wait for 15 ms;
    red_input <= '1'; wait for 0.5 ms; red_input <= '0'; --red position up to 3
    
    wait for 15 ms;
    blue_input <= '1'; wait for 0.5 ms; blue_input <= '0'; --blue position up to 1
    
    wait for 15 ms;
    blue_input <= '1'; wait for 0.5 ms; blue_input <= '0'; --blue position up to 2

    wait for 15 ms;
    blue_input <= '1'; wait for 0.5 ms; blue_input <= '0'; --blue position up to 3
    
    wait for 15 ms;
    green_input <= '1'; wait for 0.5 ms; green_input <= '0'; --green position up to 1

    wait for 15 ms;
    green_input <= '1'; wait for 0.5 ms; green_input <= '0'; --green position up to 2
    
    wait for 15 ms;
    yellow_input <= '1'; wait for 0.5 ms; yellow_input <= '0'; --yellow position up to 1
    
    wait;
  end process;
  
  CLK_STIM: process
  begin
    clk <= '0'; wait for 10 ns;
    
    clk <= '1';
    elapsed_clk_top <= elapsed_clk_top + 1; 
    wait for 10 ns;
  end process;
  
  CHECK_ENA: process
  begin
    assert leds_line = '0' report "Initialy should be low";

    wait until enable = '1'; wait until clk = '1'; wait for 1 ps;
    assert leds_line = '1' report "Just after enable, leds line should be high";
    
    wait;
  end process;
  
  CHECK_SIG: process
  begin
    assert_should_maintain_LOW_state_during(3);
    
    -- All players are in 1st case
    
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + RED + BLUE + YELLOW) => White
    assert_serial_black_led_signal_should_sent; -- second LED : Players (No Players) => Black
    assert_serial_black_led_signal_should_sent; -- third LED : Players (No Players) => Black
    assert_serial_black_led_signal_should_sent; -- 4th LED : Players (No Players) => Black
    
    assert_next_black_leds_should_sent(10);

    
    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
  
    wait until red_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Red go to second led
    
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + BLUE + YELLOW) => White
    assert_serial_red_led_signal_should_sent; -- second LED : Players (RED) => Red
    assert_serial_black_led_signal_should_sent; -- third LED : Players (No Players) => Black
    assert_serial_black_led_signal_should_sent; -- 4th LED : Players (No Players) => Black
    
    assert_next_black_leds_should_sent(10);
    
    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);

    wait until red_input = '0';
    wait until red_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Red go to third led
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + BLUE + YELLOW) => White
    assert_serial_black_led_signal_should_sent; -- second LED : Players (No Players) => Black
    assert_serial_red_led_signal_should_sent; -- third LED : Players (RED) => Red
    assert_serial_black_led_signal_should_sent; -- 4th LED : Players (No Players) => Black
    
    assert_next_black_leds_should_sent(10);

    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
        
    wait until red_input = '0';
    wait until red_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Red go to 4th led    
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + BLUE + YELLOW) => White
    assert_serial_black_led_signal_should_sent; -- second LED : Players (No Players) => Black
    assert_serial_black_led_signal_should_sent; -- third LED : Players (No Players) => Black
    assert_serial_red_led_signal_should_sent; -- 4th LED : Players (RED) => Red
    
    assert_next_black_leds_should_sent(10);

    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
    
    
    wait until blue_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Blue go to second led
    
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + YELLOW) => White
    assert_serial_blue_led_signal_should_sent; -- second LED : Players (BLUE) => Blue
    assert_serial_black_led_signal_should_sent; -- third LED : Players (No Players) => Black
    assert_serial_red_led_signal_should_sent; -- 4th LED : Players (RED) => Red
    
    assert_next_black_leds_should_sent(10);

    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
    
    wait until blue_input = '0';
    wait until blue_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Blue go to third led
    
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + YELLOW) => White
    assert_serial_black_led_signal_should_sent; -- second LED : Players (No Players) => Black
    assert_serial_blue_led_signal_should_sent; -- third LED : Players (BLUE) => Blue
    assert_serial_red_led_signal_should_sent; -- 4th LED : Players (RED) => Red
    
    assert_next_black_leds_should_sent(10);

    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
    
    
    wait until blue_input = '0';
    wait until blue_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Blue go to 4th led
    
    assert_serial_white_led_signal_should_sent; -- first LED : Players (GREEN + YELLOW) => White
    assert_serial_black_led_signal_should_sent; -- second LED : Players (No Players) => Black
    assert_serial_black_led_signal_should_sent; -- third LED : Players (No Players) => Black
    assert_serial_white_led_signal_should_sent; -- 4th LED : Players (BLUE + RED) => White
    
    assert_next_black_leds_should_sent(10);


    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
    
    wait until green_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';

    
    -- Green go to 2nd led
    
    assert_serial_yellow_led_signal_should_sent; -- first LED : Players (YELLOW) => Yellow
    assert_serial_green_led_signal_should_sent; -- second LED : Players (GREEN) => Green
    assert_serial_black_led_signal_should_sent; -- third LED : Players (No Players) => Black
    assert_serial_white_led_signal_should_sent; -- 4th LED : Players (BLUE + RED) => White
    
    assert_next_black_leds_should_sent(10);

    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
    
    wait until green_input = '0';
    wait until green_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';
    
    -- Green go to 3rd led
    
    assert_serial_yellow_led_signal_should_sent; -- first LED : Players (YELLOW) => Yellow
    assert_serial_black_led_signal_should_sent; -- second LED : Players (No Players) => Black
    assert_serial_green_led_signal_should_sent; -- third LED : Players (GREEN) => Green
    assert_serial_white_led_signal_should_sent; -- 4th LED : Players (BLUE + RED) => White
    
    assert_next_black_leds_should_sent(10);


    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);    

    wait until yellow_input = '1';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';
    
    -- Debounce Count
    wait until clk = '0';
    wait until clk = '1';

    -- Yellow go to 2nd led
    
    assert_serial_black_led_signal_should_sent; -- first LED : Players (No Players) => Black
    assert_serial_yellow_led_signal_should_sent; -- second LED : Players (YELLOW) => Yellow
    assert_serial_green_led_signal_should_sent; -- third LED : Players (GREEN) => Green
    assert_serial_white_led_signal_should_sent; -- 4th LED : Players (BLUE + RED) => White
    
    assert_next_black_leds_should_sent(10);

    -- (Spec: RESET CODE should be LOW during >= 50us)
    -- (50us => 50000 ns) / 20ns = 2500 clk edge
    -- adding a little padding = 2500 + (1000 => 2us)
    assert_should_maintain_LOW_state_during(2600);
    
    wait;
  end process;
end architecture;
