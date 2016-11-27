
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

USE work.PIC_pkg.all;

ENTITY ram IS
PORT (
   Clk      : in    std_logic;
   Reset    : in    std_logic;
   write_en : in    std_logic;
   oe       : in    std_logic;
   address  : in    std_logic_vector(7 downto 0);
   databus  : inout std_logic_vector(7 downto 0);
	Switches : out   std_logic_vector(7 downto 0);
	Temp_L   : out   std_logic_vector(6 downto 0);
	Temp_H   : out   std_logic_vector(6 downto 0));
END ram;

ARCHITECTURE behavior OF ram IS

  SIGNAL contents_ram_general : array8_ram(191 downto 0);			-- 192 posiciones de memoria desde X"40" hasta X"FF"
  SIGNAL contents_ram_specific : array8_ram(63 downto 0);			-- 64 posiciones de memoria desde X"00" hasta X"3F"
  SIGNAL valor_Switch : STD_LOGIC_VECTOR(7 downto 0);
  SIGNAL memory_election : STD_LOGIC;

BEGIN

-------------------------------------------------------------------------
-- Eleccion de Memoria
-------------------------------------------------------------------------
election : process (clk)
begin
	if clk'event and clk = '1' then
		if address > X"3F" then 				-- Memoria general
			memory_election <= '0';
		elsif address < X"40" then				-- Memoria específica
			memory_election <= '1';
		end if;
	end if;
end process;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Memoria de propósito general
-------------------------------------------------------------------------
p_ram : process (clk)  -- no reset
begin
  
  if clk'event and clk = '1' then
    if write_en = '1' and memory_election = '0' then
      contents_ram_general(conv_Integer(address)) <= databus;
    end if;
  end if;

end process;

databus <= contents_ram_general(conv_integer(address)) when (oe = '0' and memory_election = '0')  else
			  contents_ram_specific(conv_integer(address)) when (oe = '0' and memory_election = '1')  else (others => 'Z');
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Memoria de propósito específico
-------------------------------------------------------------------------
pe_ram : process (clk, Reset)
begin
	if reset = '0' then
		contents_ram_specific(conv_Integer(DMA_RX_BUFFER_MSB)) <= (others => '0'); -- Valor de la instrucción
		contents_ram_specific(conv_Integer(DMA_RX_BUFFER_MID)) <= (others => '0');	-- Valor del parámetro 1
		contents_ram_specific(conv_Integer(DMA_RX_BUFFER_LSB)) <= (others => '0'); -- Valor del parámetro 2
		contents_ram_specific(conv_Integer(NEW_INST)) <= (others => '0');				-- Flag que indica llegada de un nuevo comando
		contents_ram_specific(conv_Integer(DMA_TX_BUFFER_MSB)) <= (others => '0');	-- Valor 1 de la Tx
		contents_ram_specific(conv_Integer(DMA_TX_BUFFER_LSB)) <= (others => '0');	-- Valor 2 de la Tx
		contents_ram_specific(conv_Integer(SWITCH_BASE)) <= (others => '0');			-- Valores de control de los interruptores
		contents_ram_specific(conv_Integer(SWITCH_BASE+1)) <= (others => '0');
		contents_ram_specific(conv_Integer(SWITCH_BASE+2)) <= (others => '0');
		contents_ram_specific(conv_Integer(SWITCH_BASE+3)) <= (others => '0');
		contents_ram_specific(conv_Integer(SWITCH_BASE+4)) <= (others => '0');
		contents_ram_specific(conv_Integer(SWITCH_BASE+5)) <= (others => '0');
		contents_ram_specific(conv_Integer(SWITCH_BASE+6)) <= (others => '0');
		contents_ram_specific(conv_Integer(SWITCH_BASE+7)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE)) <= (others => '0');			-- Valores de control de los actuadores
		contents_ram_specific(conv_Integer(LEVER_BASE+1)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+2)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+3)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+4)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+5)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+6)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+7)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+8)) <= (others => '0');
		contents_ram_specific(conv_Integer(LEVER_BASE+9)) <= (others => '0');
		contents_ram_specific(conv_Integer(T_STAT)) <= "00100000"; 						-- Valor de la temperatura en BCD
		
	elsif reset = '1' then
		if clk'event and clk = '1' then
			if write_en = '1' and memory_election = '1' then
				contents_ram_specific(conv_Integer(address)) <= databus;
			end if;
		end if;
	end if;
end process;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Decodificador de BCD a 7 segmentos
-------------------------------------------------------------------------

temp : process(clk)
begin
	if clk'event and clk='1' then 
		case contents_ram_specific(conv_Integer(T_STAT))(7 downto 4) is
			 when "0001" => Temp_H <= "0000110";  -- 1
			 when "0010" => Temp_H <= "1011011"; -- 2
			 when "0011" => Temp_H <= "1001111"; -- 3
			 when "0100" => Temp_H <= "1100110"; -- 4
			 when "0101" => Temp_H <= "1101101"; -- 5
			 when "0110" => Temp_H <= "1111101"; -- 6
			 when "0111" => Temp_H <= "0000111"; -- 7
			 when "1000" => Temp_H <= "1111111"; -- 8
			 when "1001" => Temp_H <= "1101111"; -- 9
			 when "1010" => Temp_H <= "1110111"; -- A
			 when "1011" => Temp_H <= "1111100"; -- B
			 when "1100" => Temp_H <= "0111001"; -- C
			 when "1101" => Temp_H <= "1011110"; -- D
			 when "1110" => Temp_H <= "1111001"; -- E
			 when "1111" => Temp_H <= "1110001"; -- F
			 when others => Temp_H <= "0111111";  -- 0
		end case;
		
		case contents_ram_specific(conv_Integer(T_STAT))(3 downto 0) is
			 when "0001" => Temp_L <= "0000110";  -- 1
			 when "0010" => Temp_L <= "1011011"; -- 2
			 when "0011" => Temp_L <= "1001111"; -- 3
			 when "0100" => Temp_L <= "1100110"; -- 4
			 when "0101" => Temp_L <= "1101101"; -- 5
			 when "0110" => Temp_L <= "1111101"; -- 6
			 when "0111" => Temp_L <= "0000111"; -- 7
			 when "1000" => Temp_L <= "1111111"; -- 8
			 when "1001" => Temp_L <= "1101111"; -- 9
			 when "1010" => Temp_L <= "1110111"; -- A
			 when "1011" => Temp_L <= "1111100"; -- B
			 when "1100" => Temp_L <= "0111001"; -- C
			 when "1101" => Temp_L <= "1011110"; -- D
			 when "1110" => Temp_L <= "1111001"; -- E
			 when "1111" => Temp_L <= "1110001"; -- F
			 when others => Temp_L <= "0111111";  -- 0
		end case;
		
		for i in 0 to 7 loop
			valor_Switch(i) <= contents_ram_specific(conv_Integer(SWITCH_BASE+i))(0);
		end loop;
		Switches <= valor_Switch;
	end if;
end process;
-------------------------------------------------------------------------

END behavior;

