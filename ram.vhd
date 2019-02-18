-- ep4ce6e22c8 - test microcontroller
-- RAM memory
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ram is
generic (
		AddrSize  :  integer := 8;
		DataSize  :  integer := 8
		);	    

port(
		Clk		 :  in std_logic; -- clock
		We	    	 :  in std_logic;	-- select recording or reading
		Rst		 :	 in std_logic;	-- reset
		Addr      :  in std_logic_vector (AddrSize-1 downto 0); -- address
		Input     :  in std_logic_vector (DataSize-1 downto 0); -- input data									
		Output    : out std_logic_vector (DataSize-1 downto 0)  -- output data
		);								
end Ram;
	
architecture arch of Ram is
type std_logic_vector_array is array(2**AddrSize downto 0) of std_logic_vector(DataSize - 1 downto 0);
signal Addr_out : std_logic_vector (2**AddrSize-1 downto 0); 	-- output of binary decoder
signal D: std_logic_vector(2**AddrSize*DataSize - 1 downto 0); -- input of the flipflop
signal Q: std_logic_vector(2**AddrSize*DataSize - 1 downto 0); -- output of the flipflop
signal T: std_logic_vector(2**AddrSize*DataSize - 1 downto 0); -- auxiliar vector to compute the or operation with all bits the same index
signal w: std_logic_vector(2**AddrSize - 1 downto 0); 			-- determine which flipflops will receive the input data 
signal r: std_logic_vector(2**AddrSize - 1 downto 0); 			-- determine which flipflops are the output data

component BinaryDecoder -- binary decoder to Addr
generic(sizeIn : integer := 3; sizeOut : integer := 8);
port(Input : in std_logic_vector (sizeIn-1 downto 0); Output : out std_logic_vector (sizeOut-1 downto 0));
end component;

component FlipFlop_D 
port(Clk,Rst,D: in std_logic; Q: out std_logic);
end component;

begin
	bdec : BinaryDecoder generic map(AddrSize, 2**AddrSize) port map(Addr, Addr_out); -- binary decoder to Addr
		
	loop_ff_addr: for i in 0 to 2**AddrSize-1 generate -- D = (w * DataIn[j]).Not() * (w.Not() * self.__Ffs[i][j].GetQ()).Not()
			w(i) <= We and Addr_out(i);
			r(i) <= (not We) and Addr_out(i); 				-- same value for all bits of the data
			loop_ff_data: for j in 0 to DataSize-1 generate 
				D(i*DataSize+j) <= not ((not (w(i) and Input(j))) and (not ((not w(i)) and Q(i*DataSize+j)))); -- set D value
				ff_d: FlipFlop_D port map(Clk, Rst, D(i*DataSize+j), Q(i*DataSize+j));
			end generate loop_ff_data;
	 end generate loop_ff_addr;

	 loop_out_data: for i in 0 to DataSize-1 generate -- bits the same index
			T(i*(2**AddrSize)) <= r(0) and Q(i);
			loop_out_addr: for j in 1 to 2**AddrSize-1 generate -- 2^AddrSize
				T(i*(2**AddrSize)+j) <= T(i*(2**AddrSize)+j-1) or (r(j) and Q(i+j*DataSize)); -- calculate the operation or with all bits the same index
			end generate loop_out_addr;
			Output(i) <= T(i*(2**AddrSize)+(2**AddrSize)-1);
	 end generate loop_out_data;
	 
end arch;