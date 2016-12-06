--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:25:50 11/28/2016
-- Design Name:   
-- Module Name:   C:/Users/Danns/Desktop/Practica 3/PIC/tb_ALU.vhd
-- Project Name:  PIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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

use work.PIC_pkg.ALL;
 
ENTITY tb_ALU IS
END tb_ALU;
 
ARCHITECTURE behavior OF tb_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         u_instruction : in alu_op;
         FlagZ : OUT  std_logic;
         Index_Reg : OUT  std_logic_vector(7 downto 0);
         Databus : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal u_instruction : alu_op := nop;

	--BiDirs
   signal Databus : std_logic_vector(7 downto 0) := (others => 'Z');

 	--Outputs
   signal FlagZ : std_logic;
   signal Index_Reg : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          Reset => Reset,
          Clk => Clk,
          u_instruction => u_instruction,
          FlagZ => FlagZ,
          Index_Reg => Index_Reg,
          Databus => Databus
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
   stim_proc: process
   begin		
     Reset <= '0', '1' after 50 ns;
	  u_instruction <= op_lda, op_ldb after 100 ns, op_add after 150 ns, op_mvacc2a after 200 ns, op_sub after 250 ns, op_mvacc2id after 300 ns, op_cmpg after 350 ns,
								op_lda after 400 ns, op_ascii2bin after 450 ns, op_lda after 500 ns, op_ascii2bin after 550 ns, op_lda after 600 ns, op_ascii2bin after 650 ns, op_oeacc after 700 ns;
	  Databus <= X"04" after 50 ns, X"01" after 100 ns, (others => 'Z') after 150 ns, X"35" after 400 ns, (others => 'Z') after 450 ns, X"20" after 500 ns, (others => 'Z') after 550 ns, X"87" after 600 ns, (others => 'Z') after 650 ns;

      wait;
   end process;

END;
