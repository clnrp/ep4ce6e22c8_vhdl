
entity fulladder is
generic (n  :  integer := 8);	      -- número de bits do somador
port(
		mA, mB        :  in bit_vector (n-1 downto 0);	
		mCarryIn      :  in bit;									
		mSum          : out bit_vector (n-1 downto 0);	
		mCarryOut     : out bit);								
end fulladder;
	
architecture arch of fulladder is
  
component fulladd_1 port(A,B,CarryIn: in bit; Sum, CarryOut: out bit);
end component;  
signal carry: bit_vector (n downto 0); -- vai um
	  
begin
    carry(0) <= mCarryIn;

	 n_loop: for i in 0 to n-1 generate 
		 
		add: fulladd_1 port map (mA(i), mB(i), carry(i), mSum(i), carry(i+1)); 
		n_if: if i=n-1 generate -- pega carryOut no ultimo loop
						mCarryOut <= carry(i+1);
		end generate n_if;
		 
	 end generate n_loop;
		 
end arch;