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
	signal prev_inputs: input_neuron_type;
begin

process(all)
	variable zed: output_neuron_type;
begin
	-- If RESET is enabled, initialize the Z to 0

	if(RESET = '0') then
		OUTPUTS(0) <= to_signed(0, NEURON_BIT_SIZE * 2);
		OUTPUTS(1) <= to_signed(0, NEURON_BIT_SIZE * 2);
		OUTPUTS(2) <= to_signed(0, NEURON_BIT_SIZE * 2);
		zed(0) := to_signed(0, NEURON_BIT_SIZE * 2);
		zed(1) := to_signed(0, NEURON_BIT_SIZE * 2);
		zed(2) := to_signed(0, NEURON_BIT_SIZE * 2);
		prev_inputs(0, 0) <= to_signed(0, NEURON_BIT_SIZE);
		prev_inputs(1, 0) <= to_signed(0, NEURON_BIT_SIZE);

	elsif(RESET = '1') then
		if(rising_edge(CLOCK_27)) then
			-- The layers shall be denoted as input, hidden, and output layers, or L1, L2, and L3
			-- Where k is the kth neuron in the l + 1 layer, and j is the jth neuron in the lth layer
			-- OUTPUTS O[N2, 1] = Wkj[N2, N1] * Ij[N1, 1]
			for i in WEIGHTS'range(1) loop
				for j in INPUTS'range(2) loop
					for k in WEIGHTS'range(2) loop
						if(prev_inputs(k,j) /= INPUTS(k,j)) then
							zed(i) := zed(i) + WEIGHTS(i, k) * INPUTS(k, j); 
						end if;
						prev_inputs(k,j) <= INPUTS(k,j);
					end loop;
				end loop;	

				if((zed(i) + BIASES(i))> 0) then
					OUTPUTS(i) <= to_signed(1, NEURON_BIT_SIZE*2);
				else
					OUTPUTS(i) <= to_signed(0, NEURON_BIT_SIZE*2);
				end if;

			end loop;
		end if;
	end if;
end process;
	

end architecture;
