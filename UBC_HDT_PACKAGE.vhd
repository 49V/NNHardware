library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

package types is
    constant NEURON_BIT_SIZE      : positive := 5; -- Bit resolution of neuron type
    constant INPUT_LAYER_NEURONS  : positive := 3; -- Number of neurons in input layer
    constant HIDDEN_LAYER_NEURONS : positive := 4; -- Number of neurons in hidden layer
    constant OUTPUT_LAYER_NEURONS : positive := 2; -- Number of neurons in output layer	
    constant FIRST_INDEX          : positive := 1; -- Index for accessing the first value of 'range, 'length, etc.
    constant SECOND_INDEX         : positive := 2; -- Index for accessing the second value of 'range, 'length, etc.

    type hidden_bias_neuron_type   is array (0 to HIDDEN_LAYER_NEURONS - 1, 0 to 0) of unsigned ((NEURON_BIT_SIZE - 1) downto 0);
    type output_bias_neuron_type is array (0 to OUTPUT_LAYER_NEURONS - 1, 0 to 0) of unsigned((NEURON_BIT_SIZE -1) downto 0);
    
    type input_weight_neuron_type is array (0 to HIDDEN_LAYER_NEURONS - 1, 0 to INPUT_LAYER_NEURONS - 1) of unsigned((NEURON_BIT_SIZE - 1) downto 0);
    type hidden_weight_neuron_type is array (0 to OUTPUT_LAYER_NEURONS - 1, 0 to HIDDEN_LAYER_NEURONS - 1) of unsigned((NEURON_BIT_SIZE -1) downto 0);

    type hidden_zed_neuron_type is array (0 to HIDDEN_LAYER_NEURONS - 1, 0 to 0) of unsigned (((NEURON_BIT_SIZE * 2) - 1) downto 0);
    type output_zed_neuron_type is array (0 to OUTPUT_LAYER_NEURONS - 1, 0 to 0) of unsigned (((NEURON_BIT_SIZE * 2) - 1) downto 0);
	    
    --- Consider turning this into a record (Neural Network)
    type input_neuron_type  is array (0 to INPUT_LAYER_NEURONS  - 1, 0 to 0) of unsigned ((NEURON_BIT_SIZE - 1) downto 0);
    type hidden_neuron_type is array (0 to HIDDEN_LAYER_NEURONS - 1, 0 to 0) of unsigned ((NEURON_BIT_SIZE - 1) downto 0);
    type output_neuron_type is array (0 to OUTPUT_LAYER_NEURONS - 1, 0 to 0) of unsigned ((NEURON_BIT_SIZE - 1) downto 0);	
end types;
