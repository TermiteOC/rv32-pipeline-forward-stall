library IEEE;
use IEEE.std_logic_1164.all;

entity hazard_detection_unit is
port ( i_RS1_ID        : in  std_logic_vector(4 downto 0);
       i_RS2_ID        : in  std_logic_vector(4 downto 0);
       i_WRITE_REG_EX  : in  std_logic_vector(4 downto 0);
       i_MEMREAD_EX    : in  std_logic;
       o_PCWRITE       : out std_logic;
       o_IF_ID_WRITE   : out std_logic;
       o_HAZARD        : out std_logic);
end hazard_detection_unit;

architecture arq1 of hazard_detection_unit is
begin
  process(i_RS1_ID, i_RS2_ID, i_WRITE_REG_EX, i_MEMREAD_EX)
  begin    
    if (i_MEMREAD_EX = '1' and (i_WRITE_REG_EX = i_RS1_ID or i_WRITE_REG_EX = i_RS2_ID)) then
      o_PCWRITE     <= '0';
      o_IF_ID_WRITE <= '0';
      o_HAZARD      <= '1';
    else
      o_PCWRITE     <= '1';
      o_IF_ID_WRITE <= '1';
      o_HAZARD      <= '0';
    end if;
  end process;
end arq1;