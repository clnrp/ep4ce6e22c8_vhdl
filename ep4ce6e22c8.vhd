library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_ARITH.ALL;
 
use work.simple_logic.ALL; -- package

entity ep4ce6e22c8 is
    Port ( --A : in  std_logic;
           --B : in  std_logic;
           --C : out  std_logic;
			  clk	:	in  bit;
			  reset : in  bit;
			  dig: out std_logic_vector (3 downto 0); -- saída de 4 bits, bit mais significativo a esquerda
			  seg: out std_logic_vector (7 downto 0);	-- saída de 8 bits		  
			  D: in std_logic_vector (3 downto 0); 
			  E: out std_logic_vector (3 downto 0) 
			  );
end ep4ce6e22c8;

architecture arch of ep4ce6e22c8 is
signal aux : std_logic;

component dis_3461bs port(c_clk: in bit; c_sel: in std_logic_vector (3 downto 0); c_dig : out std_logic_vector (3 downto 0); c_seg : out std_logic_vector (7 downto 0));
end component;

-- display component
component dis4d_3461bs port(c_clk: in bit; dig0,dig1,dig2,dig3: in integer; dig_pin : out std_logic_vector (3 downto 0); seg_pin : out std_logic_vector (7 downto 0));
end component;

begin

	E(0) <= my_or(D(0),D(1)); -- do pacote
	E(1) <= my_and(D(2),D(3));
	
	display : dis4d_3461bs port map(clk, 0,1,2,3, dig, seg); -- display de 4 digitos

end arch;