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
			  value_d: in std_logic_vector (11 downto 0);
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


function bin12_to_bcd ( b_value : std_logic_vector(11 downto 0) ) return std_logic_vector is
	variable i : integer:=0;
	variable bcd : std_logic_vector(15 downto 0) := (others => '0');
	variable bint : std_logic_vector(11 downto 0) := b_value;
	
	begin
	for i in 0 to 11 loop 		 
		bcd(15 downto 1) := bcd(14 downto 0);  -- deslocamento para esquerda
		bcd(0) := bint(11);
		bint(11 downto 1) := bint(10 downto 0);
		bint(0) :='0';
		
		if(i < 11 and bcd(3 downto 0) > "0100") then   
			bcd(3 downto 0) := std_logic_vector(unsigned(bcd(3 downto 0)) + "0011"); -- soma 3 se bcd for maior que 4
		end if;
		
		if(i < 11 and bcd(7 downto 4) > "0100") then  
			bcd(7 downto 4) := std_logic_vector(unsigned(bcd(7 downto 4)) + "0011"); -- soma 3 se bcd for maior que 4
		end if;
		
		if(i < 11 and bcd(11 downto 8) > "0100") then  
			bcd(11 downto 8) := std_logic_vector(unsigned(bcd(11 downto 8)) + "0011"); -- soma 3 se bcd for maior que 4
		end if;
		
		if(i < 11 and bcd(15 downto 9) > "0100") then 
			bcd(15 downto 12) := std_logic_vector(unsigned(bcd(15 downto 12)) + "0011"); -- soma 3 se bcd for maior que 4
		end if;
		
	end loop;
	return bcd;
end bin12_to_bcd;
	
begin

process (c_clk, value_d) is -- sensível ao clock
	variable cnt_dig: std_logic_vector (3 downto 0) := "0001";
	variable aux: std_logic_vector (3 downto 0) := "1111";
	variable cnt_wait: integer range 0 to 50000000;
	variable digits: std_logic_vector (15 downto 0);
	begin
	  digits := bin12_to_bcd(value_d);
     if(c_clk'event and c_clk = '1') then -- borda de subida	
			if(cnt_wait >= 30000) then 
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
				when "0001" => seg_pin <= digit(to_integer(unsigned(digits(3 downto 0))));
				when "0010" => seg_pin <= digit(to_integer(unsigned(digits(7 downto 4))));
				when "0100" => seg_pin <= digit(to_integer(unsigned(digits(11 downto 8))));
      		when "1000" => seg_pin <= digit(to_integer(unsigned(digits(15 downto 12))));
				when others => seg_pin <= digit(to_integer(unsigned(digits(3 downto 0))));
			end case;
	  end if;
end process;	


end arch;