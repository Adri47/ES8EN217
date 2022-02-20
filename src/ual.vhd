----------------------------------------------------------------------------------
-- Company:
-- Engineer: Benjamin CHOLLET
--
-- Create Date: 24.02.2021 11:02:55
-- Design Name:
-- Module Name: ual - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ual is
  Port (
    opA     : in  std_logic_vector ( 7 downto 0);
    opB     : in  std_logic_vector ( 7 downto 0);
    sel_ual : in  std_logic;
    carry   : out std_logic;
    S_accu  : out std_logic_vector ( 7 downto 0)
     );
end ual;

architecture Behavioral of ual is

signal result : std_logic_vector ( 8 downto 0);

begin

cal : process (opA, opB, sel_ual) is
begin
    if sel_ual = '1' then
        result <= std_logic_vector(resize(unsigned(opA),9) + resize(unsigned(opB),9));
       -- carry  <= result(8);
    else
        result(7 downto 0) <= opA nor opB;
       -- carry <= '0';
       result(8) <= '0';
     end if;
     
S_accu <= result(7 downto 0);

end process cal;

S_accu <= result(7 downto 0);
carry  <= result(8);
end Behavioral;
