----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2020 12:57:50 PM
-- Design Name: 
-- Module Name: shiftreg_4bit_tb - 
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

entity shiftreg_4bit_tb is
end shiftreg_4bit_tb;

architecture tb_shiftreg_4bit of shiftreg_4bit_tb is
    signal t_clock, t_reset, t_load, t_left :   std_logic;
    signal t_din, t_dout                    :   std_logic_vector (3 downto 0);
begin
    SR_4bit : entity work.shiftreg_4bit(sop_arch)
        port map (
            clock => t_clock,
            reset => t_reset,
            load => t_load,
            left => t_left,
            din => t_din,
            dout => t_dout
        );
        
    -- A 100 MHz clock process.
    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;

    process begin
        -- Initialize inputs.
        t_reset <= '0';
        t_load <= '0';
        t_left <= '0';
    
        -- Load b"1011"
        t_load <= '1';
        t_din <= b"1011";
        wait for 50 ns;
        
        -- Turn off load and shift left twice.
        t_left <= '1';
        t_load <= '0';
        wait for 20 ns;
        
        -- Reset the register.
        t_reset <= '1';
        wait for 50 ns;
        
        -- Turn off reset and load b"1010"
        t_reset <= '0';
        t_load <= '1';
        t_din <= b"1010";
        wait for 50 ns;
        
        -- Turn off load and shift all the bits out to the right.
        t_left <= '0';
        t_load <= '0';
        wait for 100 ns;
        
        -- Testing when load = '1' and reset = '1'; dout should be b"0000".
        t_reset <= '1';
        t_load <= '1';
        t_din <= b"0101";
        wait for 50 ns;
        
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_shiftreg_4bit;