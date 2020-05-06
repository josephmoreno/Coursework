----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2020 06:02:14 PM
-- Design Name: 
-- Module Name: ms_pulse - 
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

entity ms_pulse is
port (
    clock       :   in std_logic;
    reset       :   in std_logic;
    tick_1ms    :   out std_logic
);
end ms_pulse;

architecture sop_arch of ms_pulse is
    signal count    :   std_logic_vector (19 downto 0);
begin
    tick_1ms <= '1' when (count = x"186a0") else
                '0';

    process(clock) begin
        if rising_edge(clock) then
            if (reset = '1') then
                count <= (others => '0');
            else
                if (count = x"186a0") then
                    count <= (0 => '1', others => '0');
                elsif (count < x"186a0") then
                    count <= count + 1;
                else
                    count <= (others => '0');    
                end if;
            end if;
        end if;
    end process;
end sop_arch;