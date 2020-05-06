----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2020 06:34:34 PM
-- Design Name: 
-- Module Name: ms_pulse_tb - 
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

entity ms_pulse_tb is
end ms_pulse_tb;

architecture tb_ms_pulse of ms_pulse_tb is
    signal t_clock, t_reset, t_tick_1ms : std_logic;
begin
    ms_pulse0 : entity work.ms_pulse(sop_arch)
        port map (
            clock => t_clock,
            reset => t_reset,
            tick_1ms => t_tick_1ms
        );
        
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
        
    process begin
        t_reset <= '0';
        wait for 500000 ns;
        t_reset <= '1';
        wait until rising_edge(t_clock);
        t_reset <= '0';
        wait for 2500000 ns;
        
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_ms_pulse;