----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2020 03:24:56 PM
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
    -- Inputs
    signal t_clock, t_reset     :   std_logic;
    signal t_start_in, t_end_in :   std_logic;
    signal t_din                :   std_logic;
    
    -- Outputs
    signal t_count              :   std_logic_vector (6 downto 0);
    signal t_done               :   std_logic;
begin
    uut : entity work.bitPattern_FSM(FSM_arch)
        port map (
            clock => t_clock,
            reset => t_reset,
            start_in => t_start_in,
            end_in => t_end_in,
            din => t_din,
            count => t_count,
            done => t_done
        );
        
        -- Clock Process
        -- 10 MHz
        process begin
            t_clock <= '0';
            wait for 5 ns;
            t_clock <= '1';
            wait for 5 ns;
        end process;
        
        process begin
            -- Test Input:
            -- b"1100_1010_1101_0010_0110_1010_1001_1101"
            t_reset <= '0';
            t_din <= '1';
            t_end_in <= '0';
            t_start_in <= '1';
            wait until rising_edge(t_clock);
            
            t_start_in <= '0';
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            --
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
        
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            --
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
        
            --
        
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
        
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
        
            --
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            --
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            --
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            --
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            wait until rising_edge(t_clock);
            
            t_din <= '0';
            wait until rising_edge(t_clock);
            
            t_din <= '1';
            t_end_in <= '1';
            wait until rising_edge(t_clock);
            
            t_end_in <= '0';
            wait for 100 ns;
            
            t_reset <= '1';
            wait for 20 ns;
            
            t_reset <= '0';
            wait for 100 ns;
        
            assert false
                report "Simulation completed."
            severity failure;
        end process;
end tb_bitPattern_FSM;