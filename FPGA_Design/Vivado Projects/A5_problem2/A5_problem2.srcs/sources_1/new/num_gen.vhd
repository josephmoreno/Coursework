----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2020 08:16:58 PM
-- Design Name: 
-- Module Name: num_gen - 
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

entity num_gen is
    port (
        go      :   in std_logic;
        clock   :   in std_logic;
        sel     :   in std_logic;
        seed    :   in std_logic_vector (3 downto 0);
        num     :   out std_logic_vector (3 downto 0)
    );
end num_gen;

architecture sop_arch of num_gen is
    -- FF input signals
    signal ff0_1        :   std_logic;
    signal ff1_1        :   std_logic;
    signal ff2_1        :   std_logic;
    signal ff3_0, ff3_1 :   std_logic;
    signal clock_in     :   std_logic;
    
    -- FF output signals
    signal ff0_out, ff1_out :   std_logic;
    signal ff2_out, ff3_out :   std_logic;
begin
    ff3_0 <= ff2_out xor ff0_out;
    num <= ff3_out & ff2_out & ff1_out & ff0_out;
    
    ff0_1 <= seed(0);
    ff1_1 <= seed(1);
    ff2_1 <= seed(2);
    ff3_1 <= seed(3);
    
    clock_in <= (clock and (go or sel));

    ff3 : entity work.ff_2bSel(sop_arch)
        port map (
            in0 => ff3_0,
            in1 => ff3_1,
            clock => clock_in,
            sel => sel,
            q_out => ff3_out
        );
        
    ff2 : entity work.ff_2bSel(sop_arch)
        port map (
            in0 => ff3_out,
            in1 => ff2_1,
            clock => clock_in,
            sel => sel,
            q_out => ff2_out
        );
    
    ff1 : entity work.ff_2bSel(sop_arch)
        port map (
            in0 => ff2_out,
            in1 => ff1_1,
            clock => clock_in,
            sel => sel,
            q_out => ff1_out
        );
        
    ff0 : entity work.ff_2bSel(sop_arch)
        port map (
            in0 => ff1_out,
            in1 => ff0_1,
            clock => clock_in,
            sel => sel,
            q_out => ff0_out
        );
        
end sop_arch;