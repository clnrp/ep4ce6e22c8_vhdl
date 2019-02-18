-- ep4ce6e22c8 - test microcontroller
-- generic full adder
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder is
generic (n  :  integer := 8);	      -- número de bits do somador
port(
		mA, mB        :  in std_logic_vector (n-1 downto 0);	
		mCarryIn      :  in std_logic;									
		mSum          : out std_logic_vector (n-1 downto 0);	
		mCarryOut     : out std_logic);								
end fulladder;
	
architecture arch of fulladder is
  
component fulladder_1b port(A,B,CarryIn: in std_logic; Sum, CarryOut: out std_logic);
end component;  
signal carry: std_logic_vector (n downto 0); -- vai um
	  
begin
    carry(0) <= mCarryIn;

	 n_loop: for i in 0 to n-1 generate 
		 
		add: fulladder_1b port map (mA(i), mB(i), carry(i), mSum(i), carry(i+1)); 
		n_if: if i=n-1 generate -- pega carryOut no ultimo loop
						mCarryOut <= carry(i+1);
		end generate n_if;
		 
	 end generate n_loop;
		 
end arch;