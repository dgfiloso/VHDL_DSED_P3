----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:51 10/20/2016 
-- Design Name: 
-- Module Name:    Pulse_width - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pulse_width is
	 generic(PulseEndOfCount : NATURAL := 174);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           send : out  STD_LOGIC);
end Pulse_width;

architecture Behavioral of Pulse_width is

	signal cuenta : std_logic_vector(7 downto 0) := (others =>'0') ;
	signal salida : std_logic := '0';
	
	
begin
	
	send <= salida;
	
	p_counter: process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '0' then
				cuenta <= (others => '0');
			else 
				if enable = '1' then
					cuenta <= cuenta + 1;
				elsif enable = '0' then
					cuenta <= (others => '0'); 
				end if; 
			end if;
			if cuenta = PulseEndOfCount then
				salida <= '1';
				cuenta <= (others => '0');
			else
				salida <= '0';
			end if;
		end if;
	end process;
	
end Behavioral;

