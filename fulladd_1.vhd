-- ep4ce6e22c8 - tests
-- 1-bit full adder
-- Author: Cleoner Pietralonga

entity fulladd_1 is

port(
		A,B,CarryIn : in bit;
		Sum,CarryOut : out bit);
end fulladd_1;
	
architecture arch of fulladd_1 is
begin
	Sum  <= A xor B xor CarryIn; -- soma
	CarryOut <= (A and B) or (A and CarryIn) or (B and CarryIn); -- pega carryOut
end arch;