----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2020 10:33:10 PM
-- Design Name: 
-- Module Name: sorter - main_arch
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

entity sorter is
    port (
        clock       :   in std_logic;
        reset       :   in std_logic;
        go          :   in std_logic;
        done        :   out std_logic;
        
        tempOut     :   out std_logic_vector (7 downto 0)
        
--        tempA       :   out std_logic_vector (7 downto 0);
--        tempB       :   out std_logic_vector (7 downto 0);
--        tempi       :   out std_logic_vector (3 downto 0);
--        tempj       :   out std_logic_vector (4 downto 0)
    );
end sorter;

architecture main_arch of sorter is
    -- FSM declarations
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
    signal state : state_type;
    
    -- Other signals
    signal w_en     :   std_logic;
    signal done_reg :   std_logic;
    signal addr     :   std_logic_vector (3 downto 0);
    signal ram_in   :   std_logic_vector (7 downto 0);
    signal ram_out  :   std_logic_vector (7 downto 0);
    signal count    :   std_logic_vector (3 downto 0);
    signal A        :   std_logic_vector (7 downto 0);
    signal B        :   std_logic_vector (7 downto 0);
begin
    done <= done_reg;

--    tempA <= A;
--    tempB <= B;
    tempOut <= ram_out;

    ram0 : entity work.ram_8x16(main_arch)
        port map (
            clock => clock,
            w_en => w_en,
            addr => addr,
            d_in => ram_in,
            d_out => ram_out
        );

    process(clock)
        variable i      :   std_logic_vector (3 downto 0);
        variable j      :   std_logic_vector (4 downto 0);
    begin
--        tempi <= i;
--        tempj <= j;
    
        if rising_edge(clock) then
            if (reset = '1') then
                state <= s0;
            else
                case state is
                    
                    -- s0: Halted state
                    when s0 =>
                        count <= b"0000";
                        done_reg <= '0';
                        
                        if (go = '1') then
                            state <= s1;
                        end if;
                    
                    -- s1: 
                    when s1 =>
                        if (count = b"1111") then
                            addr <= b"0000";
                            done_reg <= '1';
                            state <= s9;
                        else
                            i := count;
                            j := ('0' & (i + 1));
                            addr <= i;
                            state <= s2;
                        end if;
                    
                    -- s2: 
                    when s2 =>
                        A <= ram_out;
                        state <= s3;
                    
                    -- s3:    
                    when s3 =>
                    if (j = b"10000") then
                        count <= count + 1;
                        state <= s1;
                    else
                        addr <= j (3 downto 0);
                        state <= s4;
                    end if;
                                            
                    -- s4: 
                    when s4 =>
                        B <= ram_out;
                        state <= s5;
                    
                    -- s5: 
                    when s5 =>
                        if (B < A) then
                            ram_in <= A;
                            w_en <= '1';
                            state <= s6;
                        else
                            j := j + 1;
                            state <= s3;
                        end if;
                    
                    -- s6: 
                    when s6 =>
                        addr <= i;
                        ram_in <= B;
                        state <= s7;
                    
                    -- s7:     
                    when s7 =>
                        A <= B;
                        j := j + 1;
                        state <= s8;
                    
                    -- s8: 
                    when s8 =>
                        w_en <= '0';
                        state <= s3;
                        
                    -- s9:
                    when s9 =>
                        if (addr < b"1111") then
                            addr <= addr + 1;
                        end if;
                    
                end case;
            end if; -- reset's end if
        end if; -- rising_edge(clock)'s end if
    end process;
end main_arch;