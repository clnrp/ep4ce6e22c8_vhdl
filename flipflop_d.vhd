-- ep4ce6e22c8 - test microcontroller
-- flipflop D type
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlop_D is
   port
   (
      Clk : in std_logic;
      Rst : in std_logic;
      
      D : in std_logic;
      Q : out std_logic
   );
end entity FlipFlop_D;
 
architecture arch of FlipFlop_D is

begin
   process (Clk) is
   begin
      if rising_edge(Clk) then  
         if (Rst='1') then   
            Q <= '0';
         else
            if (D ='1') then
					Q <= '1';
				elsif (D ='0') then 
					Q <= '0';
				end if;
         end if;
      end if;
   end process;
end arch;