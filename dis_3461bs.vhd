library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.NUMERIC_STD.all;

--      0   
--    -----
--  5 -   - 1
--    --6--
--  4 -   - 2
--    -----
--      3     *7

entity dis_3461bs is
    port (
			  c_clk: in bit;
			  c_sel: in  std_logic_vector (3 downto 0);  
			  c_dig: out std_logic_vector (3 downto 0);
			  c_seg: out std_logic_vector (7 downto 0)
			  );
end dis_3461bs;

architecture arch of dis_3461bs is
	 
function digit (sel: in  std_logic_vector (3 downto 0)) return std_logic_vector is
	variable result   :  std_logic_vector (7 downto 0);
	begin
   case sel is
	  when not "0000" => result := "11000000"; -- 0
	  when not "0001" => result := "11111001"; -- 1
	  when not "0010" => result := "10100100"; -- 2
	  when not "0011" =>	result := "10110000"; -- 3
	  when not "0100" =>	result := "10011001"; -- 4
	  when not "0101" =>	result := "10010010"; -- 5
	  when not "0110" =>	result := "10000010"; -- 6
	  when not "0111" =>	result := "11011000"; -- 7
	  when not "1000" =>	result := "10000000"; -- 8
	  when not "1001" =>	result := "10011000"; -- 9 
	  when others => result := "11000000"; -- 0
	end case;
	return result;
end digit;
	
	
begin

process (c_clk) is -- os digitos do display devem ser acionados um por vez 
	variable cnt: std_logic_vector (3 downto 0) := "0001";
	variable aux: std_logic_vector (3 downto 0);
	begin
     if(c_clk'event and c_clk = '1') then -- borda de subida	
			cnt := std_logic_vector(shift_left(unsigned(cnt),1));
			if(cnt = "0000") then
				cnt := "0001";
			end if;
			
			case cnt is
				when "0001" => c_seg <= digit(c_sel);
				when "0010" => c_seg <= digit(c_sel);
				when "0100" => c_seg <= digit(c_sel);
				when "1000" => c_seg <= digit(c_sel);
				when others => c_seg <= digit(c_sel);
			end case;
			--aux := conv_std_logic_vector(cnt, c_dig'length); -- aciona o digito
			aux := not cnt;
			c_dig <= aux;
	  end if;
end process;

end arch;