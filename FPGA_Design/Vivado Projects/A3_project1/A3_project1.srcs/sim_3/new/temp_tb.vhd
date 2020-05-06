library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temp_tb is
end temp_tb;

architecture tb_sop_arch of temp_tb is
    signal test_bcd_in1, test_bcd_in0      :   std_logic_vector (3 downto 0);
    signal test_bin_in                     :   std_logic_vector (6 downto 0);
    signal test_bcd_out1, test_bcd_out0    :   std_logic_vector (3 downto 0);
    signal test_bin_out                    :   std_logic_vector (6 downto 0);
begin
    uut : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => test_bcd_in1,
            bcd_in0 => test_bcd_in0,
            bin_in => test_bin_in,
            bcd_out1 => test_bcd_out1,
            bcd_out0 => test_bcd_out0,
            bin_out => test_bin_out
        );
        
        process begin
            test_bcd_in1 <= b"0001";
            test_bcd_in0 <= b"0001";
            test_bin_in <= b"0000000";
            wait for 500 ns;
            
            assert false
                report "Simulation completed."
            severity failure;
        end process;
end tb_sop_arch;