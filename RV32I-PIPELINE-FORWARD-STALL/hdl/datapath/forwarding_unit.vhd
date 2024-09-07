library IEEE;
use IEEE.std_logic_1164.all;

entity forwarding_unit is
port ( i_RS1_EX        : in  std_logic_vector(4 downto 0);
       i_RS2_EX        : in  std_logic_vector(4 downto 0);
       i_WRITE_REG_MEM : in  std_logic_vector(4 downto 0);
       i_WRITE_REG_WB  : in  std_logic_vector(4 downto 0);
       i_REGWRITE_MEM  : in  std_logic;
       i_REGWRITE_WB   : in  std_logic;
       o_FORWARD_A     : out std_logic_vector(1 downto 0);
       o_FORWARD_B     : out std_logic_vector(1 downto 0));
end forwarding_unit;

architecture arq1 of forwarding_unit is
begin
  process(i_RS1_EX, i_RS2_EX, i_WRITE_REG_MEM, i_WRITE_REG_WB, i_REGWRITE_MEM, i_REGWRITE_WB)
  begin    
    if (i_REGWRITE_MEM = '1' and i_WRITE_REG_MEM /= "00000" and i_WRITE_REG_MEM = i_RS1_EX) then -- hazard ex/mem
      o_FORWARD_A <= "10";
    elsif (i_REGWRITE_WB = '1' and i_WRITE_REG_WB /= "00000" and i_WRITE_REG_WB = i_RS1_EX) then -- hazard mem/wb
      o_FORWARD_A <= "01";
    else
      o_FORWARD_A <= "00";
    end if;
      
    if (i_REGWRITE_MEM = '1' and i_WRITE_REG_MEM /= "00000" and i_WRITE_REG_MEM = i_RS2_EX) then -- hazard ex
      o_FORWARD_B <= "10";
    elsif (i_REGWRITE_WB = '1' and i_WRITE_REG_WB /= "00000" and i_WRITE_REG_WB = i_RS2_EX) then -- hazard mem
      o_FORWARD_B <= "01";
    else
      o_FORWARD_B <= "00";
    end if;
  end process;
end arq1;