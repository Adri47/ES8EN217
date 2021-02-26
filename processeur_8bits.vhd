----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.02.2021 14:57:00
-- Design Name: 
-- Module Name: processeur_8bits - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processeur_8bits is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           data_in : out STD_LOGIC_VECTOR (7 downto 0));
end processeur_8bits;

architecture Behavioral of processeur_8bits is

signal carry, sel_ual, load_carry, init_carry, load_reg_accu, load_reg_data, en_mem,read_or_write : std_logic;
signal data_mem_to_reg, data_ut_to_mem  : std_logic_vector (7 downto 0);
signal data_uc_to_mem : std_logic_vector (5 downto 0);

  component unite_de_traitement
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
    
    end component;
    
      component unite_de_commande
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
      
      end component;

      component memoire 
          Port ( 
                 r_w     : in STD_LOGIC;
                 en_mem  : in STD_LOGIC;
                 ce      : in STD_LOGIC;
                 clk     : in STD_LOGIC;
                 address : in STD_LOGIC_VECTOR (5 downto 0);
                 data_out: out STD_LOGIC_VECTOR (7 downto 0);
                 data_in : in STD_LOGIC_VECTOR (7 downto 0)
                 );
      end component;
      
begin

    UC : unite_de_commande
    PORT MAP (
              clk           => clk, 
              rst           => rst,
              ce            => ce,
              data_out      => data_mem_to_reg,
              carry         => carry,     
              adress        => data_uc_to_mem,   
              sel_ual       => sel_ual,
              load_carry    => load_carry,
              init_carry    => init_carry,
              load_reg_accu => load_reg_accu,
              load_reg_data => load_reg_data,
              en_mem        => en_mem,
              read_or_write => read_or_write
                );

    UT : unite_de_traitement 
        Port map (
              clk            => clk,
              rst            => rst,
              ce             => ce,
              sel_ual        => sel_ual,
              load_reg_accu  => load_reg_accu,
              load_reg_data  => load_reg_data,
              load_carry     => load_carry,
              init_carry     => init_carry,
              data_out       => data_mem_to_reg,
              carry          => carry,
              data_in        => data_ut_to_mem
        );
    
    mem : memoire
        port map(
            r_w     => read_or_write,
            en_mem  => en_mem,
            ce      => ce,
            clk     => clk,
            address => data_uc_to_mem,
            data_out=>data_mem_to_reg,
            data_in =>data_ut_to_mem
        );
data_in <= data_ut_to_mem;
data_out<= data_mem_to_reg;
end Behavioral;
