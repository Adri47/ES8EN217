library ieee;
use ieee.std_logic_1164.all;

entity mux is
  
  port (
    Adresse_registre : in  std_logic_vector(7 downto 0);
    Adresse_compteur : in  std_logic_vector(7 downto 0);
    Sel_mux 	     : in  std_logic;
    Adresse_sortie   : out std_logic_vector(7 downto 0);
    );

end entity mux;

architecture RTL of mux is

begin  -- architecture RTL

  mux_8_8 : process (enable) is
  begin
    case enable is
      when "0" => Adresse_sortie <= Adresse_compteur;
      when "1" => Adresse_sortie <= Adresse_registre;

      when others => NULL;
                     
    end case;
    end process mux_8_8;
end architecture RTL;
