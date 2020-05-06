----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2020 09:54:31 PM
-- Design Name: 
-- Module Name: ram_8x16 - main_arch
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_8x16 is
    port (
        clock   :   in std_logic;
        w_en    :   in std_logic;
        addr    :   in std_logic_vector (3 downto 0);
        d_in    :   in std_logic_vector (7 downto 0);
        d_out   :   out std_logic_vector (7 downto 0)
    );
end ram_8x16;

architecture main_arch of ram_8x16 is
    type ram_type is array (15 downto 0) of std_logic_vector (7 downto 0);
    signal RAM : ram_type :=
    (0  => x"a2", 1  => x"f3", 2  => x"24", 3  => x"00",
     4  => x"4b", 5  => x"55", 6  => x"03", 7  => x"0d",
     8  => x"01", 9  => x"04", 10 => x"91", 11 => x"07",
     12 => x"06", 13 => x"31", 14 => x"05", 15 => x"07");
begin
    process(clock) begin
        if rising_edge(clock) then
            if (w_en = '1') then
                RAM(conv_integer(addr)) <= d_in;
            end if;
        end if;
    end process;
    
    d_out <= RAM(conv_integer(addr));
end main_arch;