-- ep4ce6e22c8 - test microcontroller
-- Stack
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Stack is

generic (
			size  :  integer := 12  
);

port ( 
			Clk		: in std_logic; -- clock
			Rst		: in std_logic; -- reset
         Count		: in std_logic; -- enable count
			Sen		: in std_logic; -- increse or decrese
			Wr			: in std_logic; -- enable write
         Input		: in std_logic_vector (size-1 downto 0);
			Output	: out std_logic_vector (size-1 downto 0)
);
end Stack;

architecture arch of Stack is
signal stack_Addr : std_logic_vector (3 downto 0);

component Counter_4b 
port(Clk,Rst,En,Sen,Load: in std_logic; Input : in std_logic_vector (3 downto 0); Output : out std_logic_vector (3 downto 0));
end component;

component Ram 
generic(AddrSize  :  integer := 4; DataSize  :  integer := 8);
port(Clk,We,Rst : in std_logic; Addr: std_logic_vector (AddrSize-1 downto 0); Input: in std_logic_vector (DataSize-1 downto 0); Output : out std_logic_vector (DataSize-1 downto 0));
end component;

begin

	stack_count : Counter_4b port map(Clk, Rst, Count, Sen, '0', "000", stack_Addr); 
	stack_ram : Ram generic map(4,8) port map(Clk, Wr, Rst, stack_Addr, Input(7 downto 0), Output(7 downto 0)); 

end arch;