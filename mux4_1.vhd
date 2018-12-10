library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4_1 is
    Port ( input : in  std_logic_vector (0 to 3); --  entrada de 4 bits
           sel : in  std_logic_vector (1 downto 0); -- seleção
           output : out std_logic -- saída de 1 bit
			  );
end mux4_1;

architecture arch of mux4_1 is
begin
   with sel select output <= input(0) when "00", -- seleção com dois bits
	                          input(1) when "01",
									  input(2) when "10",
									  input(3) when others;
end arch;