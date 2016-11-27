----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:16 10/20/2016 
-- Design Name: 
-- Module Name:    Data_Count - Behavioral 
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

entity Data_Count is
	generic(DataEndOfCount : NATURAL := 8);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (3 downto 0));
end Data_Count;

architecture Behavioral of Data_Count is

	signal cuenta : std_logic_vector(3 downto 0) := (others =>'0') ;
	
	
begin
	
	count <= cuenta;
	
	p_counter: process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '0' then
				cuenta <= (others => '0');
				-- cuenta <= to_unsigned(0, 8);
			else 
				if enable = '1' then
					cuenta <= cuenta + 1;
				end if; 
			end if;
			if cuenta = DataEndOfCount then
				cuenta <= (others => '0');
			end if;
		end if;
	end process;


end Behavioral;

