----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Adrien CLAIN
-- 
-- Create Date: 24.02.2021 08:53:16
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           rst : in STD_LOGIC;
           carry : in std_logic;
           code_op : in std_logic_vector (1 downto 0);
           sel_UAL : out STD_LOGIC;
           load_reg_accu : out STD_LOGIC;
           load_reg_data : out STD_LOGIC;
           load_carry : out STD_LOGIC;
           init_carry : out STD_LOGIC;
           load_reg_ins : out STD_LOGIC;
           sel_mux : out STD_LOGIC;
           load_cpt_adr : out STD_LOGIC;
           en_cpt_adr : out STD_LOGIC;
           init_cpt_adr : out STD_LOGIC;
           en_mem : out STD_LOGIC;
           read_or_write : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

TYPE etat IS (Init, Fetch_instruction, Decode, Fetch_operands, Execute_UAL
, Execute_STA, Execute_JCC
);  -- Define the states
signal pr_state , nx_state : Etat := Init ;

begin

 maj_etat : process (clk , rst )
    begin
        if (rst = '1') then 
            pr_state <= Init ;
        elsif (clk'event and clk ='1') then
                if (ce = '1') then
                    pr_state <= nx_state ;
                end if;
        end if;
    end process maj_etat ;

 cal_nx_state : process (pr_state, code_op)
    begin
        case pr_state is
        
            when init =>
               nx_state <= Fetch_instruction;
               
             when Fetch_instruction =>
               nx_state <= Decode;
               
             when Decode =>
                    if (code_op(1) ='0') then
                        nx_state <= Fetch_operands;
                    else if (code_op = "10") then
                            nx_state <= Execute_STA;
                    else if (code_op = "11") then
                            nx_state <= Execute_JCC;
                            end if;
                        end if;
                end if;
                
             when Fetch_operands =>
                nx_state <= Execute_UAL;
                
             when Execute_UAL =>
                nx_state <= Fetch_instruction;
                
             when Execute_STA =>
                nx_state <= Fetch_instruction;
                
             when Execute_JCC =>     
                nx_state <= Fetch_instruction; 
                
         end case;
         
end process cal_nx_state ;

    cal_output : process (pr_state)
        begin
            case pr_state is
                when Init =>
                         sel_UAL <= '0';
                         load_reg_accu <= '0';
                         load_reg_data <= '0';
                         load_carry <= '0';
                         init_carry <= '1';
                         load_reg_ins <= '0';
                         sel_mux <= '0';
                         load_cpt_adr <= '0';
                         en_cpt_adr <= '0';
                         init_cpt_adr <= '1';
                         en_mem <= '0';
                         read_or_write <= '0';
                         
                when Decode =>
                         sel_UAL <= '0';
                         load_reg_accu <= '0';
                         load_reg_data <= '0';
                         load_carry <= '0';
                         init_carry <= '0';
                         load_reg_ins <= '0';
                         sel_mux <= '1';
                         load_cpt_adr <= '0';
                         en_cpt_adr <= '0';
                         init_cpt_adr <= '0';
                         en_mem <= '0';
                         read_or_write <= '0';
                         
                when Fetch_instruction =>
                         sel_UAL <= '0';
                         load_reg_accu <= '0';
                         load_reg_data <= '0';
                         load_carry <= '0';
                         init_carry <= '0';
                         load_reg_ins <= '1';
                         sel_mux <= '0';
                         load_cpt_adr <= '0';
                         en_cpt_adr <= '1';
                         init_cpt_adr <= '0';
                         en_mem <= '1';
                         read_or_write <= '0';
                                   
                when Fetch_operands =>
                         load_reg_data <= '1';
                         sel_mux <= '1';
                         en_mem <= '1';
                         sel_UAL <= '0';
                         load_reg_accu <= '0';
                         load_carry <= '0';
                         init_carry <= '0';
                         load_reg_ins <= '0';
                         load_cpt_adr <= '0';
                         en_cpt_adr <= '0';
                         init_cpt_adr <= '0';
                         read_or_write <= '0';
                         
                when Execute_UAL =>
                         sel_UAL <= code_op(0);
                         load_reg_accu <= '1';
                         load_reg_data <= '0';
                         load_carry <= code_op(0);
                         init_carry <= '0';
                         load_reg_ins <= '0';
                         sel_mux <= '1';
                         load_cpt_adr <= '0';
                         en_cpt_adr <= '0';
                         init_cpt_adr <= '0';
                         en_mem <= '0';
                         read_or_write <= '0';
                         
                when Execute_STA =>
                         sel_UAL <= '0';
                         load_reg_accu <= '0';
                         load_reg_data <= '0';
                         load_carry <= '0';
                         init_carry <= '0';
                         load_reg_ins <= '0';
                         sel_mux <= '1';
                         load_cpt_adr <= '0';
                         en_cpt_adr <= '0';
                         init_cpt_adr <= '0';
                         en_mem <= '1';
                         read_or_write <= '1';
                         
                when Execute_JCC =>
                         sel_UAL <= '0';
                         load_reg_accu <= '0';
                         load_reg_data <= '0';
                         load_carry <= '0';
                         init_carry <= carry;
                         load_reg_ins <= '0';
                         sel_mux <= '1';
                         load_cpt_adr <= not(carry);
                         en_cpt_adr <= '0';
                         init_cpt_adr <= '0';
                         en_mem <= '0';
                         read_or_write <= '0';
            end case;
        end process cal_output ;
end Behavioral;
