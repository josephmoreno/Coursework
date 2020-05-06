----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 03:16:09 PM
-- Design Name: 
-- Module Name: gt2_struc_tb - 
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

entity bcd_2_bin_tb is
end bcd_2_bin_tb;

architecture tb_sop_arch of bcd_2_bin_tb is
    signal test_bcdIn1, test_bcdIn0     :   std_logic_vector (3 downto 0);
    signal test_binIn                   :   std_logic_vector (6 downto 0);
    signal test_bcdOut1, test_bcdOut0   :   std_logic_vector (3 downto 0);
    signal test_binOut                  :   std_logic_vector (6 downto 0);
begin
    -- Instantiate the structural unit under test.
    uut : entity work.bcd_2_bin(sop_arch)
        port map (
            bcd_init1 => test_bcdIn1,
            bcd_init0 => test_bcdIn0,
            bin_init => test_binIn,
            bcd_final1 => test_bcdOut1,
            bcd_final0 => test_bcdOut0,
            bin_final => test_binOut
        );
        
    process
    begin
        -- Testing input...
        -- BCD input = 42, binary output = b"0010_1010" = x"2a"
        test_bcdIn1 <= b"0100";
        test_bcdIn0 <= b"0010";
        test_binIn <= b"0000000";
        wait for 200 ns;
        
        -- BCD input = 63, binary output = b"0011_1111" = x"3f"
        test_bcdIn1 <= b"0110";
        test_bcdIn0 <= b"0011";
        wait for 200 ns;
        
        -- BCD input = 27, binary output = b"0001_1011" = x"1b"
        test_bcdIn1 <= b"0010";
        test_bcdIn0 <= b"0111";
        wait for 200 ns;
        
        -- BCD input = 99, binary output = b"0110_0011" = x"63"
        test_bcdIn1 <= b"1001";
        test_bcdIn0 <= b"1001";
        wait for 200 ns;
        
        -- BCD input = 01, binary output = b"0000_0001" = x"01"
        test_bcdIn1 <= b"0000";
        test_bcdIn0 <= b"0001";
        wait for 200 ns;
        
        -- Invalid input = x"f0", binary output = b"0000_0000" = x"00"
        test_bcdIn1 <= b"1111";
        test_bcdIn0 <= b"0000";
        wait for 200 ns;
        
        -- Invalid input = x"0f", binary output = b"0000_0000" = x"00"
        test_bcdIn1 <= b"0000";
        test_bcdIn0 <= b"1111";
        wait for 200 ns;
        
        -- Invalid input = x"ff", binary output = b"0000_0000" = x"00"
        test_bcdIn1 <= b"1111";
        test_bcdIn0 <= b"1111";
        wait for 200 ns;
    
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_sop_arch;