-- ep4ce6e22c8 - test microcontroller
-- generic multiplexer
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
generic (
      nSel : integer := 3;
		nIn  :  integer := 32;
		nOut  :  integer := 8
		);	    

port(
		Sel		 :  in std_logic_vector (nSel-1 downto 0);
		Input     :  in std_logic_vector (nIn-1 downto 0);									
		Output    : out std_logic_vector (nOut-1 downto 0)
		);								
end Mux;
	
architecture arch of Mux is
signal Sel_out : std_logic_vector (nIn/nOut-1 downto 0); -- output of binary decoder
signal Out_aux : std_logic_vector (nIn-1 downto 0); -- aux vector for concatenated operation of or, repeat in nIn/nOut elements
	 
component BinaryDecoder 
generic(sizeIn : integer := nSel; sizeOut : integer := 8);
port(Input : in std_logic_vector (sizeIn-1 downto 0); Output : out std_logic_vector (sizeOut-1 downto 0));
end component;
	 
begin

	bdec : BinaryDecoder generic map(nSel, nIn/nOut) port map(Sel, Sel_out); -- nSel = 3 bits, Sel_out = nIn/nOut = 4 bits
		
	loop_bdec: for i in 0 to nOut-1 generate -- out0 <= s0a0 or s1b0 or s2c0 or s3d0; out1 <= s0a1 or s1b1 or s2c1 or s3d1
			Out_aux(i*nIn/nOut) <= Sel_out(0) and Input(i); -- Input(i) = a0,a1,a2,a3,a4,a5,a6,a7 
			loop_or: for j in 1 to nIn/nOut-1 generate 
				Out_aux(i*nIn/nOut+j) <= Out_aux(i*nIn/nOut+j-1) or (Sel_out(j) and Input(i+j*nOut)); -- concatenated operation of or
			end generate loop_or;
			Output(i) <= Out_aux((i+1)*nIn/nOut-1); 
	 end generate loop_bdec;
	
end arch;