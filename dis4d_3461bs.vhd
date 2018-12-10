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

entity dis4d_3461bs is
    port (
			  c_clk: in bit;
			  dig0,dig1,dig2,dig3: in integer;
			  dig_pin: out std_logic_vector (3 downto 0);
			  seg_pin: out std_logic_vector (7 downto 0)
			  );
end dis4d_3461bs;

architecture arch of dis4d_3461bs is
	 
function digit (sel: in  integer) return std_logic_vector is
	variable result : std_logic_vector (7 downto 0);
	begin
   case sel is
	  when 0 => result := "11000000"; -- 0
	  when 1 => result := "11111001"; -- 1
	  when 2 => result := "10100100"; -- 2
	  when 3 =>	result := "10110000"; -- 3
	  when 4 =>	result := "10011001"; -- 4
	  when 5 =>	result := "10010010"; -- 5
	  when 6 =>	result := "10000010"; -- 6
	  when 7 =>	result := "11011000"; -- 7
	  when 8 =>	result := "10000000"; -- 8
	  when 9 =>	result := "10011000"; -- 9 
	  when others => result := "11000000"; -- 0
	end case;
	return result;
end digit;
	
	
begin

process (c_clk) is -- sensível ao clock
	variable cnt_dig: std_logic_vector (3 downto 0) := "0001";
	variable aux: std_logic_vector (3 downto 0) := "1111";
	variable cnt_wait: integer range 0 to 50000000;
	begin
     if(c_clk'event and c_clk = '1') then -- borda de subida	
			if(cnt_wait >= 30000000) then 
				cnt_wait := 0;
				cnt_dig := std_logic_vector(shift_left(unsigned(cnt_dig),1));
				if(cnt_dig = "0000") then
					cnt_dig := "0001";
				end if;
				aux := not cnt_dig;
			else
				cnt_wait := cnt_wait+1;
			end if;

			dig_pin <= aux; -- os digitos do display devem ser acionados um por vez 	 
			case cnt_dig is
				when "0001" => seg_pin <= digit(dig0);
				when "0010" => seg_pin <= digit(dig1);
				when "0100" => seg_pin <= digit(dig2);
      		when "1000" => seg_pin <= digit(dig3);
				when others => seg_pin <= digit(dig0);
			end case;
	  end if;
end process;	


end arch;