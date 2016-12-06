--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:49:49 11/27/2016
-- Design Name:   
-- Module Name:   E:/David/Teleco/Curso_2016-2017/DSED/Practica 3/PIC/tb_PIC.vhd
-- Project Name:  PIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PICtop
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
LIBRARY RS232_test;
USE RS232_test.RS232_test.all;

USE work.PIC_pkg.all;
 
ENTITY tb_PIC IS
END tb_PIC;
 
ARCHITECTURE behavior OF tb_PIC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PICtop
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RS232_RX : IN  std_logic;
         RS232_TX : OUT  std_logic;
         Switches : OUT  std_logic_vector(7 downto 0);
         Temp_L : OUT  std_logic_vector(6 downto 0);
         Temp_H : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal RS232_RX : std_logic := '0';

 	--Outputs
   signal RS232_TX : std_logic;
   signal Switches : std_logic_vector(7 downto 0);
   signal Temp_L : std_logic_vector(6 downto 0);
   signal Temp_H : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PICtop PORT MAP (
          Reset => Reset,
          Clk => Clk,
          RS232_RX => RS232_RX,
          RS232_TX => RS232_TX,
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

---------------------------------------------------------------------------------
-- Simulación del procesador
----------------------------------------------------------------------------------
--CPU: process (clk)
--begin
--	if clk'event and clk = '1' then
--		if Reset = '1' then
--			DMA_ACK <= '0';
--			Send_comm <= '0';
--		end if;
--		if DMA_RQ = '0' then
--			DMA_ACK <= '0';
--		elsif DMA_RQ = '1' then
--			DMA_ACK <= '1';
--		end if;
--	end if;
--end process;

 -------------------------------------------------------------------------------
-- Sending some stuff through RS232 port
-------------------------------------------------------------------------------

  SEND_STUFF : process
  begin
     RS232_RX <= '1';
     wait for 40 us;
     Transmit(RS232_RX, X"49");
     wait for 40 us;
     Transmit(RS232_RX, X"34");
     wait for 40 us;
     Transmit(RS232_RX, X"31");
     wait;
  end process SEND_STUFF;

END;
