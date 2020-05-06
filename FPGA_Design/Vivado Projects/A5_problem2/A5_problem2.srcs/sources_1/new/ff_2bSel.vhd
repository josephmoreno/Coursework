----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2020 08:41:17 PM
-- Design Name: 
-- Module Name: ff_2bSel - 
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

entity ff_2bSel is
    port (
        in0     :   in std_logic;
        in1     :   in std_logic;
        sel     :   in std_logic;
        clock   :   in std_logic;
        q_out   :   out std_logic
    );
end ff_2bSel;

architecture sop_arch of ff_2bSel is
begin
    process(clock) begin
        if rising_edge(clock) then
            if (sel = '0') then
                q_out <= in0;
            else
                q_out <= in1;
            end if;
        end if;
    end process;                    
end sop_arch;