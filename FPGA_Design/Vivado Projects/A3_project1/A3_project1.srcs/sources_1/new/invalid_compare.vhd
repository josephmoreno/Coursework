----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2020 07:55:31 PM
-- Design Name: 
-- Module Name: invalid_compare - 
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

entity invalid_compare is
port (
    a, b    :   in std_logic_vector (3 downto 0);
    z       :   out std_logic
);
end invalid_compare;

architecture dataflow of invalid_compare is
begin
    z <=    '1' when ((a > x"9") or (b > x"9")) else
            '0';
end dataflow;