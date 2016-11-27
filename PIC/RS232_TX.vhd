----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:21:19 10/20/2016 
-- Design Name: 
-- Module Name:    RS232_TX - Behavioral 
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

entity RS232_TX is
    Port ( Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Start : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (7 downto 0);
           EOT : out  STD_LOGIC;
           TX : out  STD_LOGIC);
end RS232_TX;

architecture Behavioral of RS232_TX is

	component Pulse_Width
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

	type State is (Idle,
						StartBit,
						SendData,
						StopBit);

	signal PresentState, NextState : State;
	signal send : std_logic;
	signal count : std_logic_vector(3 downto 0);
	signal reset_data : std_logic;
	signal reset_control : std_logic;
	
begin

	reset_control <= reset_data and Reset;
	
	Pulse_Control: Pulse_Width
    port map (
      clk   => Clk,
      reset => Reset,
      enable => '1',
      send   => send);
		
	Data_Control: Data_Count
    port map (
      clk   => Clk,
      reset => reset_control,
      enable => send,
      count   => count);


	FFs : process(Clk, Reset)
	begin
		if Reset ='0' then
			PresentState <= Idle;
		elsif Clk'event and Clk = '1' then
			PresentState <= NextState;
		end if;
	end process;
	
	Siguiente : process(PresentState, Start, send, count)
	begin 
		case PresentState is
			when Idle =>
				if Start = '1' then
					NextState <= StartBit;
				else
					NextState <= Idle;
				end if;
			when StartBit =>
				if send ='1' then
					NextState <= SendData;
				else 
					NextState <= StartBit;
				end if;
				
			when SendData =>
				if count = "1000" then
					NextState <= StopBit;
				else
					NextState <= SendData;
				end if;
			
			when StopBit =>
				if send ='1' then
					NextState <= Idle;
				else 
					NextState <= StopBit;
				end if;
			
			when others =>
				NextState <= Idle;
		end case;
	end process;

	Salidas : process(PresentState, count, data)
	begin
		case PresentState is 
			when Idle =>
				EOT <= '1';
				TX <= '1';
				reset_data <= '0';
			when StartBit => 
				EOT <= '0';
				TX <= '0';
				reset_data <= '0';
			when SendData => 
				EOT <= '0';
				reset_data <= '1';
				case count is
					when "0000" => TX <= data(0);
					when "0001" => TX <= data(1);
					when "0010" => TX <= data(2);
					when "0011" => TX <= data(3);
					when "0100" => TX <= data(4);
					when "0101" => TX <= data(5);
					when "0110" => TX <= data(6);
					when "0111" => TX <= data(7);
					when others => TX <= '1';
			end case;
			when StopBit => 
				reset_data <= '0';
				EOT <= '0';
				TX <= '1';
			when others => 
				reset_data <= '0';
				EOT <= '1';
				TX <= '1';
		end case;
	end process;
end Behavioral;

