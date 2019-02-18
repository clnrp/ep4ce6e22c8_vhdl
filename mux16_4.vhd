-- ep4ce6e22c8 - tests
-- 16-bit to 4-bit multiplexer
-- Author: Cleoner Pietralonga

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux16_4 is
    Port ( input : in  std_logic_vector (15 downto 0);
           sel : in  std_logic_vector (1 downto 0);
           output : out std_logic_vector (3 downto 0)
			  );
end mux16_4;

architecture arch of mux16_4 is
begin
   output <= input(15 downto 12) when sel = "11" else
				 input(11 downto 8) when sel = "10" else
				 input(7 downto 3) when sel = "01" else
				 input(3 downto 0);
end arch;