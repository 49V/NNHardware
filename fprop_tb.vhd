library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity fprop_tb is
end fprop_tb;

architecture behavioural of fprop_tb is
	component fprop
	Port(CLOCK_27 : in std_logic;
	     reset    : in std_logic;
	     inputs   : in input_neuron_type;
             inputWeights  : in weight_input_neuron_type;
	     hiddenWeights : in weight_hidden_neuron_type;
	     hiddenBiases : in bias_hidden_neuron_type;
	     outputBiases : in bias_output_neuron_type;
             outputs  : out output_neuron_type
	     );
	end component;

signal CLOCK_27TB: std_logic;
signal resetTB   : std_logic;
signal inputsTB  : input_neuron_type;
signal inputWeightsTB : weight_input_neuron_type;
signal hiddenWeightsTB : weight_hidden_neuron_type;
signal hiddenBiasesTB  : bias_hidden_neuron_type;
signal outputBiasesTB : bias_output_neuron_type;
signal outputsTB  : output_neuron_type;

begin

dut: fprop port map(CLOCK_27 => CLOCK_27TB,
                    reset    => resetTB,
		    inputs   => inputsTB,
		    inputWeights  => inputWeightsTB,
		    hiddenWeights => hiddenWeightsTB,
		    hiddenBiases   => hiddenBiasesTB,
		    outputBiases => outputBiasesTB,
   		    outputs  => outputsTB);
process
begin
    
    CLOCK_27TB <= '0';
    wait for 10 ns;
    CLOCK_27TB <= '1';
    wait for 10 ns;
end process;

process
begin

	-- Initialize inputs
	for i in inputsTB'range loop
		inputsTB(i, 0) <= to_unsigned(i + 1, NEURON_BIT_SIZE);
		--report "inputs: The value of i (rows) is " & integer'image(i);
	end loop;
	
	-- Initialize hiddenBiases
	for j in hiddenBiasesTB'range loop
		hiddenBiasesTB(j, 0) <= "00";
		--report "hiddenBiases: The value of j (rows) is " & integer'image(j);
	end loop;

	-- Initialize outputBiases

	-- Initialize inputWeights
	for k in inputWeightsTB'range(1) loop
		for l in inputWeightsTB'range(2) loop
			inputWeightsTB(k, l) <= to_unsigned(k, NEURON_BIT_SIZE);
			--report "inputWeights: The value of k (rows) is " & integer'image(k);
			--report "inputWeights: The value of l (columns) is " & integer'image(l);
		end loop;
	end loop;

	-- Initialize hiddenWeights
	for m in hiddenWeightsTB'range(1) loop
		for n in hiddenWeightsTB'range(2) loop
		hiddenWeightsTB(m, n) <= to_unsigned(n, NEURON_BIT_SIZE);
		end loop;
	end loop;

	resetTB <= '1';
	wait for 10 ns;
	resetTB <= '0';
	wait for 1000 ns;	
end process;

end architecture;
			

