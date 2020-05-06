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

entity master_tb is
end master_tb;

architecture tb_master of master_tb is
    signal t_go         :   std_logic;
    signal t_reset      :   std_logic;
    signal t_count      :   std_logic;
    signal t_clock      :   std_logic;
    signal t_sel        :   std_logic;
    signal t_seed0      :   std_logic_vector (3 downto 0);
    signal t_seed1      :   std_logic_vector (3 downto 0);
    signal t_quot_in    :   std_logic_vector (3 downto 0);
    signal t_rem_in     :   std_logic_vector (3 downto 0);
    signal t_num0       :   std_logic_vector (3 downto 0);
    signal t_num1       :   std_logic_vector (3 downto 0);
    signal t_correct    :   std_logic;
    signal t_ready      :   std_logic;
begin
    uut : entity work.master(sop_arch)
        port map (
            go => t_go,
            reset => t_reset,
            count => t_count,
            clock => t_clock,
            sel => t_sel,
            seed0 => t_seed0,
            seed1 => t_seed1,
            quot_in => t_quot_in,
            rem_in => t_rem_in,
            num0 => t_num0,
            num1 => t_num1,
            correct => t_correct,
            ready => t_ready
        );
        
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        t_quot_in <= b"0010";
        t_rem_in <= b"0000";
        t_seed1 <= b"1000";
        t_seed0 <= b"0100";
        t_count <= '0';
        t_reset <= '0';
        
        t_go <= '0';
        t_sel <= '0';
        wait until rising_edge(t_clock);
        
        t_sel <= '1';
        wait for 40 ns;
        
        t_sel <= '0';
        wait until rising_edge(t_clock);
        
        t_go <= '1';
        t_count <= '1';
        wait until rising_edge(t_clock);
        
        t_count <= '0';
        wait for 100 ns;
        wait until rising_edge(t_clock);
        
        t_count <= '1';
        wait until rising_edge(t_clock);
        
        t_count <= '0';
        wait for 200 ns;
        
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_master;