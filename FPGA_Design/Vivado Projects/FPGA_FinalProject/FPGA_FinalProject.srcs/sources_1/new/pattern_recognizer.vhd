----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2020 05:53:41 PM
-- Design Name: 
-- Module Name: pattern_recognizer - main_arch
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

entity pattern_recognizer is
    port (
        reset       :   in std_logic;
        go          :   in std_logic;
        clock       :   in std_logic;
        output      :   out std_logic_vector (7 downto 0)
        
        --temp_out    :   out std_logic_vector (7 downto 0);
        --temp_v      :   out std_logic
    );
end pattern_recognizer;

architecture main_arch of pattern_recognizer is
    -- FSM declarations
    type state_type is (s0, s1, s2, s3,
                        s4, s5, s6, s7,
                        s8);
    signal state    :   state_type := s0;
    
    -- Pattern counters
    signal pat0, pat1, pat2     :   std_logic_vector (7 downto 0) := x"00";
    signal pat3, pat4, pat5     :   std_logic_vector (7 downto 0) := x"00";
    signal pat6, pat7, pat8     :   std_logic_vector (7 downto 0) := x"00";
    signal pat9, pat10, pat11   :   std_logic_vector (7 downto 0) := x"00";
    signal pat12, pat13, pat14  :   std_logic_vector (7 downto 0) := x"00";
    signal pat15, pat16, pat17  :   std_logic_vector (7 downto 0) := x"00";
    signal pat18, pat19, pat20  :   std_logic_vector (7 downto 0) := x"00";
    signal pat                  :   std_logic_vector (7 downto 0) := x"00";

-- COUNTERS NEEDED TO KEEP TRACK OF ACTIVE PATTERNS {
    
    -- Group-specific number counters
    -- G0: pat0, pat1, pat2
    -- G1: pat3, pat4, pat5
    -- G2: pat6, pat7, pat8
    -- G3: pat9, pat10, pat11
    -- G4: pat12, pat13, pat14
    -- G5: pat15, pat16, pat17
    -- G6: pat18, pat19, pat20
    
    -- 0x01 / 1, 0x02 / 2, 0x03 / 3
    -- 0x04 / 4, 0x05 / 5, 0x06 / 6 counters
    -- PATTERN-BEGINNING NUMBERS
    signal counter_0x01, counter_0x02, counter_0x03 :   std_logic_vector (7 downto 0) := x"00";    
    signal counter_0x04, counter_0x05, counter_0x06 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x07 / 7 counter
    signal counter_0x07 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x08 / 8 counters
    signal G2counter_0x08, G4counter_0x08, G5counter_0x08   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x09 / 9 counters
    signal G4counter_0x09, G5counter_0x09   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x0a / 10 counter
    signal counter_0x0a :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x0b / 11 counter
    signal counter_0x0b :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x0c / 12 counters
    signal G2counter_0x0c, G4counter_0x0c, G5counter_0x0c   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x0d / 13 counter
    signal counter_0x0d :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x0e / 14 counter
    signal counter_0x0e :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x0f / 15 counters
    signal G0counter_0x0f, G1counter_0x0f, G2counter_0x0f   :   std_logic_vector (7 downto 0) := x"00";
    signal G3counter_0x0f, G6counter_0x0f                   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x10 / 16 counter
    signal counter_0x10 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x11 / 17 counters
    signal G0counter_0x11, G6counter_0x11   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x12 / 18 counters
    signal P12counter_0x12, P13P14counter_0x12  :   std_logic_vector (7 downto 0) := x"00";
    signal P15counter_0x12, P16P17counter_0x12  :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x13 / 19 counters
    signal G0counter_0x13, G6counter_0x13   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x14 / 20 counter
    signal counter_0x14 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x15 / 21 counter
    signal counter_0x15 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x16 / 22 counter
    signal counter_0x16 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x17 / 23 counters
    signal G0counter_0x17, G1counter_0x17, G2counter_0x17   :   std_logic_vector (7 downto 0) := x"00";
    signal G3counter_0x17, G6counter_0x17                   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x18 / 24 counter
    signal counter_0x18 :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x19 / 25 is a PATTERN-ENDING NUMBER
    
    -- 0x1a / 26 is a PATTERN-ENDING NUMBER
    
    -- 0x1b / 27 counters
    signal P18counter_0x1b, P19P20counter_0x1b  :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x1c / 28 counter
    signal counter_0x1c :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x1d / 29 is a PATTERN-ENDING NUMBER
    
    -- 0x1e / 30 counter
    signal counter_0x1e :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x1f / 31 counter
    signal counter_0x1f :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x20 / 32 is a PATTERN-ENDING NUMBER
    
    -- 0x21 / 33 counters
    signal G4counter_0x21, G5counter_0x21   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x22 / 34 counters
    signal G4counter_0x22, G5counter_0x22   :   std_logic_vector (7 downto 0) := x"00";
    
    -- 0x23 / 35 is a PATTERN-ENDING NUMBER
    
    -- 0x24 / 36 is a PATTERN-ENDING NUMBER
    
    -- 0x25 / 37 is a PATTERN-ENDING NUMBER
    
    -- 0x26 / 38 counter; PATTERN-BEGINNING NUMBER
    signal counter_0x26 :   std_logic_vector (7 downto 0) := x"00";
    
-- } END OF COUNTERS NEEDED TO KEEP TRACK OF ACTIVE PATTERNS
    
    -- Main signals
    signal ram_data     :   std_logic_vector (7 downto 0);
    signal addr_reg     :   std_logic_vector (15 downto 0) := x"0000";
    signal violation    :   std_logic := '0';
begin
    ram0 : entity work.ram(main_arch)
        port map (
            addr => addr_reg,
            d_out => ram_data
        );
    
    --temp_v <= violation; -- Used for debugging
    
    process(clock) begin
        if rising_edge(clock) then
            if (reset = '1') then
                state <= s0;
            else
                case state is
                    -- s0: Initial halted state
                    when s0 =>
                        -- Reset all counters
                        counter_0x01 <= x"00";
                        counter_0x02 <= x"00";
                        counter_0x03 <= x"00";
                        counter_0x04 <= x"00";
                        counter_0x05 <= x"00";
                        counter_0x06 <= x"00";
                        counter_0x07 <= x"00";
                        G2counter_0x08 <= x"00";
                        G4counter_0x08 <= x"00";
                        G5counter_0x08 <= x"00";
                        G4counter_0x09 <= x"00";
                        G5counter_0x09 <= x"00";
                        counter_0x0a <= x"00";
                        counter_0x0b <= x"00";
                        G2counter_0x0c <= x"00";
                        G4counter_0x0c <= x"00";
                        G5counter_0x0c <= x"00";
                        counter_0x0d <= x"00";
                        counter_0x0e <= x"00";
                        G0counter_0x0f <= x"00";
                        G1counter_0x0f <= x"00";
                        G2counter_0x0f <= x"00";
                        G3counter_0x0f <= x"00";
                        G6counter_0x0f <= x"00";
                        counter_0x10 <= x"00";
                        G0counter_0x11 <= x"00";
                        G6counter_0x11 <= x"00";
                        P12counter_0x12 <= x"00";
                        P13P14counter_0x12 <= x"00";
                        P15counter_0x12 <= x"00";
                        P16P17counter_0x12 <= x"00";
                        G0counter_0x13 <= x"00";
                        G6counter_0x13 <= x"00";
                        counter_0x14 <= x"00";
                        counter_0x15 <= x"00";
                        counter_0x16 <= x"00";
                        G0counter_0x17 <= x"00";
                        G1counter_0x17 <= x"00";
                        G2counter_0x17 <= x"00";
                        G3counter_0x17 <= x"00";
                        G6counter_0x17 <= x"00";
                        counter_0x18 <= x"00";
                        -- 0x19
                        -- 0x1a
                        P18counter_0x1b <= x"00";
                        P19P20counter_0x1b <= x"00";
                        counter_0x1c <= x"00";
                        -- 0x1d
                        counter_0x1e <= x"00";
                        counter_0x1f <= x"00";
                        -- 0x20
                        G4counter_0x21 <= x"00";
                        G5counter_0x21 <= x"00";
                        G4counter_0x22 <= x"00";
                        G5counter_0x22 <= x"00";
                        -- 0x23
                        -- 0x24
                        -- 0x25
                        counter_0x26 <= x"00";
                        
                        pat0 <= x"00";
                        pat1 <= x"00";
                        pat2 <= x"00";
                        pat3 <= x"00";
                        pat4 <= x"00";
                        pat5 <= x"00";
                        pat6 <= x"00";
                        pat7 <= x"00";
                        pat8 <= x"00";
                        pat9 <= x"00";
                        pat10 <= x"00";
                        pat11 <= x"00";
                        pat12 <= x"00";
                        pat13 <= x"00";
                        pat14 <= x"00";
                        pat15 <= x"00";
                        pat16 <= x"00";
                        pat17 <= x"00";
                        pat18 <= x"00";
                        pat19 <= x"00";
                        pat20 <= x"00";
                        pat <= x"00";
                        
                        -- Set the RAM's read address to x"0000"
                        addr_reg <= x"0000";
                        
                        -- Set violation signal to '0'
                        violation <= '0';
                        
                        if (go = '1') then
                            state <= s1;
                        end if;
                        
                    -- s1: Increment/decrement counters based on input
                    when s1 =>
                        --output <= pat0;  -- Used for debugging
                        --temp_out <= ram_data; -- Used for debugging
                    
                        case ram_data is
                            -- 0x00; end of input stream
                            when x"00" =>
                                state <= s4;
                            
                            -- PATTERN-BEGINNING NUMBERS
                            when x"01" => -- 1
                                counter_0x01 <= counter_0x01 + 1;
                                state <= s2;
                                
                            when x"02" => -- 2
                                counter_0x02 <= counter_0x02 + 1;
                                state <= s2;
                                
                            when x"03" => -- 3
                                counter_0x03 <= counter_0x03 + 1;
                                state <= s2;
                                
                            when x"04" => -- 4
                                counter_0x04 <= counter_0x04 + 1;
                                state <= s2;
                                
                            when x"05" => -- 5
                                counter_0x05 <= counter_0x05 + 1;
                                state <= s2;
                                
                            when x"06" => -- 6
                                counter_0x06 <= counter_0x06 + 1;
                                state <= s2;
                                
                            when x"26" => -- 38
                                counter_0x26 <= counter_0x26 + 1;
                                state <= s2;
                            
                            -- NUMBERS IN BETWEEN
                            when x"07" => -- 7
                                if (counter_0x01 > x"00") then
                                    counter_0x01 <= counter_0x01 - 1;
                                    counter_0x07 <= counter_0x07 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"08" => -- 8
                                if (G4counter_0x09 > x"00") then
                                    G4counter_0x09 <= G4counter_0x09 - 1;
                                    G4counter_0x08 <= G4counter_0x08 + 1;
                                    state <= s2;
                                elsif (G5counter_0x09 > x"00") then
                                    G5counter_0x09 <= G5counter_0x09 - 1;
                                    G5counter_0x08 <= G5counter_0x08 + 1;
                                    state <= s2;
                                elsif (counter_0x26 > x"00") then
                                    counter_0x26 <= counter_0x26 - 1;
                                    G2counter_0x08 <= G2counter_0x08 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"09" => -- 9
                                if (counter_0x04 > x"00") then
                                    counter_0x04 <= counter_0x04 - 1;
                                    G5counter_0x09 <= G5counter_0x09 + 1;
                                    state <= s2;
                                elsif (counter_0x05 > x"00") then
                                    counter_0x05 <= counter_0x05 - 1;
                                    G4counter_0x09 <= G4counter_0x09 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                                
                            when x"0a" => -- 10
                                if (counter_0x06 > x"00") then
                                    counter_0x06 <= counter_0x06 - 1;
                                    counter_0x0a <= counter_0x0a + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"0b" => -- 11
                                if (counter_0x07 > x"00") then
                                    counter_0x07 <= counter_0x07 - 1;
                                    counter_0x0b <= counter_0x0b + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"0c" => -- 12
                                if (G2counter_0x08 > x"00") then
                                    G2counter_0x08 <= G2counter_0x08 - 1;
                                    G2counter_0x0c <= G2counter_0x0c + 1;
                                    state <= s2;
                                elsif (G4counter_0x08 > x"00") then
                                    G4counter_0x08 <= G4counter_0x08 - 1;
                                    G4counter_0x0c <= G4counter_0x0c + 1;
                                    state <= s2;
                                elsif (G5counter_0x08 > x"00") then
                                    G5counter_0x08 <= G5counter_0x08 - 1;
                                    G5counter_0x0c <= G5counter_0x0c + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"0d" => -- 13
                                if (G2counter_0x0c > x"00") then
                                    G2counter_0x0c <= G2counter_0x0c - 1;
                                    counter_0x0d <= counter_0x0d + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"0e" => -- 14
                                if (counter_0x0b > x"00") then
                                    counter_0x0b <= counter_0x0b - 1;
                                    counter_0x0e <= counter_0x0e + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"0f" => -- 15
                                if (counter_0x0d > x"00") then
                                    counter_0x0d <= counter_0x0d - 1;
                                    G2counter_0x0f <= G2counter_0x0f + 1;
                                    state <= s2;
                                elsif (counter_0x0e > x"00") then
                                    counter_0x0e <= counter_0x0e - 1;
                                    G3counter_0x0f <= G3counter_0x0f + 1;
                                    state <= s2;
                                elsif (counter_0x15 > x"00") then
                                    counter_0x15 <= counter_0x15 - 1;
                                    G0counter_0x0f <= G0counter_0x0f + 1;
                                    state <= s2;
                                elsif (counter_0x16 > x"00") then
                                    counter_0x16 <= counter_0x16 - 1;
                                    G1counter_0x0f <= G1counter_0x0f + 1;
                                    state <= s2;
                                elsif (P19P20counter_0x1b > x"00") then
                                    P19P20counter_0x1b <= P19P20counter_0x1b - 1;
                                    G6counter_0x0f <= G6counter_0x0f + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"10" => -- 16
                                if (counter_0x03 > x"00") then
                                    counter_0x03 <= counter_0x03 - 1;
                                    counter_0x10 <= counter_0x10 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"11" => -- 17
                                if (counter_0x02 > x"00") then
                                    counter_0x02 <= counter_0x02 - 1;
                                    G0counter_0x11 <= G0counter_0x11 + 1;
                                    state <= s2;
                                elsif (counter_0x0a > x"00") then
                                    counter_0x0a <= counter_0x0a - 1;
                                    G6counter_0x11 <= G6counter_0x11 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"12" => -- 18
                                if (G4counter_0x09 > x"00") then
                                    G4counter_0x09 <= G4counter_0x09 - 1;
                                    P12counter_0x12 <= P12counter_0x12 + 1;
                                    state <= s2;
                                elsif (G5counter_0x09 > x"00") then
                                    G5counter_0x09 <= G5counter_0x09 - 1;
                                    P15counter_0x12 <= P15counter_0x12 + 1;
                                    state <= s2;
                                elsif (G4counter_0x0c > x"00") then
                                    G4counter_0x0c <= G4counter_0x0c - 1;
                                    P13P14counter_0x12 <= P13P14counter_0x12 + 1;
                                    state <= s2;
                                elsif (G5counter_0x0c > x"00") then
                                    G5counter_0x0c <= G5counter_0x0c - 1;
                                    P16P17counter_0x12 <= P16P17counter_0x12 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"13" => -- 19
                                if (G0counter_0x11 > x"00") then
                                    G0counter_0x11 <= G0counter_0x11 - 1;
                                    G0counter_0x13 <= G0counter_0x13 + 1;
                                    state <= s2;
                                elsif (G6counter_0x11 > x"00") then
                                    G6counter_0x11 <= G6counter_0x11 - 1;
                                    G6counter_0x13 <= G6counter_0x13 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"14" => -- 20
                                if (counter_0x10 > x"00") then
                                    counter_0x10 <= counter_0x10 - 1;
                                    counter_0x14 <= counter_0x14 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"15" => -- 21
                                if (G0counter_0x13 > x"00") then
                                    G0counter_0x13 <= G0counter_0x13 - 1;
                                    counter_0x15 <= counter_0x15 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"16" => -- 22
                                if (counter_0x14 > x"00") then
                                    counter_0x14 <= counter_0x14 - 1;
                                    counter_0x16 <= counter_0x16 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"17" => -- 23
                                if (G0counter_0x0f > x"00") then
                                    G0counter_0x0f <= G0counter_0x0f - 1;
                                    G0counter_0x17 <= G0counter_0x17 + 1;
                                    state <= s2;
                                elsif (G1counter_0x0f > x"00") then
                                    G1counter_0x0f <= G1counter_0x0f - 1;
                                    G1counter_0x17 <= G1counter_0x17 + 1;
                                    state <= s2;
                                elsif (G2counter_0x0f > x"00") then
                                    G2counter_0x0f <= G2counter_0x0f - 1;
                                    G2counter_0x17 <= G2counter_0x17 + 1;
                                    state <= s2;
                                elsif (G3counter_0x0f > x"00") then
                                    G3counter_0x0f <= G3counter_0x0f - 1;
                                    G3counter_0x17 <= G3counter_0x17 + 1;
                                    state <= s2;
                                elsif (G6counter_0x0f > x"00") then
                                    G6counter_0x0f <= G6counter_0x0f - 1;
                                    G6counter_0x17 <= G6counter_0x17 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"18" => -- 24
                                if (G2counter_0x17 > x"00") then
                                    G2counter_0x17 <= G2counter_0x17 - 1;
                                    counter_0x18 <= counter_0x18 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                                
                            when x"1b" => -- 27
                                if (counter_0x0a > x"00") then
                                    counter_0x0a <= counter_0x0a - 1;
                                    P18counter_0x1b <= P18counter_0x1b + 1;
                                    state <= s2;
                                elsif (G6counter_0x13 > x"00") then
                                    G6counter_0x13 <= G6counter_0x13 - 1;
                                    P19P20counter_0x1b <= P19P20counter_0x1b + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                                
                            when x"1c" => -- 28
                                if (G3counter_0x17 > x"00") then
                                    G3counter_0x17 <= G3counter_0x17 - 1;
                                    counter_0x1c <= counter_0x1c + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"1e" => -- 30
                                if (G0counter_0x17 > x"00") then
                                    G0counter_0x17 <= G0counter_0x17 - 1;
                                    counter_0x1e <= counter_0x1e + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"1f" => -- 31
                                if (G1counter_0x17 > x"00") then
                                    G1counter_0x17 <= G1counter_0x17 - 1;
                                    counter_0x1f <= counter_0x1f + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"21" => -- 33
                                if (P13P14counter_0x12 > x"00") then
                                    P13P14counter_0x12 <= P13P14counter_0x12 - 1;
                                    G4counter_0x21 <= G4counter_0x21 + 1;
                                    state <= s2;
                                elsif (P16P17counter_0x12 > x"00") then
                                    P16P17counter_0x12 <= P16P17counter_0x12 - 1;
                                    G5counter_0x21 <= G5counter_0x21 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"22" => -- 34
                                if (G4counter_0x21 > x"00") then
                                    G4counter_0x21 <= G4counter_0x21 - 1;
                                    G4counter_0x22 <= G4counter_0x22 + 1;
                                    state <= s2;
                                elsif (G5counter_0x21 > x"00") then
                                    G5counter_0x21 <= G5counter_0x21 - 1;
                                    G5counter_0x22 <= G5counter_0x22 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            -- PATTERN-ENDING NUMBERS
                            when x"19" => -- 25
                                if (G2counter_0x0c > x"00") then
                                    G2counter_0x0c <= G2counter_0x0c - 1;
                                    -- counter_0x19 <= counter_0x19 + 1;
                                    pat7 <= pat7 + 1;
                                    state <= s2;
                                elsif (counter_0x18 > x"00") then
                                    counter_0x18 <= counter_0x18 - 1;
                                    -- counter_0x19 <= counter_0x19 + 1;
                                    pat8 <= pat8 + 1;
                                    state <= s2;
                                elsif (counter_0x26 > x"00") then
                                    counter_0x26 <= counter_0x26 - 1;
                                    -- counter_0x19 <= counter_0x19 + 1;
                                    pat6 <= pat6 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"1a" => -- 26
                                if (counter_0x02 > x"00") then
                                    counter_0x02 <= counter_0x02 - 1;
                                    -- counter_0x1a <= counter_0x1a + 1;
                                    pat0 <= pat0 + 1;
                                    state <= s2;
                                elsif (G0counter_0x13 > x"00") then
                                    G0counter_0x13 <= G0counter_0x13 - 1;
                                    -- counter_0x1a <= counter_0x1a + 1;
                                    pat1 <= pat1 + 1;
                                    state <= s2;
                                elsif (counter_0x1e > x"00") then
                                    counter_0x1e <= counter_0x1e - 1;
                                    -- counter_0x1a <= counter_0x1a + 1;
                                    pat2 <= pat2 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"1d" => -- 29
                                if (counter_0x01 > x"00") then
                                    counter_0x01 <= counter_0x01 - 1;
                                    -- counter_0x1d <= counter_0x1d + 1;
                                    pat9 <= pat9 + 1;
                                    state <= s2;
                                elsif (counter_0x0b > x"00") then
                                    counter_0x0b <= counter_0x0b - 1;
                                    -- counter_0x1d <= counter_0x1d + 1;
                                    pat10 <= pat10 + 1;
                                    state <= s2;
                                elsif (counter_0x1c > x"00") then
                                    counter_0x1c <= counter_0x1c - 1;
                                    -- counter_0x1d <= counter_0x1d + 1;
                                    pat11 <= pat11 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"20" => -- 32
                                if (counter_0x03 > x"00") then
                                    counter_0x03 <= counter_0x03 - 1;
                                    -- counter_0x20 <= counter_0x20 + 1;
                                    pat3 <= pat3 + 1;
                                    state <= s2;
                                elsif (counter_0x14 > x"00") then
                                    counter_0x14 <= counter_0x14 - 1;
                                    -- counter_0x20 <= counter_0x20 + 1;
                                    pat4 <= pat4 + 1;
                                    state <= s2;
                                elsif (counter_0x1f > x"00") then
                                    counter_0x1f <= counter_0x1f - 1;
                                    -- counter_0x20 <= counter_0x20 + 1;
                                    pat5 <= pat5 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"23" => -- 35
                                if (P12counter_0x12 > x"00") then
                                    P12counter_0x12 <= P12counter_0x12 - 1;
                                    -- counter_0x23 <= counter_0x23 + 1;
                                    pat12 <= pat12 + 1;
                                    state <= s2;
                                elsif (P13P14counter_0x12 > x"00") then
                                    P13P14counter_0x12 <= P13P14counter_0x12 - 1;
                                    -- counter_0x23 <= counter_0x23 + 1;
                                    pat13 <= pat13 + 1;
                                    state <= s2;
                                elsif (G4counter_0x22 > x"00") then
                                    G4counter_0x22 <= G4counter_0x22 - 1;
                                    -- counter_0x23 <= counter_0x23 + 1;
                                    pat14 <= pat14 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"24" => -- 36
                                if (P15counter_0x12 > x"00") then
                                    P15counter_0x12 <= P15counter_0x12 - 1;
                                    -- counter_0x24 <= counter_0x24 + 1;
                                    pat15 <= pat15 + 1;
                                    state <= s2;
                                elsif (P16P17counter_0x12 > x"00") then
                                    P16P17counter_0x12 <= P16P17counter_0x12 - 1;
                                    -- counter_0x24 <= counter_0x24 + 1;
                                    pat16 <= pat16 + 1;
                                    state <= s2;
                                elsif (G5counter_0x22 > x"00") then
                                    G5counter_0x22 <= G5counter_0x22 - 1;
                                    -- counter_0x24 <= counter_0x24 + 1;
                                    pat17 <= pat17 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            when x"25" => -- 37
                                if (P18counter_0x1b > x"00") then
                                    P18counter_0x1b <= P18counter_0x1b - 1;
                                    -- counter_0x25 <= counter_0x25 + 1;
                                    pat18 <= pat18 + 1;
                                    state <= s2;
                                elsif (P19P20counter_0x1b > x"00") then
                                    P19P20counter_0x1b <= P19P20counter_0x1b - 1;
                                    -- counter_0x25 <= counter_0x25 + 1;
                                    pat19 <= pat19 + 1;
                                    state <= s2;
                                elsif (G6counter_0x17 > x"00") then
                                    G6counter_0x17 <= G6counter_0x17 - 1;
                                    -- counter_0x25 <= counter_0x25 + 1;
                                    pat20 <= pat20 + 1;
                                    state <= s2;
                                else
                                    violation <= '1';
                                    state <= s2;
                                end if;
                            
                            -- If any other number, a violation has occurred.
                            when others =>
                                violation <= '1';
                                state <= s2;
                                
                        end case;
                    
                    -- s2: If no violation, increment read address.
                    --     Else, output.
                    when s2 =>
                        if (violation = '0') then
                            addr_reg <= addr_reg + 1;
                            state <= s3;
                        else
                            state <= s4;
                        end if;
                    
                    -- s3: One cycle for updating ram_data
                    when s3 =>
                        state <= s1;
                    
                    -- s4: Load pat into output
                    when s4 =>
                        output <= pat;
                        state <= s5;
                    
                    -- s5: Output currently shows pat; load output with patn
                    --     where n = pat
                    when s5 =>
                        case pat is
                            when x"00" =>
                                output <= pat0;
                                state <= s6;
                            
                            when x"01" =>
                                output <= pat1;
                                state <= s6;
                                
                            when x"02" =>
                                output <= pat2;
                                state <= s6;
                                
                            when x"03" =>
                                output <= pat3;
                                state <= s6;
                            
                            when x"04" =>
                                output <= pat4;
                                state <= s6;
                                
                            when x"05" =>
                                output <= pat5;
                                state <= s6;
                                
                            when x"06" =>
                                output <= pat6;
                                state <= s6;
                                
                            when x"07" =>
                                output <= pat7;
                                state <= s6;
                                
                            when x"08" =>
                                output <= pat8;
                                state <= s6;
                                
                            when x"09" =>
                                output <= pat9;
                                state <= s6;
                                
                            when x"0a" =>
                                output <= pat10;
                                state <= s6;
                                
                            when x"0b" =>
                                output <= pat11;
                                state <= s6;
                                
                            when x"0c" =>
                                output <= pat12;
                                state <= s6;
                                
                            when x"0d" =>
                                output <= pat13;
                                state <= s6;
                                
                            when x"0e" =>
                                output <= pat14;
                                state <= s6;
                                
                            when x"0f" =>
                                output <= pat15;
                                state <= s6;
                                
                            when x"10" =>
                                output <= pat16;
                                state <= s6;
                                
                            when x"11" =>
                                output <= pat17;
                                state <= s6;
                                
                            when x"12" =>
                                output <= pat18;
                                state <= s6;
                                
                            when x"13" =>
                                output <= pat19;
                                state <= s6;
                                
                            when x"14" =>
                                output <= pat20;
                                state <= s6;
                                
                            when others =>
                                state <= s6;
                                
                        end case;
                    
                    -- s6: Output currently shows a pattern counter;
                    --     If pat < 20, increment pat and output.
                    --     Else, go to s7.
                    when s6 =>
                        if (pat < x"14") then
                            pat <= pat + 1;
                            state <= s4;
                        else
                            if (violation = '1') then
                                output <= x"ff"; -- x"ff" signals there is a violation
                                state <= s7;
                            else
                                state <= s8;
                            end if;
                        end if;
                    
                    -- s7: Output index of the violation.
                    when s7 =>
                        output <= addr_reg (7 downto 0);
                        state <= s8;
                    
                    -- s8: Halted state
                    when s8 =>
                        
                        
                end case;
            end if;
        end if;
    end process;
end main_arch;