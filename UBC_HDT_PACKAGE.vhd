library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

package types is
    constant NEURON_BIT_SIZE      : positive := 2; -- Bit resolution of neuron type
    constant INPUT_LAYER_NEURONS  : positive := 2; -- Number of neurons in input layer
    constant HIDDEN_LAYER_NEURONS : positive := 3; -- Number of neurons in hidden layer
    constant OUTPUT_LAYER_NEURONS : positive := 1; -- Number of neurons in output layer
    constant NUM_HIDDEN_LAYERS 	  : positive := 2; -- Number of hidden layers
    type bias_neuron_type   is array (0 to HIDDEN_LAYER_NEURONS - 1) of signed ((NEURON_BIT_SIZE - 1) downto 0);
    type weight_neuron_type is array (0 to HIDDEN_LAYER_NEURONS - 1, 0 to INPUT_LAYER_NEURONS - 1) of signed((NEURON_BIT_SIZE - 1) downto 0);
    type input_neuron_type  is array (0 to INPUT_LAYER_NEURONS  - 1, 0 to 0) of signed ((NEURON_BIT_SIZE - 1) downto 0);
    type hidden_layer_type is array (0 to NUM_HIDDEN_LAYERS - 1) of hidden_neuron_type;
    type hidden_neuron_type is array (0 to HIDDEN_LAYER_NEURONS - 1) of signed ((NEURON_BIT_SIZE - 1) downto 0);
    type output_neuron_type is array (0 to HIDDEN_LAYER_NEURONS - 1) of signed (((NEURON_BIT_SIZE * 2) - 1) downto 0);
end types;