library IEEE;
use IEEE.std_logic_1164.all;

entity main_control is
port ( i_OP       : in  std_logic_vector(6 downto 0);
       o_S_CTRL   : out std_logic_vector(7 downto 0));
end main_control;

architecture arch_1 of main_control is
  -- Declaração de Sinais
  signal w_REGWRITE   : std_logic;
  signal w_MEMTOREG   : std_logic;
  signal w_BRANCH     : std_logic;
  signal w_MEMREAD    : std_logic;
  signal w_MEMWRITE   : std_logic;
  signal w_ALU_OP     : std_logic_vector(1 downto 0);
  signal w_ALUSRC     : std_logic;

begin
  process(i_OP)
  begin
    w_REGWRITE  <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6))) or -- lw
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and i_OP(5) and (not i_OP(6))) or            -- formato r
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and i_OP(4) and (not i_OP(5)) and (not i_OP(6)));         -- formato i

    w_MEMTOREG  <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6));    -- lw

    w_BRANCH    <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and i_OP(6);                -- beq

    w_MEMREAD   <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6)));   -- lw
  
    w_MEMWRITE  <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and (not i_OP(6));          -- sw
    
    w_ALU_OP(0) <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and i_OP(6)) or             -- beq
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and (not i_OP(5)) and (not i_OP(6)));        -- formato i

    w_ALU_OP(1) <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and i_OP(5) and (not i_OP(6))) or            -- formato r
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and (not i_OP(5)) and (not i_OP(6)));        -- formato i

    w_ALUSRC    <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6))) or -- lw
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and (not i_OP(6))) or       -- sw
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and i_OP(4) and (not i_OP(5)) and (not i_OP(6)));         -- formato i;
  end process;
  
  o_S_CTRL <= w_ALUSRC & w_ALU_OP & w_MEMWRITE & w_MEMREAD & w_BRANCH & w_MEMTOREG & w_REGWRITE;
end arch_1;
