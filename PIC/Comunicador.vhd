----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:20 11/29/2016 
-- Design Name: 
-- Module Name:    Comunicador - Behavioral 
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

entity Comunicador is
    Port ( Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           RS232_RX : in  STD_LOGIC;
           RS232_TX : out  STD_LOGIC;
           SEND : in  STD_LOGIC;
           DMA_ACK : in  STD_LOGIC;
           READY : out  STD_LOGIC;
           DMA_RQ : out  STD_LOGIC;
           Switches : out  STD_LOGIC_VECTOR (7 downto 0);
           Temp_L : out  STD_LOGIC_VECTOR (6 downto 0);
           Temp_H : out  STD_LOGIC_VECTOR (6 downto 0));
end Comunicador;

architecture Behavioral of Comunicador is

-----------------------------------------------------------------------------------
-- Módulos de comunicación
-----------------------------------------------------------------------------------

	component RS232top
		port (
			Reset     : in  std_logic;
			Clk       : in  std_logic;
			Data_in   : in  std_logic_vector(7 downto 0);
			Valid_D   : in  std_logic;
			Ack_in    : out std_logic;
			TX_RDY    : out std_logic;
			TD        : out std_logic;
			RD        : in  std_logic;
			Data_out  : out std_logic_vector(7 downto 0);
			Data_read : in  std_logic;
			Full      : out std_logic;
			Empty     : out std_logic;
			FF_Count	 : out std_logic_vector(5 downto 0));
	end component;
  
	component DMA
		Port ( 
			Reset 		: in  STD_LOGIC;
			Clk 			: in  STD_LOGIC;
			RCVD_Data 	: in  STD_LOGIC_VECTOR (7 downto 0);
			RX_Full 		: in  STD_LOGIC;
			RX_Empty 	: in  STD_LOGIC;
			Data_Read 	: out  STD_LOGIC;
			ACK_out 		: in  STD_LOGIC;
			TX_RDY 		: in  STD_LOGIC;
			Valid_D 		: out  STD_LOGIC;
			TX_Data 		: out  STD_LOGIC_VECTOR (7 downto 0);
			Address 		: out  STD_LOGIC_VECTOR (7 downto 0);
			Databus 		: inout  STD_LOGIC_VECTOR (7 downto 0);
			Write_en 	: out  STD_LOGIC;
			OE 			: out  STD_LOGIC;
			DMA_RQ 		: out  STD_LOGIC;
			DMA_ACK 		: in  STD_LOGIC;
			Send_comm 	: in  STD_LOGIC;
			READY 		: out  STD_LOGIC;
			FF_Count	 	: in std_logic_vector(5 downto 0));
	end component;
	
-------------------------------------------------------------------------------
-- Memoria RAM
-------------------------------------------------------------------------------
	
	component ram
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
	END component;
		
---------------------------------------------------------------------
-- Señales internas
---------------------------------------------------------------------
	signal Valid_D 	: STD_LOGIC;
	signal Ack_out 	: STD_LOGIC;
	signal TX_RDY 		: STD_LOGIC;
	signal Data_Read 	: STD_LOGIC;
	signal RX_Full 	: STD_LOGIC;
	signal RX_Empty 	: STD_LOGIC;
	signal Write_en 	: STD_LOGIC;
	signal OE 			: STD_LOGIC;
	signal TX_Data 	: STD_LOGIC_VECTOR (7 downto 0);
	signal Address 	: STD_LOGIC_VECTOR (7 downto 0);
	signal Databus 	: STD_LOGIC_VECTOR (7 downto 0);
	signal RCVD_Data 	: STD_LOGIC_VECTOR (7 downto 0);
	signal fifo_count	: STD_LOGIC_VECTOR (5 downto 0);
	
begin  -- behavior

  RS232_PHY: RS232top
    port map (
        Reset     => Reset,
        Clk       => Clk,
        Data_in   => TX_Data,
        Valid_D   => Valid_D,
        Ack_in    => Ack_out,
        TX_RDY    => TX_RDY,
        TD        => RS232_TX,
        RD        => RS232_RX,
        Data_out  => RCVD_Data,
        Data_read => Data_Read,
        Full      => RX_Full,
        Empty     => RX_Empty,
		  FF_Count	=> fifo_count);
		  
	DMA_Unit:	DMA
		port map (
			Reset			=> Reset,
			Clk 			=> Clk,
			RCVD_Data	=>	RCVD_Data,
			RX_Full 		=> RX_Full,
			RX_Empty 	=> RX_Empty,
			Data_Read 	=> Data_Read,
			ACK_out 		=> ACK_out,
			TX_RDY 		=> TX_RDY,
			Valid_D 		=> Valid_D,
			TX_Data 		=> TX_Data,
			Address 		=> Address,
			Databus 		=> Databus,
			Write_en 	=> Write_en,
			OE 			=> OE,
			DMA_RQ 		=> DMA_RQ,
			DMA_ACK 		=> DMA_ACK,
			Send_comm 	=> SEND,
			READY 		=> READY,
			FF_Count		=> fifo_count);
			
	RAM_Unit: RAM
		port map (
			Clk		=> Clk,
			Reset    => Reset,
			write_en => Write_en,
			oe       => OE,
			address  => Address,
			databus  => Databus,
			Switches => Switches,
			Temp_L   => Temp_L,
			Temp_H   => Temp_H);

end behavioral;
