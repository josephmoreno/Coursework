----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2020 02:03:46 PM
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
    generic (N : integer := 4);
    port (
        clock       :   in std_logic;
        reset       :   in std_logic;
        start_in    :   in std_logic;
        end_in      :   in std_logic;
        din         :   in std_logic_vector (N - 1 downto 0);
        count       :   out std_logic_vector (6 downto 0);
        done        :   out std_logic
    );
end bitPattern_FSM;

architecture FSM_arch of bitPattern_FSM is
    -- FSM declarations;
    -- S0 <- Halted state,
    -- S1 <- Pattern reading state
    type state_type is (S0, S1);
    signal state    :   state_type;

    -- Other signals.
    signal count_reg    :   std_logic_vector (6 downto 0);
    signal reading      :   integer range 0 to 127;
    signal read_4b      :   std_logic_vector (3 downto 0);
    signal done_reg     :   std_logic;
begin
    count <= count_reg;
    done <= done_reg;

    process(clock) begin
        if rising_edge(clock) then
            if (reset = '1') then
                count_reg <= (others => '0');
                reading <= 0;
                state <= S0;
            else
                -- State "switch statement".
                case state is
                    -- Halted state.
                    when S0 =>
                        if (start_in = '1') then
                            -- Reset the count when
                            -- reading for bit patterns.
                            count_reg <= (others => '0');
                            done_reg <= '0';
                            state <= S1;
                        else
                            state <= S0;
                        end if;
                        
                        -- Reset the reading signal.
                        reading <= 0;
                    
                    -- Pattern reading state.
                    when S1 =>
                        if (end_in = '1') then
                            -- User manually ends the
                            -- reading state.
                            done_reg <= '1';
                            state <= S0;
                        else
                            if (reading < N - 3) then
                                -- Using the reading signal to
                                -- extract 4 bits from the input.
                                read_4b <= din ((reading + 3) downto reading);
                                
                                -- Increment count for these bit patterns.
                                if ((read_4b = b"1001") or (read_4b = b"0101")) then
                                    count_reg <= count_reg + 1;
                                end if;
                                
                                -- Increment reading to evaluate
                                -- the next bit field.
                                reading <= reading + 1;
                            else
                                -- Read all possible bit fields;
                                -- done <= '1' and transition to
                                -- the halted state.
                                done_reg <= '1';
                                state <= S0;
                            end if;
                        end if;
                end case;
            end if; -- reset's end if
        end if; -- rising_edge(clock)'s end if
    end process;
end FSM_arch;