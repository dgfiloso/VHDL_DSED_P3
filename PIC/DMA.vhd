----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:45:37 11/17/2016 
-- Design Name: 
-- Module Name:    DMA - Behavioral 
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

USE work.PIC_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DMA is
    Port ( Reset 			: in  STD_LOGIC;
           Clk 			: in  STD_LOGIC;
           RCVD_Data 	: in  STD_LOGIC_VECTOR (7 downto 0);
           RX_Full 		: in  STD_LOGIC;
           RX_Empty 		: in  STD_LOGIC;
           Data_Read 	: out  STD_LOGIC;
           ACK_out 		: in  STD_LOGIC;
           TX_RDY 		: in  STD_LOGIC;
           Valid_D 		: out  STD_LOGIC;
           TX_Data 		: out  STD_LOGIC_VECTOR (7 downto 0);
           Address 		: out  STD_LOGIC_VECTOR (7 downto 0);
           Databus 		: inout  STD_LOGIC_VECTOR (7 downto 0);
           Write_en 		: out  STD_LOGIC;
           OE 				: out  STD_LOGIC;
           DMA_RQ 		: out  STD_LOGIC;
           DMA_ACK 		: in  STD_LOGIC;
           Send_comm 	: in  STD_LOGIC;
           READY 			: out  STD_LOGIC;
			  FF_Count		: in STD_LOGIC_VECTOR(5 downto 0));
end DMA;

architecture Behavioral of DMA is

	type State is
		(Idle, Tx, Wait_Buses, Rx);
	signal current_state, next_state : State;
	
	signal end_reception : STD_LOGIC;
	signal begin_tx : STD_LOGIC;

	component data_counter
      port (
         clk   : in  std_logic;
         reset : in  std_logic;
         enable : in  std_logic;
         count   : out std_logic_vector(2 downto 0));
   end component;
	
	signal reset_counter : STD_LOGIC;
	signal enable_counter : STD_LOGIC;
	signal count : STD_LOGIC_VECTOR (2 downto 0);
	
begin
	
	-- Contador de bytes a transmitir o recibir
BitCounter: data_counter
    port map (
      clk   => Clk,
      reset => reset_counter,
      enable => enable_counter,
      count  => count);

clock : process (Reset, Clk)
begin
	if Reset = '0' then
		current_state <= Idle;
	elsif clk'event and clk = '1' then
		current_state <= next_state;
	end if;
end process;

changes : process (clk, current_state, RX_Empty, Send_comm, DMA_ACK, end_reception, begin_tx, FF_Count)
begin 
	case current_state is
		when Idle =>
						--	Cuando hay tres bytes en la fifo, tomamos los buses y los guardamos en la ram
			if FF_Count = "000011" then			 
				next_state <= Wait_Buses;
			elsif Send_comm = '1' then
				next_state <= Tx;
			else
				next_state <= Idle;
			end if;
			
		-- Reception --
		
		when Wait_Buses =>
			if DMA_ACK = '1' then
				next_state <= Rx;
			else 
				next_state <= Wait_Buses;
			end if;
		when Rx =>
			if DMA_ACK = '0' then
				next_state <= Idle;
			else
				next_state <= Rx;
			end if;
			
		-- Transmission --
		
		when Tx =>
			if Send_comm = '0' then
				next_state <= Idle;
			else 
				next_State <= Tx;
			end if;
	end case;
end process;

outputs : process (current_state, RCVD_Data, Databus, Send_comm, count)
begin
	Data_Read <= '0';    
	Valid_D <= '0';      
	Address <= (others => 'Z');
	Databus <= (others => 'Z');
	TX_Data <= (others => '0');
	Write_en <= 'Z';
	OE <= 'Z';
	READY <= '1';
	enable_counter <= '0';
	reset_counter <= '1';
	
	case current_state is
			
		-- Reception --
		when Idle =>
			DMA_RQ <= '0';
			if Send_comm = '1' then
				READY <= not Send_comm;
			end if;
		when Wait_Buses =>
			DMA_RQ <= '1';
		when  Rx =>
			Databus <= RCVD_Data;
			enable_counter <= '1';
			reset_counter <= '0';
			case count is
				when "000" =>
					Data_Read <= '1';
				when "001" =>
					Address <= DMA_RX_BUFFER_MSB;
					DMA_RQ <= '1';
					Data_Read <= '1';
					Write_en <= '1';
				when "010" =>
					Address <= DMA_RX_BUFFER_MID;
					DMA_RQ <= '1';
					Data_Read <= '1';
					Write_en <= '1';
				when "011" =>
					Address <= DMA_RX_BUFFER_LSB;
					DMA_RQ <= '0';
					Data_Read <= '1';
					Write_en <= '1';
				when others =>
					enable_counter <= '0';
					DMA_RQ <= '0';
			end case;
			
		--Transmission --
		
		when Tx =>
			Valid_D <= '1';
			OE <= '0';
			enable_counter <= '1';
			reset_counter <= '0';
			DMA_RQ <= '0';			
			case count is
				when "000" =>
					TX_Data <= Databus;
					Address <= DMA_TX_BUFFER_MSB;
					READY <= not Send_comm;
				when "001" =>
					TX_Data <= Databus;
					Address <= DMA_TX_BUFFER_LSB;
					READY <= '1';
				when others =>
					enable_counter <= '0';
			end case;
		when others =>
			Data_Read <= '0';    
			Valid_D <= '0';      
			Address <= (others => 'Z');
			Databus <= (others => 'Z');
			TX_Data <= (others => '0');
			Write_en <= 'Z';
			OE <= 'Z';
			DMA_RQ <= '0';
			READY <= '1';
			enable_counter <= '0';
			reset_counter <= '1';
	end case;
end process;
			


end Behavioral;

