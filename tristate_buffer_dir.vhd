-- ep4ce6e22c8 - test microcontroller
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TristateBuffer_Dir is

generic (
			size  :  integer := 8  -- buffer size
);

port ( 
         En 	: in  std_logic; -- enable
			Dir	: in std_logic;  -- direction
         A 		: inout std_logic_vector (size-1 downto 0); -- A is bidirectional
         B 		: inout std_logic_vector (size-1 downto 0)  -- B is bidirectional
);
end TristateBuffer_Dir;

architecture arch of TristateBuffer_Dir is
begin

    tristate : for i in 0 to size-1 generate
		if_dir_b: if Dir = '1' generate -- for Dir=1 and En=1, A <= B
			B(i) <= A(i) when En = '1' else 'Z'; -- if En is false B get high impedance
		end generate if_dir_b;
		
		if_dir_a: if Dir = '0' generate -- for Dir=0 and En=1, B <= A
			A(i) <= B(i) when En = '1' else 'Z'; -- if En is false A get high impedance
		end generate if_dir_a;
    end generate tristate;

end arch;