library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

-- I will need to create a 3D Array in the future. For the time being, focus on matrix multiplication!
-- i.e only propagate one layer
entity fprop is
	Port(CLOCK_27: in std_logic;
	     RESET   : in std_logic;
	     INPUTS  : in input_neuron_type;
	     WEIGHTS : in weight_neuron_type;
	     BIASES  : in bias_neuron_type;
	     OUTPUTS : out output_neuron_type
	     );
end fprop;
-- Weighted Inputs

architecture behavioural of fprop is
	signal q: std_logic;
begin

	process(all)
	variable ZED: output_neuron_type;
	variable reportInteger: integer;
	variable FLAG: integer;
	begin
	-- If RESET is enabled, initialize the Z to 0
	

	if(RESET = '0') then
		OUTPUTS(0) <= to_unsigned(0, NEURON_BIT_SIZE * 2);
		OUTPUTS(1) <= to_unsigned(0, NEURON_BIT_SIZE * 2);
		OUTPUTS(2) <= to_unsigned(0, NEURON_BIT_SIZE * 2);
		ZED(0) := to_unsigned(0, NEURON_BIT_SIZE * 2);
		ZED(1) := to_unsigned(0, NEURON_BIT_SIZE * 2);
		ZED(2) := to_unsigned(0, NEURON_BIT_SIZE * 2);
		FLAG := 0;

	elsif((RESET = '1') AND (FLAG = 0)) then
		if(rising_edge(CLOCK_27)) then
		-- The layers shall be denoted as input, hidden, and output layers, or L1, L2, and L3
		-- Where k is the kth neuron in the l + 1 layer, and j is the jth neuron in the lth layer
		-- OUTPUTS O[N2, 1] = Wkj[N2, N1] * Ij[N1, 1]
			for i in WEIGHTS'range(1) loop
				for j in INPUTS'range(2) loop
					for k in WEIGHTS'range(2) loop
					ZED(i) := ZED(i) + WEIGHTS(i, k) * INPUTS(k, j);

					reportInteger := to_integer(ZED(i));
					report "i: " & integer'image(i);
					report "j: " & integer'image(j);
					report "k: " & integer'image(k);
 					report "ZED (i); " & integer'image(reportInteger);
					end loop;
				end loop;
			end loop;	
		OUTPUTS <= ZED;
		FLAG := 1;
		end if;
	end if;
	end process;
	

end architecture;