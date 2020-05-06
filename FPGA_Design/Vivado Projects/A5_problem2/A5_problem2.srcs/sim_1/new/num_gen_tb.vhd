----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2020 11:02:45 PM
-- Design Name: 
-- Module Name: num_gen_tb - 
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

entity num_gen_tb is
end num_gen_tb;

architecture tb_num_gen of num_gen_tb is
    signal t_go, t_clock    :   std_logic;
    signal t_sel            :   std_logic;
    signal t_seed           :   std_logic_vector (3 downto 0);
    signal t_num            :   std_logic_vector (3 downto 0);
begin
    uut : entity work.num_gen(sop_arch)
        port map (
            go => t_go,
            clock => t_clock,
            sel => t_sel,
            seed => t_seed,
            num => t_num
        );
        
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        t_go <= '1';
        t_sel <= '1';
        t_seed <= b"1011";
        wait for 20 ns;
        
        t_sel <= '0';
        wait for 30 ns;
        
        t_go <= '0';
        wait for 50 ns;
        
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_num_gen;