library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

-- I will need to create a 3D Array in the future. For the time being, focus on matrix multiplication!
-- i.e only propagate one layer
entity fprop is
	Port(CLOCK_27: in std_logic;
	     reset   : in std_logic;
	     inputs  : in input_neuron_type;
	     inputWeights : in input_weight_neuron_type;
	     hiddenWeights : in hidden_weight_neuron_type;
	     hiddenBiases  : in hidden_bias_neuron_type;
	     outputBiases  : in output_bias_neuron_type;
	     outputs : out output_neuron_type
	     );
-- Consider restructuring weights and biases into a single record

end fprop;
-- Weighted inputs

architecture behavioural of fprop is
	-- These are our different states for fprop (Init, input-> hidden, hidden->output, done)
	TYPE STATE_TYPE is (A, B, C, D, E); 
		signal state : STATE_TYPE;
	signal testHiddenZed : hidden_zed_neuron_type;
	signal testOutputZed : output_zed_neuron_type;
begin		 

	process(all)
	-- This initializes these variables to zero for every neural network size and every "NEURON_BIT_SIZE"
	variable hiddenZed: hidden_zed_neuron_type := ((others => (others => to_unsigned(0, NEURON_BIT_SIZE * 2))));
	variable outputZed: output_zed_neuron_type := ((others => (others => to_unsigned(0, NEURON_BIT_SIZE * 2))));
	variable hiddenOutputs: hidden_neuron_type := ((others => (others => to_unsigned(0, NEURON_BIT_SIZE))));
	variable reportInteger: integer;
	variable index : integer;
	variable biasesFlag: integer;
	begin
	
	if(reset) then
		index := 0;
		state <= A;
	
	elsif (rising_edge(CLOCK_27)) then
		-- The layers shall be denoted as input, hidden, and output layers, or L1, L2, and L3
		-- Where k is the kth neuron in the l + 1 layer, and j is the jth neuron in the lth layer
		-- outputs O[N2, 1] = Wkj[N2, N1] * Ij[N1, 1]
		case state is
			
			-- Input Layer to Hidden Layer
			when A =>
				if (index < inputWeights'length(FIRST_INDEX)) then
					-- You only want to add the hidden biases once per output element
					hiddenZed(index, 0) := hiddenZed(index, 0) + hiddenBiases(index, 0);
					for j in inputs'range(SECOND_INDEX) loop
						for k in inputWeights'range(SECOND_INDEX) loop
						hiddenZed(index, 0) := (hiddenZed(index, 0) + inputWeights(index, k) * inputs(k, j));
					
						-- Perceptron Activation function
						if (hiddenZed(index, 0) > to_unsigned(0, NEURON_BIT_SIZE * 2)) then
							hiddenOutputs(index, 0) := to_unsigned(1, NEURON_BIT_SIZE);
						else
							hiddenOutputs(index, 0) := to_unsigned(0, NEURON_BIT_SIZE);
						end if;

						end loop;
					end loop;
				index := index + 1;
				
				else
				index := 0;
				testHiddenZed <= hiddenZed;			
				state <= B;
				end if;

			-- Hidden Layer to Output Layer
			when B =>
				if (index < hiddenWeights'length(FIRST_INDEX)) then
					-- You only want to add the output biases once per output element
					outputZed(index, 0) := outputZed(index, 0) + outputBiases(index,0);
					for j in hiddenOutputs'range(SECOND_INDEX) loop
						for k in hiddenWeights'range(SECOND_INDEX) loop

						outputZed(index, 0) := outputZed(index, 0) + hiddenWeights(index, k) * hiddenOutputs(k, j);

						if(outputZed(index, 0) > to_unsigned(0, NEURON_BIT_SIZE * 2)) then
							outputs(index, 0) <= to_unsigned(1, NEURON_BIT_SIZE);
						else
							outputs(index, 0) <= to_unsigned(0, NEURON_BIT_SIZE);
						end if;

						end loop;
					end loop;
				index := index + 1;

				else
				index := 0;
				testOutputZed <= outputZed;
				state <= C;
				end if;
				
			-- Forward propagation complete
			when C =>
				report "Forward propagation complete";
				state <= D;
			
			when D =>
				
				state <= D;		

			when others =>
				state <= A;

			end case;

	end if;
	end process;



end architecture;