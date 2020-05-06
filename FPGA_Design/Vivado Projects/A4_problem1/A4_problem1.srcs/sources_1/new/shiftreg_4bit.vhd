----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2020 12:12:33 PM
-- Design Name: 
-- Module Name: shiftreg_4bit - 
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

entity shiftreg_4bit is
port (
    clock, reset, load, left    :   in std_logic;
    din                         :   in std_logic_vector (3 downto 0);
    dout                        :   out std_logic_vector (3 downto 0)
);
end shiftreg_4bit;

architecture sop_arch of shiftreg_4bit is
    signal dout_reg : std_logic_vector (3 downto 0);
begin
    dout <= dout_reg;

    process(clock) begin
        if rising_edge(clock) then        
            if (reset = '1') then
                dout_reg <= b"0000";
            else
                if (load = '1') then
                    dout_reg <= din;
                elsif (load = '0') then
                    if (left = '1') then
                        dout_reg <= (dout_reg (2 downto 0) & '0');
                    elsif (left = '0') then
                        dout_reg <= ('0' & dout_reg (3 downto 1));
                    else
                        dout_reg <= b"0000";
                    end if;    
                else
                    dout_reg <= b"0000";
                end if;
            end if;
        end if;
    end process;
end sop_arch;