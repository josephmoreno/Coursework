----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2020 04:58:02 PM
-- Design Name: 
-- Module Name: ram - main_arch
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram is
    port (
        addr    :   in std_logic_vector (15 downto 0);
        d_out   :   out std_logic_vector (7 downto 0)
    );
end ram;

architecture main_arch of ram is
    type ram_type is array (0 to 65535) of std_logic_vector (7 downto 0);
    
    impure function InitRamFromFile (RamFileName : in string) return ram_type is
        FILE RamFile : text is in RamFileName;
        variable RamFileLine : line;
        variable RAM : ram_type;
    begin
        for I in ram_type'range loop
            readline(RamFile, RamFileLine);
            hread(RamFileLine, RAM(I));
        end loop;
        
        return RAM;
    end function;
    
    signal RAM : ram_type := InitRamFromFile("t1.hex");
begin
    d_out <= RAM(conv_integer(addr));
end main_arch;