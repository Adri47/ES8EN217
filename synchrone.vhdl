library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synchrone is
  
  port (
    clk : in  std_logic;
    
    D   : in  std_logic; -- Bascule D
    Q   : out std_logic;

    Dd : in std_logic_vector ( 7 downto 0); -- registre parallèle
    Qq : out std_logic_vector (7 downto 0);

    D_decallage : in std_logic; -- resgistre à decallage 8b
    Q_decallage : out std_logic_vector ( 7 downto 0);


    rst : in std_logic; -- compteur 8b
    -- D_compteur : in std_logic;
    Q_compteur : out std_logic_vector ( 7 downto 0)
    
    );

end entity synchrone;

architecture RTL of synchrone is

  signal reg : std_logic_vector(7 downto 0);

begin  -- architecture RTL

  sync : process (clk, rst) is

    
    variable compteur : natural range 0 to 255 := 0;
  begin

    if rst = '1' then -- compteur 8b : rst asynchrone, ne depend pas de la clk
      compteur := 0;
      
      
    elsif clk'event and clk = '1' then 
      Q <= D; -- bascule D
      
      Qq <= Dd; -- registre parallèle 8b

      reg(0) <= D_decallage;  --registre à decallage 8b
      reg(7 downto 1) <= reg(6 downto 0);

      
      compteur := compteur + 1; -- compteur 8b
    end if;
    Q_compteur <= std_logic_vector( to_unsigned (compteur, 8));
  end process sync; 

  Q_decallage( 7 downto 0) <= reg(7 downto 0);

end architecture RTL;
