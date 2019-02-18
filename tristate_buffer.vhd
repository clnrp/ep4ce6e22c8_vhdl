-- ep4ce6e22c8 - test microcontroller
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TristateBuffer is

generic (
			size  :  integer := 8   -- buffer size
);

port ( 
         En  : in  std_logic; -- enable
         A  : in  std_logic_vector (size-1 downto 0); -- A is input
         B : out std_logic_vector (size-1 downto 0)   -- B is output
);
end TristateBuffer;

architecture arch of TristateBuffer is
begin

    tristate : for i in 0 to size-1 generate
			B(i) <= A(i) when En = '1' else 'Z'; -- if En is 1 B <= A, else B get high impedance 
    end generate tristate;

end arch;