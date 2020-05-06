----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2020 03:49:20 PM
-- Design Name: 
-- Module Name: bitPattern_FSM_tb - 
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

entity bitPattern_FSM_tb is
end bitPattern_FSM_tb;

architecture tb_bitPattern_FSM of bitPattern_FSM_tb is
    signal t_clock, t_reset     :   std_logic;   
    signal t_start_in, t_end_in :   std_logic;
    signal t_done               :   std_logic;
    signal t_din                :   std_logic_vector (31 downto 0);
    signal t_count              :   std_logic_vector (6 downto 0);
begin
    uut : entity work.bitPattern_FSM(FSM_arch)
        generic map (N => 32)
        port map (
            clock => t_clock,
            reset => t_reset,
            start_in => t_start_in,
            end_in => t_end_in,
            din => t_din,
            count => t_count,
            done => t_done
        );
        
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        t_reset <= '0';
        t_din <= b"11001010110100100110101010011101";
        t_start_in <= '1';
        t_end_in <= '0';
        wait for 20 ns;
        
        t_start_in <= '0';
        wait for 480 ns;
    
        assert false
            report "Simulation completed."
        severity failure;
    end process;        
end tb_bitPattern_FSM;