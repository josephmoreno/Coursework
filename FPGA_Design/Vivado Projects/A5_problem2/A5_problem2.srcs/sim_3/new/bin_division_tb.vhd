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

entity bin_division_tb is
end bin_division_tb;

architecture tb_bin_division of bin_division_tb is
    signal t_go         :   std_logic;
    signal t_reset      :   std_logic;
    signal t_s_ready    :   std_logic;
    signal t_clock      :   std_logic;
    signal t_sel        :   std_logic;
    signal t_seed0      :   std_logic_vector (3 downto 0);
    signal t_seed1      :   std_logic_vector (3 downto 0);
    signal t_s_quot     :   std_logic_vector (3 downto 0);
    signal t_s_rem      :   std_logic_vector (3 downto 0);
    signal t_num0       :   std_logic_vector (3 downto 0);
    signal t_num1       :   std_logic_vector (3 downto 0);
    signal t_correct    :   std_logic;
    signal t_m_ready    :   std_logic;
begin
    master_unit : entity work.master(sop_arch)
        port map (
            go => t_go,
            reset => t_reset,
            count => t_s_ready,
            clock => t_clock,
            sel => t_sel,
            seed0 => t_seed0,
            seed1 => t_seed1,
            quot_in => t_s_quot,
            rem_in => t_s_rem,
            num0 => t_num0,
            num1 => t_num1,
            correct => t_correct,
            ready => t_m_ready
        );
        
    slave_unit : entity work.slave(sop_arch)
        port map (
            reset => t_reset,
            clock => t_clock,
            m_ready => t_m_ready,
            num0 => t_num0,
            num1 => t_num1,
            quot_out => t_s_quot,
            rem_out => t_s_rem,
            s_ready => t_s_ready
        );    
        
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        t_reset <= '0';
        t_go <= '0';
        t_sel <= '0';
        t_seed1 <= b"1101";
        t_seed0 <= b"0010";
        wait until rising_edge(t_clock);
        wait until rising_edge(t_clock);
        
        t_sel <= '1';
        wait for 30 ns;
        wait until rising_edge(t_clock);
        
        t_sel <= '0';
        wait until rising_edge(t_clock);
        
        t_go <= '1';
        wait for 300 ns;
        
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_bin_division;