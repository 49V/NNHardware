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
	     inputWeights : in weight_input_neuron_type;
	     hiddenWeights : in weight_hidden_neuron_type;
	     hiddenBiases  : in bias_hidden_neuron_type;
	     outputBiases  : in bias_output_neuron_type;
	     outputs : out output_neuron_type
	     );
-- Consider restructuring weights and biases into a single record

end fprop;
-- Weighted inputs

architecture behavioural of fprop is
	-- These are our different states for fprop (Init, input-> hidden, hidden->output, done)
	TYPE STATE_TYPE is (A, B, C, D, E); 
		signal state : STATE_TYPE;
begin		 

	process(all)
	variable hiddenZed: zed_hidden_neuron_type := ((others => (others => "0000")));
	variable outputZed: zed_output_neuron_type := ((others => (others => "0000")));
	variable hiddenOutputs: hidden_neuron_type := ((others => (others => "00")));
	variable reportInteger: integer;
	begin
	
	if(reset) then
		state <= A;

	elsif (rising_edge(CLOCK_27)) then
		-- The layers shall be denoted as input, hidden, and output layers, or L1, L2, and L3
		-- Where k is the kth neuron in the l + 1 layer, and j is the jth neuron in the lth layer
		-- outputs O[N2, 1] = Wkj[N2, N1] * Ij[N1, 1]
		case state is
			
			-- Input Layer to Hidden Layer
			when A =>
				for i in inputWeights'range(1) loop
					for j in inputs'range(2) loop
						for k in inputWeights'range(2) loop
						hiddenZed(i, 0) := (hiddenZed(i, 0) + inputWeights(i, k) * inputs(k, j));
					
						-- Perceptron Activation function
						if (hiddenZed(i, 0) > to_unsigned(0, NEURON_BIT_SIZE * 2)) then
							hiddenOutputs(i, 0) := to_unsigned(1, NEURON_BIT_SIZE);
						else
							hiddenOutputs(i, 0) := to_unsigned(0, NEURON_BIT_SIZE);
						end if;

						end loop;
					end loop;
				end loop;

				report "hiddenZed Index 0 " & integer'image(to_integer(hiddenZed(0,0)));
				report "hiddenZed Index 1 " & integer'image(to_integer(hiddenZed(1,0)));				
				state <= B;
			
			-- Hidden Layer to Output Layer
			when B =>
				for i in hiddenWeights'range(1) loop
					for j in hiddenOutputs'range(2) loop
						for k in hiddenWeights'range(2) loop
						report "-------------------INDEX i -----------------" & integer'image(i);
						report "-------------------INDEX j -----------------" & integer'image(j);
						report "-------------------INDEX k------------------" & integer'image(k);
						outputZed(i, 0) := outputZed(i, 0) + hiddenWeights(i, k) * hiddenOutputs(k, j);

						if(outputZed(i, 0) > to_unsigned(0, NEURON_BIT_SIZE * 2)) then
							outputs(i, 0) <= to_unsigned(1, NEURON_BIT_SIZE);
						else
							outputs(i, 0) <= to_unsigned(0, NEURON_BIT_SIZE);
						end if;

						end loop;
					end loop;
				end loop;

				report "outputZed is " & integer'image(to_integer(outputZed(0,0)));

				state <= C;
				
			-- Output Layer
			when C =>

				state <= D;

			-- Forward propagation complete
			when D =>
				report "Forward propagation complete";
				state <= D;		

			when others =>
				state <= A;

			end case;

	end if;
	end process;



end architecture;