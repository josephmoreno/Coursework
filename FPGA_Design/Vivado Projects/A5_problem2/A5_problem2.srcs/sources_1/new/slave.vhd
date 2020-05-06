----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2020 10:54:36 AM
-- Design Name: 
-- Module Name: slave - 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity slave is
    port (
        reset       :   in std_logic;
        clock       :   in std_logic;
        m_ready     :   in std_logic;
        num0        :   in std_logic_vector (3 downto 0);
        num1        :   in std_logic_vector (3 downto 0);
        quot_out    :   out std_logic_vector (3 downto 0);
        rem_out     :   out std_logic_vector (3 downto 0);
        s_ready     :   out std_logic
    );
end slave;

architecture sop_arch of slave is
    -- FSM declarations
    type state_type is (s0, s1, s2, s3);
    signal state    :   state_type;
    
    -- Other signals
    signal s_ready_reg  :   std_logic;
    
        -- divis is the original divisor
    signal divis        :   std_logic_vector (3 downto 0);
    
        -- divis_reg and divid_reg used for calculations
    signal divis_reg    :   std_logic_vector (7 downto 0);
    signal divid_reg    :   std_logic_vector (7 downto 0);
    
        -- quot and rema used for output, and quot_reg used for
        -- calculations
    signal quot         :   std_logic_vector (3 downto 0);
    signal rema         :   std_logic_vector (3 downto 0);
    signal quot_reg     :   std_logic_vector (3 downto 0);
begin
    s_ready <= s_ready_reg;
    quot_out <= quot;
    rem_out <= rema;

    process(clock) begin
        if rising_edge(clock) then
            if (reset = '1') then
                s_ready_reg <= '1';
                quot_reg <= b"0000";
                state <= s0;
            else
                if (m_ready = '0') then
                    state <= s0;
                end if;
            
                case state is
                    -- s0: Wait for master
                    when s0 =>
                        s_ready_reg <= '1';
                        quot_reg <= b"0000";
                    
                        -- Load the divisor and
                        -- dividend.
                        if (m_ready = '1') then
                            s_ready_reg <= '0';
                            divid_reg <= b"0000" & num1;
                            divis <= num0;
                            divis_reg <= b"0000" & num0;
                            state <= s1;
                        end if;
                    
                    -- s1: Perform calculations.
                    when s1 =>
                        if (divid_reg < divis_reg) then
                            state <= s2;
                        elsif ((divid_reg > divis_reg) or (divid_reg = divis_reg)) then
                            divid_reg <= std_logic_vector(unsigned(divid_reg) - unsigned(divis_reg));
                            quot_reg <= quot_reg + 1;
                        end if;
                    
                    -- s2: Output quotient and remainder
                    --     and signal the slave is ready.
                    when s2 =>
                        quot <= quot_reg;
                        rema <= divid_reg (3 downto 0);
                        s_ready_reg <= '1';
                        state <= s3;
                    
                    -- s3: Wait one clock cycle.    
                    when s3 =>
                        state <= s0;
                    
                end case;
            end if; -- reset's end if
        end if; -- rising_edge(clock)'s end if
    end process;
end sop_arch;