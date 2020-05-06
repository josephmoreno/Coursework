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
        
        -- OLED ports
        oled_sdin   :   out std_logic;
        oled_sclk   :   out std_logic;
        oled_dc     :   out std_logic;
        oled_res    :   out std_logic;
        oled_vbat   :   out std_logic;
        oled_vdd    :   out std_logic

        -- Ports used to debug in simulation        
--        temp_oled_r :   out std_logic_vector (4 downto 0);
--        temp_sort_r :   out std_logic
        
--        tempA       :   out std_logic_vector (7 downto 0);
--        tempB       :   out std_logic_vector (7 downto 0);
--        tempOut     :   out std_logic_vector (7 downto 0);
--        tempi       :   out std_logic_vector (3 downto 0);
--        tempj       :   out std_logic_vector (4 downto 0)
    );
end sorter;

architecture main_arch of sorter is
    -- FSM declarations
    type state_type is (s0,  s1,  s2,  s3,
                        s4,  s5,  s6,  s7,
                        s8,  s9,  s10, s11,
                        s12);
    signal state : state_type := s0;
    
    -- Other signals
    signal w_en     :   std_logic;
    signal done_reg :   std_logic;
    signal addr     :   std_logic_vector (3 downto 0);
    signal ram_in   :   std_logic_vector (7 downto 0);
    signal ram_out  :   std_logic_vector (7 downto 0);
    signal count    :   std_logic_vector (3 downto 0);
    signal A        :   std_logic_vector (7 downto 0);
    signal B        :   std_logic_vector (7 downto 0);
    signal oled_r   :   std_logic_vector (4 downto 0);
    signal sort_r   :   std_logic;
begin
    done <= done_reg;

--    tempA <= A;
--    tempB <= B;
--    tempOut <= ram_out;

--    temp_oled_r <= oled_r;
--    temp_sort_r <= sort_r;

    ram0 : entity work.ram_8x16(main_arch)
        port map (
            clock => clock,
            w_en => w_en,
            addr => addr,
            d_in => ram_in,
            d_out => ram_out
        );
    
    oled_ctrl0 : entity work.oled_ctrl(behavioral)
        port map (
            go => done_reg,
            sort_r => sort_r,
            oled_r => oled_r,
            sort_in => ram_out,
        
            clk => clock,
            rst => reset,
            oled_sdin => oled_sdin,
            oled_sclk => oled_sclk,
            oled_dc => oled_dc,
            oled_res => oled_res,
            oled_vbat => oled_vbat,
            oled_vdd => oled_vdd
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
                        sort_r <= '0';
                        
                        if (go = '1') then
                            state <= s1;
                        end if;
                    
                    -- s1: Go state;
                    --     Set i and j with the starting
                    --     memory addresses to be evaluated
                    when s1 =>
                        -- If count == 15, then all
                        -- numbers have been evaluated.
                        if (count = b"1111") then
                            j := b"00000";
                            addr <= j (3 downto 0);
                            done_reg <= '1';
                            sort_r <= '1';
                            state <= s9;
                        else
                            i := count;
                            j := ('0' & (i + 1));
                            addr <= i;
                            state <= s2;
                        end if;
                    
                    -- s2: Set reg A with the value
                    --     from address i
                    when s2 =>
                        A <= ram_out;
                        state <= s3;
                    
                    -- s3: Set the reading address
                    --     to j.
                    when s3 =>
                    -- If j == 16, then all numbers
                    -- have been compared with reg A;
                    -- go back to s1
                    if (j = b"10000") then
                        count <= count + 1;
                        state <= s1;
                    else
                        addr <= j (3 downto 0);
                        state <= s4;
                    end if;
                                            
                    -- s4: Set reg B with the value
                    --     from address j
                    when s4 =>
                        B <= ram_out;
                        state <= s5;
                    
                    -- s5: Compare A and B
                    when s5 =>
                        -- If B < A, then enable
                        -- write and put reg A's
                        -- value into ram_in
                        if (B < A) then
                            ram_in <= A;
                            w_en <= '1';
                            state <= s6;
                        else
                            j := j + 1;
                            state <= s3;
                        end if;
                    
                    -- s6: A is written to address
                    --     j; set writing address
                    --     to i and ram_in to B
                    when s6 =>
                        addr <= i;
                        ram_in <= B;
                        state <= s7;
                    
                    -- s7: Address i and j's values
                    --     have been swapped; update
                    --     A for the next iteration
                    --     and increment j.
                    when s7 =>
                        A <= B;
                        j := j + 1;
                        state <= s8;
                    
                    -- s8: Turn off write enable.
                    when s8 =>
                        w_en <= '0';
                        state <= s3;
                        
                    -- s9: OLED display state;
                    --     the reading address is updated
                    --     after the OLED displays the
                    --     value at the current reading
                    --     address
                    when s9 =>
                        if (j < oled_r) then
                            if (j < b"10000") then
                                j := j + 1;
                                sort_r <= '0';
                                state <= s10;
                            end if;
                        end if;
                    
                    -- s10: sort_r is currently '0' to
                    --      tell the OLED controller
                    --      that the reading address
                    --      is being updated.
                    when s10 =>
                        addr <= j (3 downto 0);
                        state <= s11;
                        
                    -- s11: Turn sort_r to '1' to
                    --      tell the OLED controller
                    --      that the reading address
                    --      is ready.
                    when s11 =>
                        sort_r <= '1';
                        state <= s12;
                        
                    -- s12: Wait 1 clock cycle
                    when s12 =>
                        state <= s9;
                    
                end case;
            end if; -- reset's end if
        end if; -- rising_edge(clock)'s end if
    end process;
end main_arch;