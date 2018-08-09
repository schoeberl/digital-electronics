-- Testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

component fib is
  port(input : in std_logic_vector(3 downto 0);
        isfib : out std_logic );
end component;
  
  signal input: std_logic_vector(3 downto 0);
  signal output: std_logic;
  
begin

  -- generate inputs and print the logic table
  process begin
    for i in 0 to 15 loop
      input <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;
      report to_string(input) & " "
         & to_string(output);
    end loop;
    std.env.stop(0);
  end process;
  
  -- the device under test
  dut: fib port map(input, output);

end test;