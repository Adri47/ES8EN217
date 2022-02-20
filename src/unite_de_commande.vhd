----------------------------------------------------------------------------------
-- Company:
-- Engineer: Benjamin CHOLLET
--
-- Create Date: 25.02.2021 13:57:42
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


entity unite_de_commande is
  Port (
    clk            : in  std_logic;
    rst            : in  std_logic;
    ce             : in  std_logic;
    data_out       : in  std_logic_vector(7 downto 0); --Data sortante de la mémoire
    carry          : in  std_logic;
    adress         : out std_logic_vector(5 downto 0);  --Data entrante dans la mémoire
    sel_ual        : out std_logic;
    load_carry     : out std_logic;
    init_carry     : out std_logic;
    load_reg_accu  : out std_logic;
    load_reg_data  : out std_logic;
    en_mem         : out std_logic;
    read_or_write  : out std_logic
     );
end unite_de_commande;


architecture Behavioral of unite_de_commande is

  signal out_cpt : std_logic_vector(5 downto 0);
  signal out_reg : std_logic_vector(7 downto 0);
  signal sel_mux, load_cpt_adr,en_cpt_adr,init_cpt_adr,load_reg_ins : std_logic;

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

  component compteur
     Port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        load       : in  std_logic;
        enable_cpt : in  std_logic;
        init_cpt   : in  std_logic;
        ce         : in  std_logic;
        entree_load: in  std_logic_vector (5 downto 0);
        adresse    : out std_logic_vector (5 downto 0)
        );
  end component;

  component fsm
      Port ( 
         clk           : in STD_LOGIC;
         ce            : in STD_LOGIC;
         rst           : in STD_LOGIC;
         carry         : in std_logic;
         code_op       : in std_logic_vector (1 downto 0);
         sel_UAL       : out STD_LOGIC;
         load_reg_accu : out STD_LOGIC;
         load_reg_data : out STD_LOGIC;
         load_carry    : out STD_LOGIC;
         init_carry    : out STD_LOGIC;
         load_reg_ins  : out STD_LOGIC;
         sel_mux       : out STD_LOGIC;
         load_cpt_adr  : out STD_LOGIC;
         en_cpt_adr    : out STD_LOGIC;
         init_cpt_adr  : out STD_LOGIC;
         en_mem        : out STD_LOGIC;
         read_or_write : out STD_LOGIC);
  end component;
  
  component mux
     Port (
        Adresse_registre : in  std_logic_vector(5 downto 0);
        Adresse_compteur : in  std_logic_vector(5 downto 0);
        Sel_mux          : in  std_logic;
        Adresse_sortie   : out std_logic_vector(5 downto 0)
        );
  end component;

  begin
-- port map : signal_composant => signal du top
  multiplexage : mux
    port map (
      Adresse_registre => out_reg(5 downto 0),
      Adresse_compteur => out_cpt,
      Sel_mux          => sel_mux,
      Adresse_sortie   => adress
    );

    registre_data : registre
      port map (
        clk      => clk,
        rst      => rst,
        ce       => ce,
        load_reg => load_reg_ins,
        entree   => data_out,
        sortie   => out_reg
      );

      Compteur_UC : compteur
        port map (
            clk        => clk,
            rst        => rst,
            ce         => ce,
            load       => load_cpt_adr,
            enable_cpt => en_cpt_adr,
            init_cpt   => init_cpt_adr,
            entree_load=> out_reg(5 downto 0),
            adresse    => out_cpt
            
        );

        machine_etat : FSM
          port map(
            clk            => clk,
            ce             => ce,
            rst            => rst,
            carry          => carry,
            code_op        => out_reg(7 downto 6),
            sel_UAL        => sel_UAL,
            load_reg_accu  => load_reg_accu,
            load_reg_data  => load_reg_data,
            load_carry     => load_carry,
            init_carry     => init_carry,
            load_reg_ins   => load_reg_ins,
            sel_mux        => sel_mux,
            load_cpt_adr   => load_cpt_adr,
            en_cpt_adr     => en_cpt_adr,
            init_cpt_adr   => init_cpt_adr,
            en_mem         => en_mem,
            read_or_write  => read_or_write
          );

end Behavioral;
