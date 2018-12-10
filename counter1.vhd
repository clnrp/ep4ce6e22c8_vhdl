
entity counter1 is

port(
			clk	:	in  bit;	-- clock					       
			load  :  in  bit;	-- carrega os dados do barramento
			reset :  in  bit;						       
			input      :  in  integer range 15 downto 0; -- dados do barramento 
			output     : out  integer range 15 downto 0); -- saída de dados 
end counter1;                                  
	
architecture arch of counter1 is           
begin													    
	
process_cnt : process(clk, reset)         
   variable data : integer range 15 downto 0;
	begin 
	if(reset = '1') then						
	   data := 0;                            
	elsif(clk'event and clk = '1') then   -- borda de subida
	   if(load = '1') then 
			data := input;			
		else 
			 if(data > 15) then 
				data := 0;		   
			 else  
				data := data + 1;
			 end if;                                
		end if;											 
	end if;											 
	output <= data;										 
	end process process_cnt; 
	
end arch;	