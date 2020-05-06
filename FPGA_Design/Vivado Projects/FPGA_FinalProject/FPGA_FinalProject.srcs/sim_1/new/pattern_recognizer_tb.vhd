----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2020 06:35:01 PM
-- Design Name: 
-- Module Name: pattern_recognizer_tb - tb_pattern_recognizer
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

entity pattern_recognizer_tb is
end pattern_recognizer_tb;

architecture tb_pattern_recognizer of pattern_recognizer_tb is
    signal t_reset  :   std_logic;
    signal t_go     :   std_logic;
    signal t_clock  :   std_logic;
    signal t_output :   std_logic_vector (7 downto 0);
    
    --signal t_temp   :   std_logic_vector (7 downto 0);
    --signal t_v      :   std_logic;
begin
    uut : entity work.pattern_recognizer(main_arch)
        port map (
            reset => t_reset,
            go => t_go,
            clock => t_clock,
            output => t_output
            
            --temp_out => t_temp,
            --temp_v => t_v
        );
        
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        t_reset <= '0';
        t_go <= '1';
        wait for 20 ns;
        
        t_go <= '0';
        wait for 5000 ns;
    
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_pattern_recognizer;