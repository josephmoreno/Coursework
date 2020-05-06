----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2020 07:10:58 PM
-- Design Name: 
-- Module Name: gt2 - 
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

entity gt2 is
port (
    a, b    :   in std_logic_vector (1 downto 0);
    agtb    :   out std_logic
);
end gt2;

architecture sop_arch of gt2 is
    signal t0, t1, t2, t3, t4   : std_logic;
begin
    -- Sum of Products Term
    agtb <= t0 or (t1 and t2) or (t3 and t4);
    
    -- Terms
    t0 <= (not a(1)) and a(0) and (not b(1)) and (not b(0));
    t1 <= a(1) and (not a(0));
    t2 <= ((not b(1)) and (not b(0))) or ((not b(1)) and b(0));
    t3 <= a(1) and a(0);
    t4 <= ((not b(1)) and (not b(0))) or ((not b(1)) and b(0)) or (b(1) and (not b(0)));
end sop_arch;

architecture struc_arch of gt2 is
    signal gt2_out : std_logic;
begin
    gt2_unit : entity work.gt2(sop_arch)
        port map (
            a => a,
            b => b,
            agtb => gt2_out
        );
        
        agtb <= gt2_out;
end struc_arch;
