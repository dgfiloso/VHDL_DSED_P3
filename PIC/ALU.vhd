----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:20 11/27/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
	
use work.PIC_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
		port ( Reset : in std_logic; 	-- asynnchronous, active low
				 Clk : in std_logic; -- System clock, 20 MHz, rising_edge
				 u_instruction : in alu_op; -- u-instructions from CPU
				 FlagZ : out std_logic; -- Zero flag
		--		 FlagC : out std_logic; -- Carry flag
		--		 FlagN : out std_logic; -- Nibble carry bit
		--		 FlagE : out std_logic; -- Error flag
				 Index_Reg : out std_logic_vector(7 downto 0); -- Index register
				 Databus : inout std_logic_vector(7 downto 0)); -- System Data bus

end ALU;

architecture Behavioral of ALU is

signal operandoA : std_logic_vector(7 downto 0);
signal operandoB : std_logic_vector(7 downto 0);
signal acumulador : std_logic_vector(7 downto 0);
signal index : std_logic_vector(7 downto 0);
signal Flag_Z: std_logic;

begin

process(Clk, Databus, Reset)
begin
	if Reset = '0' then
		operandoA <= (others => '0');
		operandoB <= (others => '0');
		acumulador <= (others => '0');
		index <= (others => '0');
		Flag_Z <= '0';
		Databus <= (others => 'Z');
	elsif Clk'event and Clk = '1' then
		Flag_Z <= '0';
		case u_instruction is
			when nop =>
				Databus <= (others => 'Z');
			when op_lda =>
				operandoA <= Databus;
			when op_ldb =>
				operandoB <= Databus;
			when op_ldacc =>
				acumulador <= Databus;
			when op_ldid =>
				index <= Databus;
			when op_mvacc2id =>
				index <= acumulador;
				Databus <= (others => 'Z');
			when op_mvacc2a =>
				operandoA <= acumulador;
				Databus <= (others => 'Z');
			when op_mvacc2b =>
				operandoB <= acumulador;
				Databus <= (others => 'Z');
			when op_add =>
				acumulador <= operandoA + operandoB;
				if (operandoA + operandoB) = X"00" then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_sub =>
				acumulador <= operandoA - operandoB;
				if (operandoA - operandoB) = X"00" then
					Flag_Z <= '0';
				end if;
				Databus <= (others => 'Z');
			when op_shiftl =>
				acumulador <= acumulador(7 downto 1) & '0';
				Databus <= (others => 'Z');
			when op_shiftr =>
				acumulador <= '0' & acumulador(6 downto 0);
				Databus <= (others => 'Z');
			when op_and =>
				acumulador <= operandoA and operandoB;
				if (operandoA and operandoB) = X"00" then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_or =>
				acumulador <= operandoA or operandoB;
				if (operandoA or operandoB) = X"00" then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_xor =>
				acumulador <= operandoA xor operandoB;
				if (operandoA xor operandoB) = X"00" then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_cmpe =>
				if (operandoA = OperandoB) then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_cmpl =>
				if (operandoA < OperandoB) then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_cmpg =>
				if (operandoA > OperandoB) then
					Flag_Z <= '1';
				end if;
				Databus <= (others => 'Z');
			when op_ascii2bin =>
				Databus <= (others => 'Z');
				if operandoA = X"30" then
					acumulador <= X"00";
				elsif operandoA = X"31" then
					acumulador <= X"01";
				elsif operandoA = X"32" then
					acumulador <= X"02";
				elsif operandoA = X"33" then
					acumulador <= X"03";
				elsif operandoA = X"34" then
					acumulador <= X"04";
				elsif operandoA = X"35" then
					acumulador <= X"05";
				elsif operandoA = X"36" then
					acumulador <= X"06";
				elsif operandoA = X"37" then
					acumulador <= X"07";
				elsif operandoA = X"38" then
					acumulador <= X"08";
				elsif operandoA = X"39" then
					acumulador <= X"09";
				else
					acumulador <= X"FF";
				end if;
			when op_bin2ascii =>
				Databus <= (others => 'Z');
				if operandoA = 0 then
					acumulador <= X"30";
				elsif operandoA = 1 then
					acumulador <= X"31";
				elsif operandoA = 2 then
					acumulador <= X"32";
				elsif operandoA = 3 then
					acumulador <= X"33";
				elsif operandoA = 4 then
					acumulador <= X"34";
				elsif operandoA = 5 then
					acumulador <= X"35";
				elsif operandoA = 6 then
					acumulador <= X"36";
				elsif operandoA = 7 then
					acumulador <= X"37";
				elsif operandoA = 8 then
					acumulador <= X"38";
				elsif operandoA = 9 then
					acumulador <= X"39";
				elsif operandoA = 10 then
					acumulador <= X"41";				-- A
				elsif operandoA = 11 then
					acumulador <= X"42";				-- B
				elsif operandoA = 12 then
					acumulador <= X"43";				-- C
				elsif operandoA = 13 then
					acumulador <= X"44";				-- D
				elsif operandoA = 14 then
					acumulador <= X"45";				-- E
				elsif operandoA = 15 then
					acumulador <= X"46";				-- F
				else
					acumulador <= X"FF";
				end if;
			when op_oeacc =>
				Databus <= acumulador;
			when others =>
				Databus <= (others => 'Z');
		end case;
		FlagZ <= Flag_Z;
		Index_Reg <= index;
	end if;
end process;

end Behavioral;

