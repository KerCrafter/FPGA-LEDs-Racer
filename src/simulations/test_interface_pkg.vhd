library ieee;
use ieee.std_logic_1164.all;

package test_status_pkg is
  type t_TEST_STATUS is record
    is_finished : boolean;
    result_status : boolean;
  end record;

  constant TEST_STATUS_INIT : t_TEST_STATUS := (
    is_finished => false,
    result_status => true
  );

  constant TEST_SUCCESS : t_TEST_STATUS := (
    is_finished => true,
    result_status => true
  );

  constant TEST_FAIL : t_TEST_STATUS := (
    is_finished => true,
    result_status => false 
  );

  procedure TEST_KO_FOR(
    signal test_status: out t_TEST_STATUS
  );

end package;


package body test_status_pkg is

  procedure TEST_KO_FOR(
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    test_status.result_status <= false;
  end procedure;

end package body;
