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

--process(clk)  -- asignacion de señales a las salidas
--begin
--	if clk'event and clk = '1' then
--		FlagZ <= Flag_Z;
--	end if;
--end process


process(Clk, Databus)
begin
	if Reset = '0' then
		operandoA <= (others => '0');
		operandoB <= (others => '0');
		acumulador <= (others => '0');
		index <= (others => '0');
	elsif Clk'event and Clk = '1' then
		Flag_Z <= '0';
		case u_instruction is
			when nop =>
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
			when op_mvacc2a =>
				operandoA <= acumulador;
			when op_mvacc2b =>
				operandoB <= acumulador;
			when op_add =>
				acumulador <= operandoA + operandoB;
				if acumulador = (others => '0') then
					Flag_Z <= '1';
				end if;
			when op_sub =>
				acumulador <= operandoA - operandoB;
				if acumulador = (others => '0') then
					Flag_Z <= '0';
				end if;
			when op_shiftl =>
				acumulador <= acumulador(7 downto 1) & '0';
			when op_shiftr =>
				acumulador <= '0' & acumulador(6 downto 0);
			when op_and =>
				acumulador <= operandoA and operandoB;
				if acumulador = (others => '0') then
					Flag_Z <= '1';
				end if;
			when op_or =>
				acumulador <= operandoA or operandoB;
				if acumulador = (others => '0') then
					Flag_Z <= '1';
				end if;
			when op_xor =>
				acumulador <= operandoA xor operandoB;
				if acumulador = (others => '0') then
					Flag_Z <= '1';
				end if;
			when op_cmpe =>
				if (operandoA = OperandoB) then
					Flag_Z <= '1';
				end if;
			when op_cmpl =>
				if (operandoA < OperandoB) then
					Flag_Z <= '1';
				end if;
			when op_cmpg =>
				if (operandoA > OperandoB) then
					Flag_Z <= '1';
				end if;
			when op_ascii2bin =>
				if operandoA = 0x30 then
					Databus <= 0;
				elsif operandoA = 0x31 then
					Databus <= 1;
				elsif operandoA = 0x32 then
					Databus <= 2;
				elsif operandoA = 0x33 then
					Databus <= 3;
				elsif operandoA = 0x34 then
					Databus <= 4;
				elsif operandoA = 0x35 then
					Databus <= 5;
				elsif operandoA = 0x36 then
					Databus <= 6;
				elsif operandoA = 0x37 then
					Databus <= 7;
				elsif operandoA = 0x38 then
					Databus <= 8;
				elsif operandoA = 0x39 then
					Databus <= 9;
				else
					Databus <= 0xFF;
				end if;
			when op_bin2ascii =>
				if operandoA = 0 then
					Databus <= 0x30;
				elsif operandoA = 1 then
					Databus <= 0x31;
				elsif operandoA = 2 then
					Databus <= 0x32;
				elsif operandoA = 3 then
					Databus <= 0x33;
				elsif operandoA = 4 then
					Databus <= 0x34;
				elsif operandoA = 5 then
					Databus <= 0x35;
				elsif operandoA = 6 then
					Databus <= 0x36;
				elsif operandoA = 7 then
					Databus <= 0x37;
				elsif operandoA = 8 then
					Databus <= 0x38;
				elsif operandoA = 9 then
					Databus <= 0x39;
				elsif operandoA = 10 then
					Databus <= 0x41;				-- A
				elsif operandoA = 11 then
					Databus <= 0x42;				-- B
				elsif operandoA = 12 then
					Databus <= 0x43;				-- C
				elsif operandoA = 13 then
					Databus <= 0x44;				-- D
				elsif operandoA = 14 then
					Databus <= 0x45;				-- E
				elsif operandoA = 15 then
					Databus <= 0x46;				-- F
				else
					Databus <= 0xFF;
				end if;
			when op_oeacc =>
		end case;
		FlagZ <= Flag_Z;
		Index_Reg <= index;
	end if;
end process;

end Behavioral;

