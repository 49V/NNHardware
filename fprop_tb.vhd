library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity fprop_tb is
end fprop_tb;

architecture behavioural of fprop_tb is
component fprop
Port(	CLOCK_27 : in std_logic;
     	RESET    : in std_logic;
     	INPUTS   : in input_neuron_type;
     	WEIGHTS  : in weight_neuron_type;
     	BIASES   : in bias_neuron_type;
    	OUTPUTS  : out output_neuron_type
     );
end component;

signal CLOCK_27_TB: std_logic;
signal RESET_TB   : std_logic;
signal INPUTS_TB  : input_neuron_type;
signal inputs2  : input_neuron_type;
signal WEIGHTS_TB : weight_neuron_type;
signal BIASES_TB  : bias_neuron_type;
signal outputs1  : output_neuron_type;
signal OUTPUTS_TB  : output_neuron_type;

begin

	layer1: fprop port map(	CLOCK_27 => CLOCK_27_TB,
	                    	RESET    => RESET_TB,
							INPUTS   => INPUTS_TB,
			    			WEIGHTS  => WEIGHTS_TB,
			    			BIASES   => BIASES_TB,
	   		    			OUTPUTS  => outputs1);

	layer2: fprop port map(	CLOCK_27 => CLOCK_27_TB,
	                    	RESET    => RESET_TB,
		    				INPUTS   => inputs2,
			    			WEIGHTS  => WEIGHTS_TB,
			    			BIASES   => BIASES_TB,
		    				OUTPUTS  => OUTPUTS_TB);


	process
	begin
		for i in inputs2'range loop
			inputs2(i, 0) <= outputs1(i);
		end loop;
		wait for 1 ns;
	end process;

	process
	begin
	    
	    CLOCK_27_TB <= '0';
	    wait for 10 ns;
	    CLOCK_27_TB <= '1';
	    wait for 10 ns;
	end process;

	process
	begin

		-- Initialize Inputs
		for i in INPUTS_TB'range loop
			INPUTS_TB(i, 0) <= to_signed(i + 1, NEURON_BIT_SIZE);
		end loop;
		
		-- Initialize Biases
		for j in BIASES_TB'range loop
			BIASES_TB(j) <= to_signed(j + 1, NEURON_BIT_SIZE);
		end loop;

		-- Initialize Weights
		for k in WEIGHTS_TB'range(1) loop
			for l in WEIGHTS_TB'range(2) loop
				WEIGHTS_TB(k, l) <= to_signed(k, NEURON_BIT_SIZE);
			end loop;
		end loop;

		RESET_TB <= '0';
		wait for 10 ns;
		RESET_TB <= '1';

		wait for 100 ns;	
	end process;

end architecture;
			

