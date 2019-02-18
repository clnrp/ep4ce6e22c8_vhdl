-- ep4ce6e22c8 - test microcontroller
-- 8-bit Counter
-- Author: Cleoner Pietralonga 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_8b is
	
port
   (
      Clk : in std_logic;
      Rst : in std_logic;
		En : in std_logic;
		Load : in std_logic;
      Input : in std_logic_vector (8 downto 0);
      Output : out std_logic_vector (8 downto 0)
   );
end entity Counter_8b;
 
architecture arch of Counter_8b is
signal s0,s1 : std_logic;
signal Q,new_Q : std_logic_vector (8 downto 0);

component FlipFlop_D 
port(Clk,Rst,D: in std_logic; Q: out std_logic);
end component;

begin
		s0 <= not Load or Rst;
		s1 <= not s0 or Rst;
		
		--Q0 = s0.Not()*in0 + s1.Not()*(q0.Not())
      --Q1 = s0.Not()*in1 + s1.Not()*(q1.Not()*q0 + q1*q0.Not())
      --Q2 = s0.Not()*in2 + s1.Not()*(q2.Not()*q1*q0 + q2*q1.Not() + q2*q0.Not())
      --Q3 = s0.Not()*in3 + s1.Not()*(q3.Not()*q2*q1*q0 + q3*q2.Not() + q3*q1.Not() + q3*q0.Not())
      --Q4 = s0.Not()*in4 + s1.Not()*(q4.Not()*q3*q2*q1*q0 + q4*q3.Not() + q4*q2.Not() + q4*q1.Not() + q4*q0.Not())
      --Q5 = s0.Not()*in5 + s1.Not()*(q5.Not()*q4*q3*q2*q1*q0 + q5*q4.Not() + q5*q3.Not() + q5*q2.Not() + q5*q1.Not() + q5*q0.Not())
      --Q6 = s0.Not()*in6 + s1.Not()*(q6.Not()*q5*q4*q3*q2*q1*q0 + q6*q5.Not() + q6*q4.Not() + q6*q3.Not() + q6*q2.Not() + q6*q1.Not() + q6*q0.Not())
      --Q7 = s0.Not()*in7 + s1.Not()*(q7.Not()*q6*q5*q4*q3*q2*q1*q0 + q7*q6.Not() + q7*q5.Not() + q7*q4.Not() + q7*q3.Not() + q7*q2.Not() + q7*q1.Not() + q7*q0.Not())
		  
		new_Q(0) <= (not s0 and Input(0)) or (not s1 and not Q(0)); -- first part is the load
		new_Q(1) <= (not s0 and Input(1)) or (not s1 and ((not Q(1) and Q(0)) 
		or (Q(1) and not Q(0))));
		
		new_Q(2) <= (not s0 and Input(2)) or (not s1 and ((not Q(2) and Q(1) and Q(0)) 
		or (Q(2) and not Q(1)) or (Q(2) and not Q(0)) ));
		
		new_Q(3) <= (not s0 and Input(3)) or (not s1 and ((not Q(3) and Q(2) and Q(1) and Q(0)) 
		or (Q(3) and not Q(2)) or (Q(3) and not Q(1)) or (Q(3) and not Q(0)) ));
		
		new_Q(4) <= (not s0 and Input(4)) or (not s1 and ((not Q(4) and Q(3) and Q(2) and Q(1) and Q(0)) 
		or (Q(4) and not Q(3)) or (Q(4) and not Q(2)) or (Q(4) and not Q(1)) or (Q(4) and not Q(0)) ));
		
		new_Q(5) <= (not s0 and Input(5)) or (not s1 and ((not Q(5) and Q(4) and Q(3) and Q(2) and Q(1) and Q(0)) 
		or (Q(5) and not Q(4)) or (Q(5) and not Q(3)) or (Q(5) and not Q(2)) or (Q(5) and not Q(1)) or (Q(5) and not Q(0)) ));
		
		new_Q(6) <= (not s0 and Input(6)) or (not s1 and ((not Q(6) and Q(5) and Q(4) and Q(3) and Q(2) and Q(1) and Q(0)) 
		or (Q(6) and not Q(5)) or (Q(6) and not Q(4)) or (Q(6) and not Q(3)) or (Q(6) and not Q(2)) or (Q(6) and not Q(1)) or (Q(6) and not Q(0)) ));
		
		new_Q(7) <= (not s0 and Input(7)) or (not s1 and ((not Q(7) and Q(6) and Q(5) and Q(4) and Q(3) and Q(2) and Q(1) and Q(0)) 
		or (Q(7) and not Q(6)) or (Q(7) and not Q(5)) or (Q(7) and not Q(4)) or (Q(7) and not Q(3)) or (Q(7) and not Q(2)) or (Q(7) and not Q(1)) or (Q(7) and not Q(0)) ));
				
		ff0: FlipFlop_D port map(Clk, Rst, (En and new_Q(0)) or (not En and Q(0)), Q(0));
		ff1: FlipFlop_D port map(Clk, Rst, (En and new_Q(1)) or (not En and Q(1)), Q(1));
		ff2: FlipFlop_D port map(Clk, Rst, (En and new_Q(2)) or (not En and Q(2)), Q(2));
		ff3: FlipFlop_D port map(Clk, Rst, (En and new_Q(3)) or (not En and Q(3)), Q(3));
		ff4: FlipFlop_D port map(Clk, Rst, (En and new_Q(4)) or (not En and Q(4)), Q(4));
		ff5: FlipFlop_D port map(Clk, Rst, (En and new_Q(5)) or (not En and Q(5)), Q(5));
		ff6: FlipFlop_D port map(Clk, Rst, (En and new_Q(6)) or (not En and Q(6)), Q(6));
		ff7: FlipFlop_D port map(Clk, Rst, (En and new_Q(7)) or (not En and Q(7)), Q(7));
		
		Output <= Q;
end arch;