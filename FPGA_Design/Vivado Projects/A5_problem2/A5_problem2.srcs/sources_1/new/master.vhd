----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2020 12:05:02 AM
-- Design Name: 
-- Module Name: master - 
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

entity master is
    port (
        go      :   in std_logic;
        reset   :   in std_logic;
        count   :   in std_logic;
        clock   :   in std_logic;
        sel     :   in std_logic;
        seed0   :   in std_logic_vector (3 downto 0);
        seed1   :   in std_logic_vector (3 downto 0);
        quot_in :   in std_logic_vector (3 downto 0);
        rem_in  :   in std_logic_vector (3 downto 0);
        num0    :   out std_logic_vector (3 downto 0);
        num1    :   out std_logic_vector (3 downto 0);
        correct :   out std_logic;
        ready   :   out std_logic
    );
end master;

architecture sop_arch of master is
    -- FSM declarations
    type state_type is (s0, s1, s2, s3, s4);
    signal state        :   state_type;

    -- Other signals
    signal clock_in     :   std_logic;
    signal counter_reg  :   std_logic;
    signal num0_reg     :   std_logic_vector (3 downto 0);
    signal num1_reg     :   std_logic_vector (3 downto 0);
    signal correct_quot :   std_logic_vector (3 downto 0);
    signal correct_rem  :   std_logic_vector (3 downto 0);
    signal quot_in_reg  :   std_logic_vector (3 downto 0);
    signal rem_in_reg   :   std_logic_vector (3 downto 0);
    signal correct_reg  :   std_logic;
begin
    clock_in <= (clock and (counter_reg or reset));
    ready <= not counter_reg;
    correct <= correct_reg;
    num0 <= num0_reg;
    num1 <= num1_reg;
    
    -- Used to check slave's output.
    quot_in_reg <= quot_in;
    rem_in_reg <= rem_in;
    correct_reg <=    '1' when ((quot_in_reg = correct_quot) and (rem_in_reg = correct_rem)) else
                      '0';

    num_gen0 : entity work.num_gen(sop_arch)
        port map (
            go => go,
            clock => clock_in,
            sel => sel,
            seed => seed0,
            num => num0_reg
        );
        
    num_gen1 : entity work.num_gen(sop_arch)
        port map (
            go => go,
            clock => clock_in,
            sel => sel,
            seed => seed1,
            num => num1_reg
        );
        
    process(clock) begin
        if rising_edge(clock) then
            if (reset = '1') then
                state <= s0;
            else
                if ((go = '0') and (sel = '0')) then
                    state <= s0;
                end if;
            
                case state is
                    -- s0: Halted state.
                    when s0 =>
                        counter_reg <= '1';
                        
                        if (sel = '1') then
                            state <= s1;
                        else
                            if ((go = '1') and (count = '1')) then
                                state <= s2;
                            end if;
                        end if;
                    
                    -- s1: Load seeds state.    
                    when s1 =>
                        if (sel = '0') then
                            state <= s0;
                        end if;
                    
                    -- s2: num0 and num1 ready;
                    --     load slave and calculate
                    --     correct answers.
                    when s2 =>
                        counter_reg <= '0';
                        state <= s3;
                    
                    -- s3: Wait one clock cycle.
                    when s3 =>
                        correct_quot <= std_logic_vector(unsigned(num1_reg) / unsigned(num0_reg));
                        correct_rem <= std_logic_vector(unsigned(num1_reg) rem unsigned(num0_reg));
                        state <= s4;
                        
                    -- s4: Waiting for the slave's signal.
                    when s4 =>
                        if (count = '1') then
                            counter_reg <= '1';
                            state <= s2;
                        end if;
                
                end case;
            end if; -- reset's end if
        end if; -- rising_edge(clock)'s end if
    end process;    
end sop_arch;