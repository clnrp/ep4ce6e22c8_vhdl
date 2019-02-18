-- ep4ce6e22c8 - test microcontroller
-- binary decoder
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity BinaryDecoder is
generic (
		sizeIn  :  integer := 3;
		sizeOut  :  integer := 8
		);	    

port(
		Input     :  in std_logic_vector (sizeIn-1 downto 0);									
		Output    : out std_logic_vector (sizeOut-1 downto 0)
		);								
end BinaryDecoder;
	
architecture arch of BinaryDecoder is
	 signal bit_in : std_logic_vector (sizeIn*sizeOut-1 downto 0);
	 signal bit_out : std_logic_vector (sizeIn*sizeOut-1 downto 0); -- vector for concatenated operation of and

function getBit (neg, b_value: in  std_logic) return std_logic is  -- if neg = 1 select b_value and neg = 0 select not b_value 
	variable result : std_logic;
	begin
		result  := (neg and b_value) or (not neg and not b_value);
	return result;
end getBit;

begin
	 
	 loop_out: for i in 0 to sizeOut-1 generate 
			bit_in((i+1)*sizeIn-1 downto i*sizeIn) <= std_logic_vector(to_unsigned(i, bit_in(sizeIn-1 downto 0)'length)); -- convert integer to std_logic_vector
			bit_out(i*sizeIn) <= getBit(bit_in(i*sizeIn), Input(0)); 
			loop_in: for j in 1 to sizeIn-1 generate
				bit_out(i*sizeIn+j) <= bit_out(i*sizeIn+j-1) and getBit(bit_in(i*sizeIn+j), Input(j)); -- bit_out(0) = getBit; bit_out(1) = bit_out(0) and getBit; bit_out(2) = bit_out(1) and getBit 
			end generate loop_in;
			Output(i) <= bit_out((i+1)*sizeIn-1); -- bit_out(2)
	 end generate loop_out;
	 
end arch;