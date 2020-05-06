----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2020 12:19:11 PM
-- Design Name: 
-- Module Name: bitPattern_FSM - 
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

entity bitPattern_FSM is
    port (
        clock       :   in std_logic;
        reset       :   in std_logic;
        start_in    :   in std_logic;
        end_in      :   in std_logic;
        din         :   in std_logic;
        count       :   out std_logic_vector (6 downto 0);
        done        :   out std_logic
    );
end bitPattern_FSM;

architecture FSM_arch of bitPattern_FSM is
    -- FSM declarations.
    type state_type is (s0, s1, s2, s3, s4);
    signal state    :   state_type;

    -- Other signals.
    signal count_reg    :   std_logic_vector (6 downto 0);
    signal pattern      :   std_logic_vector (3 downto 0);
    signal done_reg     :   std_logic;
begin
    count <= count_reg;
    done <= done_reg;
    
    process(clock) begin
        if rising_edge(clock) then
            if (reset = '1') then
                count_reg <= (others => '0');
                done_reg <= '0';
                pattern <= b"0000";
                state <= s0;
            else
                if (end_in = '1') then
                    done_reg <= '1';
                    state <= s0;
                end if;
            
                case state is
                    -- Bit Patterns:
                    -- pat1 = b"1001", pat2 = b"0101"
                
                    -- s0: Halted state.
                    when s0 =>
                        if (start_in = '1') then
                            if (din = '1') then
                                done_reg <= '0';
                                pattern <= b"0001";
                                state <= s1;
                            elsif (din = '0') then
                                done_reg <= '0';
                                pattern <= b"0000";
                                state <= s1;
                            else
                                state <= s0;
                            end if;
                            
                            -- Set count to 0 when
                            -- reading new input.
                            count_reg <= (others => '0');
                        else
                            state <= s0;
                        end if;
                    
                    -- s1: 1 bit in pattern.    
                    when s1 =>
                        if (din = '1') then
                            pattern <= (pattern (2 downto 0)) & '1';
                            state <= s2;
                        elsif (din = '0') then
                            pattern <= (pattern (2 downto 0)) & '0';
                            state <= s2;
                        else
                            state <= s0;
                        end if;
                    
                    -- s2: 2 bits in pattern.
                    when s2 =>
                        if (din = '1') then
                            pattern <= (pattern (2 downto 0)) & '1';
                            state <= s3;
                        elsif (din = '0') then
                            pattern <= (pattern (2 downto 0)) & '0';
                            state <= s3;
                        else
                            state <= s0;
                        end if;
                        
                    -- s3: 3 bits in pattern.
                    when s3 =>
                        if (din = '1') then
                            pattern <= (pattern (2 downto 0)) & '1';
                            state <= s4;
                        elsif (din = '0') then
                            pattern <= (pattern (2 downto 0)) & '0';
                            state <= s4;
                        else
                            state <= s0;
                        end if;
                        
                    -- s4: 4 bits in pattern;
                    --     compare state.
                    when s4 =>
                        if ((pattern = b"1001") or (pattern = b"0101")) then
                            count_reg <= count_reg + 1;
                        end if;
                        
                        if (din = '1') then
                            pattern <= (pattern (2 downto 0)) & '1';
                        elsif (din = '0') then
                            pattern <= (pattern (2 downto 0)) & '0';
                        else
                            state <= s0;
                        end if;
                        
                end case; -- state's end case
            end if; -- reset's end if
        end if; -- rising_edge(clock)'s end if
    end process;
end FSM_arch;