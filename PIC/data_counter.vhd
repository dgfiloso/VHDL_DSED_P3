----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:04:43 11/24/2016 
-- Design Name: 
-- Module Name:    data_counter - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_counter is
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (2 downto 0));
end data_counter;

architecture Behavioral of data_counter is

signal cuenta : std_logic_vector(2 downto 0) := (others =>'0') ;

begin

count <= cuenta;

process(clk, reset, enable, cuenta)
begin
	if clk'event and clk = '1' then	
		if reset = '1' then
			cuenta <= "000";
		elsif enable <= '1' then
			cuenta <= cuenta + 1;
		end if;
	end if;
end process;

end Behavioral;

