library ieee;

Use ieee.std_logic_1164.all;

entity led1 is
port ( input: in std_logic_vector (3 downto 0);
		LED: out std_logic_vector (3 downto 0));
end led1;

architecture arch of led1 is -- testar LEDs
begin
LED(0) <= input(0) AND input(1); 
LED(1) <= input(1) AND input(3);
LED(2) <= input(0) AND input(2);
LED(3) <= input(1) AND input(2);
end arch;