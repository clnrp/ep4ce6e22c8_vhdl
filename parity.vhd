library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parity is
    Port ( input : in  std_logic_vector (0 to 4); --  entrada de 4 bits
           output : out std_logic -- saída de 1 bit
			  );
end parity;

architecture arch of parity is
signal aux : std_logic_vector (0 to 3);
begin
aux(0) <= input(0) xor input(0);

gen: for i in 1 to 3 generate -- geração dos blocos
	aux(i) <= input(i+1) xor aux(i-1);
end generate gen;

output <= aux(3);

end arch;