library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
generic ( p_DATA_WIDTH : integer := 32);
port ( i_RST : in  std_logic;                                  -- reset
       i_CLK : in  std_logic;                                  -- clock
       i_LD  : in  std_logic;                                  -- load
       i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);  -- data input
       o_S   : out std_logic_vector(p_DATA_WIDTH-1 downto 0)); -- data output
end reg;

architecture arch_1 of reg is
begin
  process(i_RST, i_CLK, i_LD, i_A)
  begin
    if (i_RST = '1') then
      o_S <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      if (i_LD = '1') then
        o_S <= i_A;
      end if;
    end if;
  end process;
end arch_1;