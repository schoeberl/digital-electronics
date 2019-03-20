-- Popcount FSM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
  port(clock, reset : in std_logic; 
       din_valid : in std_logic;
       din_ready : out std_logic;
       pcnt_valid : out std_logic;
       pcnt_ready : in std_logic;
       load : out std_logic;
       done : in std_logic);
end fsm;

architecture impl of fsm is

  type state_type     is (idle, count, finished);
  signal state_reg    : state_type;
  signal next_state   : state_type;

begin

  process(all) begin

    -- some defaults
    load <= '0';
    din_ready <= '0';
    pcnt_valid <= '0';
    next_state <= state_reg;

    case state_reg is

      when idle =>
        din_ready <= '1';
        if din_valid = '1' then
          load <= '1';
          next_state <= count;
        end if;

        when count =>
          if done = '1' then
            next_state <= finished;
          end if;

        when finished =>
          pcnt_valid <= '1';
          if pcnt_ready = '1' then
             next_state <= idle;
          end if;

    end case;

end process;
  
process(clock, reset)
begin

    if reset='1' then
        state_reg <= idle;
    elsif rising_edge(clock) then
        state_reg <= next_state;
    end if;

end process;
   
end impl;


-- Popcount datapath
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
  port(clock, reset : in std_logic;
       din : in std_logic_vector(7 downto 0);
       load : in std_logic;
       done : out std_logic;
       pop_count : out std_logic_vector(3 downto 0));
end datapath;

architecture impl of datapath is

  signal data_reg, data_next : std_logic_vector(7 downto 0);
  signal popcnt_reg, popcnt_next, add_val : unsigned(3 downto 0);
  signal counter_reg, counter_next : unsigned(3 downto 0);

begin

process(all)
begin

  add_val <= unsigned("000" & data_reg(0));
  
  -- defaults
  done <= '0';
  data_next <= "0" & data_reg(7 downto 1);
  popcnt_next <= popcnt_reg +  add_val;
  counter_next <= counter_reg;
  
  if counter_reg = "0000" then
    done <= '1';
  else
    counter_next <= counter_reg - 1;
  end if;
  
  if load = '1' then
    data_next <= din;
    popcnt_next <= (others => '0');
    counter_next <= "1000";
  end if;

end process;

  pop_count <= std_logic_vector(popcnt_reg);
  
process(clock, reset)
begin

  if reset='1' then
    data_reg <= (others => '0');
    popcnt_reg <= (others => '0');
    counter_reg <= (others => '0');
  elsif rising_edge(clock) then
    data_reg <= data_next;
    popcnt_reg <= popcnt_next;
    counter_reg <= counter_next;
  end if;

end process;
   
   
end impl;


-- Popcount top level
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity popcount is
  port(clock, reset : in std_logic; 
       din_valid : in std_logic;
       din_ready : out std_logic;
       din : in std_logic_vector(7 downto 0);
       pcnt_valid : out std_logic;
       pcnt_ready : in std_logic;
       pop_count : out std_logic_vector(3 downto 0));
end popcount;

architecture impl of popcount is

component fsm is
  port(clock, reset : in std_logic; 
       din_valid : in std_logic;
       din_ready : out std_logic;
       pcnt_valid : out std_logic;
       pcnt_ready : in std_logic;
       load : out std_logic;
       done : in std_logic);
end component;

component datapath is
  port(clock, reset : in std_logic;
       din : in std_logic_vector(7 downto 0);
       load : in std_logic;
       done : out std_logic;
       pop_count : out std_logic_vector(3 downto 0));
end component;

  signal done, load : std_logic;

begin

  f: fsm port map(clock, reset,
       din_valid,
       din_ready,
       pcnt_valid,
       pcnt_ready,
       load,
       done);
       
  d: datapath port map(clock, reset,
       din,
       load,
       done,
       pop_count);
     
end impl;
