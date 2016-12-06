--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:51:33 11/29/2016
-- Design Name:   
-- Module Name:   C:/Users/dsed12/Desktop/DSED/Practica 3/PIC/tb_Comunicador.vhd
-- Project Name:  PIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comunicador
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

USE work.PIC_pkg.all;

LIBRARY RS232_test;
USE RS232_test.RS232_test.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_Comunicador IS
END tb_Comunicador;
 
ARCHITECTURE behavior OF tb_Comunicador IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comunicador
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RS232_RX : IN  std_logic;
         RS232_TX : OUT  std_logic;
         SEND : IN  std_logic;
         DMA_ACK : IN  std_logic;
         READY : OUT  std_logic;
         DMA_RQ : OUT  std_logic;
         Switches : OUT  std_logic_vector(7 downto 0);
         Temp_L : OUT  std_logic_vector(6 downto 0);
         Temp_H : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal RS232_RX : std_logic := '0';
   signal SEND : std_logic := '0';
   signal DMA_ACK : std_logic := '0';

 	--Outputs
   signal RS232_TX : std_logic;
   signal READY : std_logic;
   signal DMA_RQ : std_logic;
   signal Switches : std_logic_vector(7 downto 0);
   signal Temp_L : std_logic_vector(6 downto 0);
   signal Temp_H : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 50 ns;
	
	-- Recepcion
	signal data_rx: std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comunicador PORT MAP (
          Reset => Reset,
          Clk => Clk,
          RS232_RX => RS232_RX,
          RS232_TX => RS232_TX,
          SEND => SEND,
          DMA_ACK => DMA_ACK,
          READY => READY,
          DMA_RQ => DMA_RQ,
          Switches => Switches,
          Temp_L => Temp_L,
          Temp_H => Temp_H
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   Recepcion: process
   begin		
		Reset <= '0', '1' after 100 ns;
		RS232_RX <= '1';
		wait for 40 us;
		Transmit(RS232_RX, X"49");
		wait for 40 us;
		Transmit(RS232_RX, X"34");
		wait for 40 us;
		Transmit(RS232_RX, X"31");

      wait;
   end process;
	
	 Transmision: process
   begin		
     SEND <= '0', '1' after 200 ns, '0' after 550 ns;
	  data_rx <= (others => '0');
	  Receive(RS232_TX, data_rx);
	  Receive(RS232_TX, data_rx);

      wait;
   end process;
	
	DMA_ACK <= '1' when DMA_RQ = '1' else
					'0' when DMA_RQ = '0';
	--SEND <= '0' when READY = '1';

END;
