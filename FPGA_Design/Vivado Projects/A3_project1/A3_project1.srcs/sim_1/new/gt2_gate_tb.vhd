----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 03:06:28 PM
-- Design Name: 
-- Module Name: gt2_gate_tb - 
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

entity gt2_gate_tb is
end gt2_gate_tb;

architecture tb_gate_arch of gt2_gate_tb is
    signal test_a, test_b : std_logic_vector (1 downto 0);
    signal test_agtb : std_logic;
begin
    -- Instantiate the gate-level unit under test.
    uut_gate : entity work.gt2(sop_arch)
        port map (
            a => test_a,
            b => test_b,
            agtb => test_agtb
        );
        
    -- The test vector generator
    process
    begin
        -- Test Vector 1
        test_a <= "00";
        test_b <= "00";
        wait for 200 ns;
        
        -- Test Vector 2
        test_a <= "00";
        test_b <= "01";
        wait for 200 ns;
        
        -- Test Vector 3
        test_a <= "00";
        test_b <= "10";
        wait for 200 ns;
        
        -- Test Vector 4
        test_a <= "00";
        test_b <= "11";
        wait for 200 ns;
        
        -- Test Vector 5
        test_a <= "01";
        test_b <= "00";
        wait for 200 ns;
        
        -- Test Vector 6
        test_a <= "01";
        test_b <= "01";
        wait for 200 ns;
        
        -- Test Vector 7
        test_a <= "01";
        test_b <= "10";
        wait for 200 ns;
        
        -- Test Vector 8
        test_a <= "01";
        test_b <= "11";
        wait for 200 ns;
        
        -- Test Vector 9
        test_a <= "10";
        test_b <= "00";
        wait for 200 ns;
        
        -- Test Vector 10
        test_a <= "10";
        test_b <= "01";
        wait for 200 ns;
        
        -- Test Vector 11
        test_a <= "10";
        test_b <= "10";
        wait for 200 ns;
        
        -- Test Vector 12
        test_a <= "10";
        test_b <= "11";
        wait for 200 ns;
        
        -- Test Vector 13
        test_a <= "11";
        test_b <= "00";
        wait for 200 ns;
        
        -- Test Vector 14
        test_a <= "11";
        test_b <= "01";
        wait for 200 ns;
        
        -- Test Vector 15
        test_a <= "11";
        test_b <= "10";
        wait for 200 ns;
        
        -- Test Vector 16
        test_a <= "11";
        test_b <= "11";
        wait for 200 ns;
        
        -- Terminate the simulation.
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_gate_arch;