library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity enable_cpt is
  
  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    ce         : out std_logic;
    );

end entity enable_cpt;

architecture RTL of enable_cpt is

  signal reg : std_logic_vector(7 downto 0);

begin  -- architecture RTL

  sync : process (clk, rst) is
  variable compteur : natural range 0 to 255:= 0;

  begin

    if rst = '1'or init_cpt = '1' then -- remise à zéros
      compteur := 0;
      
   
    elsif clk'event and clk = '1' then 
      compteur := compteur + 1; -- compteur 8b
    end if;
  
  end process sync; 

end architecture RTL;
