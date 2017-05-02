library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.TYPES.ALL;

entity nn_top is
	Port (CLOCK_27 : in std_logic;
	      RESET    : in std_logic
	      );
end nn_top;

architecture behavioural of nn_top is
	
	signal q : std_logic;
	begin
	
	q <= '1';


	end architecture;
