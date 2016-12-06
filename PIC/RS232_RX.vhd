----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:41 10/20/2016 
-- Design Name: 
-- Module Name:    RS232_RX - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS232_RX is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           LineRD_in : in  STD_LOGIC;
           Valid_out : out  STD_LOGIC;
           Code_out : out  STD_LOGIC;
           Store_out : out  STD_LOGIC);
end RS232_RX;

architecture Behavioral of RS232_RX is

 -------------- Componentes ------------------
component Pulse_Width
	 generic (PulseEndOfCount : NATURAL);
    port (
      clk   : in  std_logic;
      reset : in  std_logic;
      enable : in  std_logic;
      send    : out std_logic);
  end component;
  
component Data_Count
    port (
      clk   : in  std_logic;
      reset : in  std_logic;
      enable : in  std_logic;
      count : out  STD_LOGIC_VECTOR (3 downto 0));
  end component;

 ---------------- Estados de la Maquina ------------
	type State is (Idle,
						StartBit,
						RcvData,
						StopBit);
						
 ------------------ Señales -------------------------
	signal PresentState, NextState : State;
	signal bit_out : std_logic;
	signal half_bit_out : std_logic;
	signal count : std_logic_vector(3 downto 0);
	signal reset_data : std_logic;
	signal reset_control : std_logic;
	--signal reset_half : std_logic;
	signal enable_half : std_logic;
	
	signal enable_bitcounter : std_logic;
	
	
begin
	
	reset_control <= reset_data and Reset;
	--reset_half <= Reset and (not bit_out);


	
 ------------------- PORT MAP ----------------------
 
	BitCounter: Pulse_Width
	generic map (PulseEndOfCount => 174)
    port map (
      clk   => Clk,
      reset => Reset,
      enable => enable_bitcounter,
      send   => bit_out);
		
	HalfBitCounter: Pulse_Width
	 generic map (PulseEndOfCount => 87)
    port map (
      clk   => Clk,
      reset => Reset,
      enable => enable_half,
      send   => half_bit_out);
		
	Data_Control: Data_Count
    port map (
      clk   => Clk,
      reset =>  reset_control,
      enable => bit_out,
      count   => count);
		
	enable_half_counter: process(clk, Reset, bit_out, half_bit_out, enable_half)
	begin
		if Reset = '0' then
			enable_half <= '0';
		elsif clk'event and clk = '1' then
			if half_bit_out = '1' or bit_out = '1' then
				enable_half <= not enable_half;
			end if;
		end if;
	end process;

 --------------------- MAQUINA DE ESTADOS ----------------

	FFs : process(Clk, Reset)
	begin
		if Reset ='0' then
			PresentState <= Idle;
		elsif Clk'event and Clk = '1' then
			PresentState <= NextState;
		end if;
	end process;
	
	Siguiente : process(PresentState, LineRD_in, bit_out, count)
	begin 
		case PresentState is
			when Idle =>
				if LineRD_in = '0' then
					NextState <= StartBit;
				else
					NextState <= Idle;
				end if;
			when StartBit =>
				if bit_out ='1' then
					NextState <= RcvData;
				else 
					NextState <= StartBit;
				end if;
				
			when RcvData =>
				if count = "1000" then
					NextState <= StopBit;
				else
					NextState <= RcvData;
				end if;
			
			when StopBit =>
				if bit_out ='1' then
					NextState <= Idle;
				else 
					NextState <= StopBit;
				end if;
			
			when others =>
				NextState <= Idle;
		end case;
	end process;

	Salidas : process(PresentState, half_bit_out, count, LineRD_in)
	begin
		case PresentState is 
			when Idle =>
				Valid_out <= '0';
				Code_out <= '0';
				Store_out <= '0';
				reset_data <= '0';
				enable_bitcounter <= '0';
			when StartBit => 
				Valid_out <= '0';
				Code_out <= '0';
				Store_out <= '0';
				reset_data <= '0';
				enable_bitcounter <= '1';
			when RcvData =>
				Store_out <= '0';
				reset_data <= '1';
				Code_out <= '0';
				Valid_out <= '0';
				enable_bitcounter <= '1';
				if half_bit_out = '1' then
					case count is
						when "0000" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0001" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0010" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0011" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0100" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0101" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0110" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when "0111" => 
							Code_out <= LineRD_in;
							Valid_out <= '1';
						when others => 
							Code_out <= '0';
							Valid_out <= '0';
					end case;
				end if;
			when StopBit => 
				enable_bitcounter <= '1';
				if half_bit_out = '1' and LineRD_in = '1' then
					Valid_out <= '0';
					Code_out <= '0';
					Store_out <= '1';
					reset_data <= '0';
				else
					Valid_out <= '0';
					Code_out <= '0';
					Store_out <= '0';
					reset_data <= '0';
				end if;
			when others => 
				Valid_out <= '0';
				Code_out <= '0';
				Store_out <= '0';
				reset_data <= '0';
				enable_bitcounter <= '0';
		end case;
	end process;


end Behavioral;

