
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

USE work.PIC_pkg.all;

entity PICtop is
  port (
    Reset    : in  std_logic;           -- Asynchronous, active low
    Clk      : in  std_logic;           -- System clock, 20 MHz, rising_edge
    RS232_RX : in  std_logic;           -- RS232 RX line
    RS232_TX : out std_logic;           -- RS232 TX line
    Switches : out std_logic_vector(7 downto 0);  -- Switch status bargraph
    Temp_L   : out std_logic_vector(6 downto 0);  -- Less significant figure of T_STAT
    Temp_H   : out std_logic_vector(6 downto 0));  -- Most significant figure of T_STAT
end PICtop;

architecture behavior of PICtop is

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
	
------------------------------------------------------------------------------
-- ALU
------------------------------------------------------------------------------

	component ALU
		PORT (
			Reset : in std_logic; 	-- asynnchronous, active low
			Clk : in std_logic; -- System clock, 20 MHz, rising_edge
			u_instruction : in alu_op; -- u-instructions from CPU
			FlagZ : out std_logic; -- Zero flag
		--	FlagC : out std_logic; -- Carry flag
		--	FlagN : out std_logic; -- Nibble carry bit
		--	FlagE : out std_logic; -- Error flag
			Index_Reg : out std_logic_vector(7 downto 0); -- Index register
			Databus : inout std_logic_vector(7 downto 0)); -- System Data bus
	END component;
	
------------------------------------------------------------------------------
--	CPU
------------------------------------------------------------------------------

	component CPU
		PORT	(
			Reset : in  STD_LOGIC;
			Clk : in  STD_LOGIC;
			ROM_Data : in  STD_LOGIC_VECTOR (11 downto 0);
			ROM_Addr : out  STD_LOGIC_VECTOR (11 downto 0);
			RAM_Addr : out  STD_LOGIC_VECTOR (7 downto 0);
			RAM_Write : out  STD_LOGIC;
			RAM_OE : out  STD_LOGIC;
			Databus : inout  STD_LOGIC_VECTOR (7 downto 0);
			DMA_RQ : in  STD_LOGIC;
			DMA_ACK : out  STD_LOGIC;
			SEND_comm : out  STD_LOGIC;
			DMA_READY : in  STD_LOGIC;
			Alu_op : out  alu_op;
			Index_Reg : in  STD_LOGIC_VECTOR (7 downto 0);
			FlagZ : in  STD_LOGIC);
			--FlagC : in  STD_LOGIC;
			--FlagN : in  STD_LOGIC;
			--FlagE : in  STD_LOGIC
	END component;
	
----------------------------------------------------------------------------
--	ROM
----------------------------------------------------------------------------

	component ROM
		PORT	(
			Instruction     : out STD_LOGIC_VECTOR(11 downto 0);  -- Instruction bus
			Program_counter : in  STD_LOGIC_VECTOR(11 downto 0));
	END component;
		
-----------------------------------------------------------------------------
-- Señales internas
-----------------------------------------------------------------------------
	signal Valid_D 	: 	STD_LOGIC;
	signal Ack_out 	: 	STD_LOGIC;
	signal TX_RDY 		: 	STD_LOGIC;
	signal Data_Read 	: 	STD_LOGIC;
	signal RX_Full 	: 	STD_LOGIC;
	signal RX_Empty 	: 	STD_LOGIC;
	signal Write_en 	: 	STD_LOGIC;
	signal OE 			: 	STD_LOGIC;
	signal DMA_ACK 	: 	STD_LOGIC;
	signal DMA_RQ 		: 	STD_LOGIC;
	signal Send_comm	: 	STD_LOGIC;
	signal READY 		: 	STD_LOGIC;
	signal TX_Data 	: 	STD_LOGIC_VECTOR (7 downto 0);
	signal Address 	: 	STD_LOGIC_VECTOR (7 downto 0);
	signal Databus 	: 	STD_LOGIC_VECTOR (7 downto 0);
	signal RCVD_Data 	: 	STD_LOGIC_VECTOR (7 downto 0);
	signal fifo_count	: 	STD_LOGIC_VECTOR (5 downto 0);
	signal Index_Reg	:	STD_LOGIC_VECTOR (7 downto 0);
	signal FlagZ 		: 	STD_LOGIC;
	signal Alu_op		:	alu_op;
	signal ROM_Data 	: 	STD_LOGIC_VECTOR (11 downto 0);
	signal ROM_Addr 	: 	STD_LOGIC_VECTOR (11 downto 0);
	
begin  -- behavior

-----------------------------------------------------------------------------
--	Componentes
-----------------------------------------------------------------------------

  RS232_PHY:	RS232top
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
			Send_comm 	=> Send_comm,
			READY 		=> READY,
			FF_Count		=> fifo_count);
			
	RAM_Unit:	RAM
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
			
	ALU_Unit:	ALU
		port map	(
			Reset 			=>	Reset,
			Clk 				=>	Clk,
			u_instruction 	=>	Alu_op,
			FlagZ 			=>	FlagZ,
		--	FlagC 			=>
		--	FlagN				=>
		--	FlagE				=>
			Index_Reg 		=>	Index_Reg,
			Databus			=>	Databus);
	
	CPU_Unit:	CPU
		port map	(
			Reset 		=>	Reset,
			Clk			=>	Clk,
			ROM_Data		=>	ROM_Data,
			ROM_Addr		=>	ROM_Addr,
			RAM_Addr		=>	Address,
			RAM_Write	=>	Write_en,
			RAM_OE		=>	OE,
			Databus		=>	Databus,
			DMA_RQ		=>	DMA_RQ,
			DMA_ACK		=>	DMA_ACK,
			SEND_comm	=>	Send_comm,
			DMA_READY	=>	READY,
			Alu_op		=>	Alu_op,
			Index_Reg	=>	Index_Reg,
			FlagZ			=>	FlagZ);
			--FlagC			=>
			--FlagN			=>
			--FlagE			=>

	ROM_Unit:	ROM
		port map	(
			Instruction     => ROM_Data,
			Program_counter => ROM_Addr);

end behavior;

