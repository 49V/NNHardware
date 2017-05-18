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

architecture behavioural of fprop is
	signal q: std_logic;
begin

	process(all)
	begin
	-- If RESET is enabled, initialize the OUTPUTS to 0
	if(rising_edge(CLOCK_27)) then

		if(RESET = '0') then
			for i in OUTPUTS'range(1) loop
				OUTPUTS(i) <= to_signed(0, NEURON_BIT_SIZE - 1);
			end loop;	

		else
		-- The layers shall be denoted as input, hidden, and output layers, or L1, L2, and L3
		-- Where k is the kth neuron in the l + 1 layer, and j is the jth neuron in the lth layer
		-- Outputs O[N2, 1] = Wkj[N2, N1] * Ij[N1, 1]
			for i in WEIGHTS'range(1) loop
				for j in INPUTS'range(2) loop
					for k in WEIGHTS'range(2) loop
					OUTPUTS(i) <= WEIGHTS(i, k) * INPUTS(k, j); 
					end loop;
				end loop;
			end loop;	
		end if;
	end if;
	end process;
	
	process(all)
	begin

	if(rising_edge(CLOCK_27)) then

	end if;
	end process;

end architecture;