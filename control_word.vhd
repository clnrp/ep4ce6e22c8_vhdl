-- ep4ce6e22c8 - test microcontroller
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_ARITH.ALL; 

package ControlWord is 
	signal Reset : std_logic;
	signal PcInc : std_logic;
	signal PcOut : std_logic;
	signal Jump : std_logic;
	signal AccIn : std_logic;
	signal AccOut : std_logic;
	signal BIn : std_logic;
	signal CIn : std_logic;
	signal FIn : std_logic;
	signal FOut : std_logic;
	signal SumSub : std_logic;
	signal Alu0 : std_logic;
	signal Alu1 : std_logic;
	signal AluOut : std_logic;
	signal We : std_logic;
	signal MarIn : std_logic;
	signal RamOut : std_logic;
	signal IrIn : std_logic;
	signal IrOut : std_logic;
end;

package body ControlWord is

function m_reset(a,b :std_logic) return std_logic is
begin
	return a and b;
end function;

end package body;