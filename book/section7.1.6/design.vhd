-- Section 7.1.6
-- prime number function

library ieee;
use ieee.std_logic_1164.all;

entity prime is
  port(input : in std_logic_vector(3 downto 0);
        isprime : out std_logic );
end prime;

architecture cond_impl of prime is
begin

  isprime <= '1' when input = 4d"1" else
             '1' when input = 4d"2" else
             '1' when input = 4d"3" else
             '1' when input = 4d"5" else
             '1' when input = 4d"7" else
             '1' when input = 4d"11" else
             '1' when input = 4d"13" else
             '0';
end cond_impl;