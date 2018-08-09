-- Exercise 7.2
-- function to output true for a Fibunacci number:
-- (0, 1, 2, 3, 5, 8, or 13)

library ieee;
use ieee.std_logic_1164.all;

entity fib is
  port(input : in std_logic_vector(3 downto 0);
        isfib : out std_logic );
end fib;

architecture impl of fib is
begin

  -- Add your code here (start)
  isfib <= ...
  -- Add your code here (end)

end impl;