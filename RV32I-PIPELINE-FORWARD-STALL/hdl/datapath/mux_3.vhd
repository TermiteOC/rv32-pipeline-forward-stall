library IEEE;
use IEEE.std_logic_1164.all;

entity mux_3 is
generic ( p_DATA_WIDTH : integer := 32);
port ( i_SEL : in  std_logic_vector(1 downto 0); 
       i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
       i_B   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
       i_C   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
       o_OUT : out std_logic_vector(p_DATA_WIDTH-1 downto 0));
end mux_3;

architecture arq1 of mux_3 is
begin
  process(i_SEL, i_A, i_B, i_C)
  begin
    if (i_SEL="01") then
      o_OUT <= i_B;
    elsif (i_SEL="10") then
      o_OUT <= i_C;
    else
      o_OUT <= i_A;
    end if;
  end process;
end arq1;