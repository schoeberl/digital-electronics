-- Section 3.6
-- Majority gate

library ieee;
use ieee.std_logic_1164.all;

entity majority is
  port(a, b, c : in std_logic; 
       output : out std_logic );
end majority;

architecture impl of majority is
begin

  -- Add your code here (start)
  output <= (a and b) or (a and c) or (b and c);
  -- Add your code here (end)
   
end impl;