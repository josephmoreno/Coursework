----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2020 03:34:04 PM
-- Design Name: 
-- Module Name: sorter_tb - tb_sorter
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

entity sorter_tb is
end sorter_tb;

architecture tb_sorter of sorter_tb is
    signal t_clock      :   std_logic;
    signal t_reset      :   std_logic;
    signal t_go         :   std_logic;
    signal t_done       :   std_logic;
    
    -- OLED signals
    signal t_oled_sdin  :   std_logic;
    signal t_oled_sclk  :   std_logic;
    signal t_oled_dc    :   std_logic;
    signal t_oled_res   :   std_logic;
    signal t_oled_vbat  :   std_logic;
    signal t_oled_vdd   :   std_logic;
    
--    signal temp_oled_r  :   std_logic_vector (4 downto 0);
--    signal temp_sort_r  :   std_logic;

--    signal tempOut     :   std_logic_vector (3 downto 0);
begin
    uut : entity work.sorter(main_arch)
        port map (
            clock => t_clock,
            reset => t_reset,
            go => t_go,
            done => t_done,
            
            -- OLED ports
            oled_sdin => t_oled_sdin,
            oled_sclk => t_oled_sclk,
            oled_dc => t_oled_dc,
            oled_res => t_oled_res,
            oled_vbat => t_oled_vbat,
            oled_vdd => t_oled_vdd
            
--            temp_oled_r => temp_oled_r,
--            temp_sort_r => temp_sort_r,
--            tempOut => tempOut
        );

    process begin
        t_clock <= '0';
        wait for 5 ns;
        t_clock <= '1';
        wait for 5 ns;
    end process;
    
    process begin
        t_reset <= '1';
        t_go <= '0';
        wait for 20 ns;
        
        t_reset <= '0';
        t_go <= '1';
        wait for 180 ns;
        
        t_go <= '0';
        wait for 6 ms;
        
        assert false
            report "Simulation completed."
        severity failure;
    end process;
end tb_sorter;