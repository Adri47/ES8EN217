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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur is

  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    load       : in  std_logic;
    enable_cpt : in  std_logic;
    init_cpt   : in  std_logic;
    ce         : in  std_logic;
    entree_load: in  std_logic_vector (5 downto 0);
    adresse    : out std_logic_vector (5 downto 0)
    );

end entity compteur;

architecture RTL of compteur is

 signal compteur : std_logic_vector (5 downto 0);

begin  -- architecture RTL

  sync : process (clk, rst) is

  begin

    if rst = '1' then -- remise à zéros
      compteur <= "000000";

    elsif clk'event and clk = '1' then
	   if ce ='1' then
	       if init_cpt = '1' then
	           compteur <= "000000";
	       elsif load = '1' then
                 compteur <= entree_load;
            elsif enable_cpt = '1' then
	           compteur <= std_logic_vector(unsigned(compteur) + 1); -- compteur
	       end if;
        end if;
    end if;
  end process sync;
   adresse <= compteur;
end architecture RTL;
