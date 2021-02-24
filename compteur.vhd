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
      compteur <= x"00";
      
    elsif clk'event and clk = '1' then 
	   if ce ='1' then
	       if init_cpt = '1' then
	           compteur <= x"00";
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
