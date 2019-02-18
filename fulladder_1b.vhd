-- ep4ce6e22c8 - test microcontroller
-- 1 bit full adder
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder_1b is

port(
		A,B,CarryIn : in std_logic;
		Sum,CarryOut : out std_logic
		);
end fulladder_1b;
	
architecture arch of fulladder_1b is
begin
	Sum  <= A xor B xor CarryIn; -- sum
	CarryOut <= (A and B) or (A and CarryIn) or (B and CarryIn); -- take carryOut
end arch;