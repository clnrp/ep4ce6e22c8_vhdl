-- ep4ce6e22c8 - test microcontroller
-- 4-bit Counter
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_4b is
	
port
   (
      Clk : in std_logic;
      Rst : in std_logic;
		En : in std_logic;
		Sen : in std_logic;
		Load : in std_logic;
      Input : in std_logic_vector (3 downto 0);
      Output : out std_logic_vector (3 downto 0)
   );
end entity Counter_4b;
 
architecture arch of Counter_4b is
signal s0,s1 : std_logic;
signal Q,new_Q : std_logic_vector (3 downto 0);

component FlipFlop_D 
port(Clk,Rst,D: in std_logic; Q: out std_logic);
end component;

begin
		s0 <= not Load or Rst;
		s1 <= not s0 or Rst;
		
		--Q0 = s0.Not()*in0 + s1.Not()*(q0.Not())
      --Q1 = s0.Not()*in1 + s1.Not()*(Sen*(q1.Not()*q0 + q1*q0.Not()) + Sen.Not()*(q1.Not()*q0.Not() + q1*q0))
      --Q2 = s0.Not()*in2 + s1.Not()*(Sen*(q2.Not()*q1*q0 + q2*q1.Not() + q2*q0.Not()) + Sen.Not()*(q2.Not()*q1.Not()*q0.Not() + q2*q1 + q2*q0))
      --Q3 = s0.Not()*in3 + s1.Not()*(Sen*(q3.Not()*q2*q1*q0 + q3*q2.Not() + q3*q1.Not() + q3*q0.Not()) + Sen.Not()*(q3.Not()*q2.Not()*q1.Not()*q0.Not() + q3*q2 + q3*q1 + q3*q0))

		new_Q(0) <= (not s0 and Input(0)) or (not s1 and not Q(0)); -- first part is the load
		new_Q(1) <= (not s0 and Input(1)) or (not s1 and (( Sen and ((not Q(1) and Q(0)) or (Q(1) and not Q(0)))) or (not Sen and ((not Q(1) and not Q(0)) or (Q(1) and Q(0))))));
		new_Q(2) <= (not s0 and Input(2)) or (not s1 and (( Sen and ((not Q(2) and Q(1) and Q(0)) or (Q(2) and not Q(1)) or (Q(2) and not Q(0)))) or (not Sen and ((not Q(2) and not Q(1) and not Q(0)) or (Q(2) and Q(1)) or (Q(2) and Q(0))))));
		new_Q(3) <= (not s0 and Input(3)) or (not s1 and (( Sen and ((not Q(3) and Q(2) and Q(1) and Q(0)) or (Q(3) and not Q(2)) or (Q(3) and not Q(1)) or (Q(3) and not Q(0)))) or (not Sen and ((not Q(3) and not Q(2) and not Q(1) and not Q(0)) or (Q(3) and Q(2)) or (Q(3) and Q(1)) or (Q(3) and Q(0))))));
				  
		ff0: FlipFlop_D port map(Clk, Rst, (En and new_Q(0)) or (not En and Q(0)), Q(0));
		ff1: FlipFlop_D port map(Clk, Rst, (En and new_Q(1)) or (not En and Q(1)), Q(1));
		ff2: FlipFlop_D port map(Clk, Rst, (En and new_Q(2)) or (not En and Q(2)), Q(2));
		ff3: FlipFlop_D port map(Clk, Rst, (En and new_Q(3)) or (not En and Q(3)), Q(3));
		
		Output <= Q;
end arch;