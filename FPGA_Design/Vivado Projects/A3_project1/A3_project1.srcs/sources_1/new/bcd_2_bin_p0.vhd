----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2020 01:17:42 PM
-- Design Name: 
-- Module Name: bcd_2_bin_p0 - 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_2_bin_p0 is
port (
    bcd_in1, bcd_in0    :   in std_logic_vector (3 downto 0);
    bin_in              :   in std_logic_vector (6 downto 0);
    bcd_out1, bcd_out0  :   out std_logic_vector (3 downto 0);
    bin_out             :   out std_logic_vector (6 downto 0)
);
end bcd_2_bin_p0;

architecture sop_arch of bcd_2_bin_p0 is
    signal bcd_new1, bcd_new0   :   std_logic_vector (3 downto 0);
    signal bin_new              :   std_logic_vector (6 downto 0);
    signal input                :   std_logic_vector (14 downto 0);
    signal comp                 :   std_logic;
    signal invalid_comp         :   std_logic;
begin
    comp_unit : entity work.compare(dataflow)
        port map (
            a => input (10 downto 7),
            z => comp
        );
    
    invalid_comp_unit : entity work.invalid_compare(dataflow)
        port map (
            a => bcd_in1,
            b => bcd_in0,
            z => invalid_comp
        );
    
    -- Logically shift the BCD number right by 1.
    input <=    '0' & (bcd_in1 & bcd_in0 & (bin_in (6 downto 1))) when (invalid_comp = '0') else
                b"000000000000000";
    
    -- When the first BCD digit is greater than 4, subtract by 3.
    -- Else, leave the digit unchanged.
    bcd_new0 <= std_logic_vector(unsigned(input (10 downto 7)) - x"3") when (comp = '1') else
                input (10 downto 7);
    
    bcd_new1 <= input (14 downto 11);
    bin_new <= input (6 downto 0);
    
    -- Send the output through.
    bcd_out1 <= bcd_new1;
    bcd_out0 <= bcd_new0;
    bin_out <= bin_new;
end sop_arch;