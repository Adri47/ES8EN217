library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity memoire is
    Port ( r_w : in STD_LOGIC;
           en_mem : in STD_LOGIC;
           ce : in STD_LOGIC;
           clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (5 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           data_in : in STD_LOGIC_VECTOR (7 downto 0)
           );
end memoire;

architecture Behavioral of memoire is

TYPE RAM IS ARRAY (0 to 63) OF std_logic_vector (7 downto 0); -- un tableau (RAM) de 64 cases contenant des données 8 bits 
signal mem:RAM := (X"08",X"47",X"86",X"C4",X"C4",X"00",X"00",X"7E",X"FE",others=>"00000000"); 

begin

    process (clk)
        begin
            if (clk'event and clk = '0') then
                if (ce = '1') then
                    if (en_mem = '1') then
                        if (r_w = '1') then
                             Mem(to_integer(unsigned(address))) <= data_in;
                        else
                            data_out <= Mem(to_integer(unsigned(address)));
                        end if;
                    end if;
                 end if;
             end if;
      end process;
end Behavioral;
