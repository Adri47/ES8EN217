----------------------------------------------------------------------------------
-- Company:
-- Engineer: Benjamin CHOLLET
--
-- Create Date: 24.02.2021 10:18:53
-- Design Name:
-- Module Name: bascule - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bascule is
  Port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    ce         : in  std_logic;
    load_carry : in  std_logic;
    init_carry : in  std_logic;
    entree     : in  std_logic;
    sortie     : out std_logic
  );
end bascule;

architecture Behavioral of bascule is

begin

 sync : process (clk, rst) is

 begin

     if rst = '1' then -- remise à zéro
       sortie <= '0';

     elsif clk'event and clk = '1' then
        if ce ='1' then
          if init
          elsif load_reg = '1' then
                sortie <= entree;
             end if;
        end if;
     end if;
 end process sync;

end Behavioral;
