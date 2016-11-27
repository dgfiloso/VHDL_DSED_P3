----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:24:10 10/20/2016 
-- Design Name: 
-- Module Name:    ShiftRegister - Behavioral 
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

entity ShiftRegister is
    Port ( Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
end ShiftRegister;

architecture Behavioral of ShiftRegister is
	
	signal salida : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	
begin
	
	Q <= salida;
	
	Registro : process (Clk, Reset, Enable)
	
	begin
	
		if Reset = '0' then
			salida <= (others => '0');
		elsif Clk'event and Clk = '1' then
			if Enable = '1' then
				salida (6 downto 0) <= salida (7 downto 1);
				salida(7) <= D;
			end if;
		end if;
	end process;
					
end Behavioral;

