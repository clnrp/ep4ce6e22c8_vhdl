-- ep4ce6e22c8 - test microcontroller
-- logical arithmetic unit (ALU)
-- Author: Cleoner Pietralonga 

entity alu is
generic (n  :  integer := 8);	      -- número de bits do somador
port(
		A, B     :  in bit_vector (n-1 downto 0);							
		Result     : out bit_vector (n-1 downto 0)
     );		
end alu;
	
architecture arch of alu is

component fulladder 
generic (n  :  integer := 8);
port(mA,mB: in bit_vector (n-1 downto 0); mCarryIn: in bit; mSum: out bit_vector (n-1 downto 0); mCarryOut: out bit);
end component;  

signal CarryIn, CarryOut: bit;
signal Sum: bit_vector (n-1 downto 0);
signal mAnd: bit_vector (n-1 downto 0);
signal mOr: bit_vector (n-1 downto 0);
signal mXor: bit_vector (n-1 downto 0);
	  
begin
	 CarryIn <= '0';
    add: fulladder generic map(n) port map (A, B, CarryIn, Sum, CarryOut);
    mAnd <= A and B;
	 mOr <= A or B;
	 mXor <= A xor B;
	 Result <= mAnd; 
end arch;