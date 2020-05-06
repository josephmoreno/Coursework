----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2020 02:08:56 PM
-- Design Name: 
-- Module Name: bcd_2_bin - 
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

entity bcd_2_bin is
port (
    bcd_init1, bcd_init0    :   in std_logic_vector (3 downto 0);
    bin_init                :   in std_logic_vector (6 downto 0);
    bcd_final1, bcd_final0  :   out std_logic_vector (3 downto 0);
    bin_final               :   out std_logic_vector (6 downto 0)
);
end bcd_2_bin;

architecture sop_arch of bcd_2_bin is
    -- bcd_out1 signals.
    signal b1_0, b1_1, b1_2 :   std_logic_vector (3 downto 0);
    signal b1_3, b1_4, b1_5 :   std_logic_vector (3 downto 0);
    
    -- bcd_out0 signals.
    signal b0_0, b0_1, b0_2 :   std_logic_vector (3 downto 0);
    signal b0_3, b0_4, b0_5 :   std_logic_vector (3 downto 0);
    
    -- bin_out signals.
    signal bin_0, bin_1, bin_2 :   std_logic_vector (6 downto 0);
    signal bin_3, bin_4, bin_5 :   std_logic_vector (6 downto 0);
begin
    

    -- 7 iterations, so 7 components of bcd_2_bin_p0.
    it0 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => bcd_init1,
            bcd_in0 => bcd_init0,
            bin_in => bin_init,
            bcd_out1 => b1_0,
            bcd_out0 => b0_0,
            bin_out => bin_0
        );
    
    it1 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => b1_0,
            bcd_in0 => b0_0,
            bin_in => bin_0,
            bcd_out1 => b1_1,
            bcd_out0 => b0_1,
            bin_out => bin_1
        );
    
    it2 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => b1_1,
            bcd_in0 => b0_1,
            bin_in => bin_1,
            bcd_out1 => b1_2,
            bcd_out0 => b0_2,
            bin_out => bin_2
        );
    
    it3 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => b1_2,
            bcd_in0 => b0_2,
            bin_in => bin_2,
            bcd_out1 => b1_3,
            bcd_out0 => b0_3,
            bin_out => bin_3
        );
    
    it4 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => b1_3,
            bcd_in0 => b0_3,
            bin_in => bin_3,
            bcd_out1 => b1_4,
            bcd_out0 => b0_4,
            bin_out => bin_4
        );
    
    it5 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => b1_4,
            bcd_in0 => b0_4,
            bin_in => bin_4,
            bcd_out1 => b1_5,
            bcd_out0 => b0_5,
            bin_out => bin_5
        );
    
    it6 : entity work.bcd_2_bin_p0(sop_arch)
        port map (
            bcd_in1 => b1_5,
            bcd_in0 => b0_5,
            bin_in => bin_5,
            bcd_out1 => bcd_final1,
            bcd_out0 => bcd_final0,
            bin_out => bin_final
        );
end sop_arch;