----------------------------------------------------------------------------------
-- Company:
-- Engineer: Benjamin CHOLLET
--
-- Create Date: 24.02.2021 13:49:00
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


entity unite_de_traitement is
  Port (
    clk            : in  std_logic;
    rst            : in  std_logic;
    ce             : in  std_logic;
    sel_ual        : in  std_logic;
    load_reg_accu  : in  std_logic;
    load_reg_data  : in  std_logic;
    load_carry     : in  std_logic;
    init_carry     : in  std_logic;
    data_out       : in  std_logic_vector(7 downto 0); --Data sortante de la mémoire
    carry          : out std_logic;
    data_in        : out std_logic_vector(7 downto 0)  --Data entrante dans la mémoire
     );
end unite_de_traitement;

  signal reg_data_out, reg_accu_out, out_ual_data : std_logic_vector(7 downto 0);
  signal out_ual_carry : std_logic;

architecture Behavioral of unite_de_traitement is

  component registre
    Port (
      clk        : in  std_logic;
      rst        : in  std_logic;
      ce         : in  std_logic;
      load_reg   : in  std_logic;
      entree     : in  std_logic_vector (7 downto 0);
      sortie     : out std_logic_vector (7 downto 0)
    );
  end component ;

  component bascule
    Port (
      clk        : in  std_logic;
      rst        : in  std_logic;
      ce         : in  std_logic;
      load_carry : in  std_logic;
      init_carry : in  std_logic;
      entree     : in  std_logic;
      sortie     : out std_logic
    );
  end component;

  component ual
    Port (
      opA     : in  std_logic_vector ( 7 downto 0);
      opB     : in  std_logic_vector ( 7 downto 0);
      sel_ual : in  std_logic;
      carry   : out std_logic;
      S_accu  : out std_logic_vector ( 7 downto 0)
       );
  end component;

  begin
-- port map : signal_composant => signal du top
  registre_accu : regsitre
    port map (
      clk      => clk,
      rst      => rst,
      ce       => ce,
      load_reg => load_reg_accu,
      entree   => out_ual_data,
      sortie   => reg_accu_out
    );

    registre_data : regsitre
      port map (
        clk      => clk,
        rst      => rst,
        ce       => ce,
        load_reg => load_reg_data,
        entree   => data_out,
        sortie   => reg_data_out
      );

      bascule_carry : bascule_carry
        port map (
          clk        => clk,
          rst        => rst,
          ce         => ce,
          load_carry => load_carry,
          init_carry => init_cpt,
          entree     => out_ual_carry,
          sortie     => carry
        );

        UAL : ual
          port map(
            opA     => reg_data_out,
            opB     => reg_accu_out,
            sel_ual => sel_ual,
            carry   => out_ual_carry,
            S_accu  => out_ual_data
          );
data_in <= reg_accu_out;

end Behavioral;
