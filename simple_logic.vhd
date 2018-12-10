library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_ARITH.ALL; 

package simple_logic is 
	signal s0 : std_logic;
	signal s1 : std_logic;
	function my_and(a,b :std_logic) return std_logic; -- lógica E
	function my_or(a,b :std_logic) return std_logic; -- lógica OU
end;

package body simple_logic is

function my_and(a,b :std_logic) return std_logic is
begin
	return a and b;
end function;

function my_or(a,b :std_logic) return std_logic is
begin
	return a or b;
end function;

end package body;
