
-- Testbench for popcount
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

  component popcount is
  port(clock, reset : in std_logic; 
       din_valid : in std_logic;
       din_ready : out std_logic;
       din : in std_logic_vector(7 downto 0);
       pcnt_valid : out std_logic;
       pcnt_ready : in std_logic;
       pop_count : out std_logic_vector(3 downto 0));
  end component;
  
  signal clock : std_logic := '1';
  signal reset : std_logic := '1';
  signal din_valid : std_logic;
  signal din_ready : std_logic;
  signal din : std_logic_vector(7 downto 0);
  signal pcnt_valid : std_logic;
  signal pcnt_ready : std_logic;
  signal pop_count : std_logic_vector(3 downto 0);
begin

  -- the device under test
  dut: popcount port map(clock, reset,
       din_valid,
       din_ready,
       din,
       pcnt_valid,
       pcnt_ready,
       pop_count);
       
  process
  begin
    wait for 5 ns; clock  <= not clock;
  end process;
-- reset
  process
  begin
    wait for 15 ns;
    reset <= '0';
    wait;
  end process;
  
  process begin
    -- set default values
    din_valid <= '0';
    pcnt_ready <= '0';
    din <= "10101100";
    -- wait a few clock cycles for reset
    wait for 47 ns;
    din_valid <= '1';
    wait for 10 ns;
    din_valid <= '0';
    wait for 120 ns;

    assert pop_count="0100" report "error: pop_count should be 4";
    
    
    std.env.stop(0);
  end process;
  
end test;
