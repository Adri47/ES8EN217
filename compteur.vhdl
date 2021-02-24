library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur is
  
  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    load       : in  std_logic_vector (7 downto 0);
    enable_cpt : in  std_logic;
    init_cpt   : in  std_logic;
    ce         : in  std_logic;
    adresse    : out std_logic_vector (7 downto 0)
    );

end entity compteur;

architecture RTL of compteur is

begin  -- architecture RTL

  sync : process (clk, rst,ce) is
 
 variable compteur : natural range 0 to 255:= 0;

  begin

    if rst = '1'or init_cpt = '1' then -- remise à zéros
      compteur := 0;
      
    elsif clk'event and ce = '1' then 
	if enable_cpt = '1' then
	   compteur := compteur + 1; -- compteur
	else
	   compteur := load
	end if;
    end if;
  
  end process sync; 

end architecture RTL;
