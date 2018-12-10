library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mealy_machine1 is
port(
			clk		:  in   std_logic; -- clock						 
			rst      :  in   std_logic;							 
			q        : inout std_logic_vector(1 downto 0)); 
end mealy_machine1;
	
architecture arch of mealy_machine1 is
	begin
	  my_process : process(clk, rst) -- sensível ao clock e reset 
	  begin
       if(rst = '1') then q <= "00";	-- estado inicial
		 elsif(clk'event and clk = '1') then  
		   case q is
			  when "00" => q <= "01";
			  when "01" => q <= "11";
			  when "11" => q <= "10";
			  when "10" => q <= "00";
			end case;
		 end if;
	  end process my_process;
end arch;