-- Testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

  component majority is
    port(a, b, c : in std_logic; 
         output : out std_logic );
  end component;
  
  signal counter: unsigned(2 downto 0);
  signal output: std_logic;
  
begin

  -- generate inputs and print the logic table
  process begin
    for i in 0 to 7 loop
      counter <= to_unsigned(i, 3);
      wait for 10 ns;
      report to_string(counter) & " "
         & to_string(output);
    end loop;
    std.env.stop(0);
  end process;
  
  -- the device under test
  dut: majority port map(counter(2), 
            counter(1), counter(0), output);

end test;