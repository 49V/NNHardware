library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity bprop is
	Port(CLOCK_27	: in std_logic;
	     RESET   	: in std_logic;
	     GO		 	: in std_logic;
	     Y 			: in output_neuron_type;
	     Z  		: in bias_neuron_type;
	     W 			: in weight_neuron_type;

	     dCdB		: out bias_neuron_type;
	     dCdW		: out weight_neuron_type;
	     RDY		: out std_logic;
	     BUSY		: out std_logic
	     );
end bprop;
-- Weighted Inputs

architecture behavioural of bprop is
	signal q: std_logic;
	signal prev_inputs: input_neuron_type;
	signal state : std_logic_vector(2 downto 0);
begin

process(all)
	variable zed: zed_neuron_type;
	variable delta : bias_neuron_type;
begin
	-- Start by computing the output layer error
	-- backpropagate the error 
	-- the gradients are computed simply by just activations and deltas

	-- If RESET is enabled, initialize the Z to 0

	if(RESET = '0') then
		dCdB(0) <= to_signed(0, NEURON_BIT_SIZE);
		dCdB(1) <= to_signed(0, NEURON_BIT_SIZE);
		dCdB(2) <= to_signed(0, NEURON_BIT_SIZE);
		dCdW(0) <= to_signed(0, NEURON_BIT_SIZE);
		dCdW(1) <= to_signed(0, NEURON_BIT_SIZE);
		dCdW(2) <= to_signed(0, NEURON_BIT_SIZE);
		RDY <= '1';
		BUSY <= '0';
		state <= "000";
		delta(0) := to_signed(0, NEURON_BIT_SIZE * 2);
		delta(1) := to_signed(0, NEURON_BIT_SIZE * 2);
		delta(2) := to_signed(0, NEURON_BIT_SIZE * 2);

	elsif(RESET = '1') then
		if(rising_edge(CLOCK_27)) then
			case state is 
				when "000" =>
					if (GO == '1') then
						state <= "001";
						RDY <= '0';
						BUSY <= '1';
					else 
						state <= "000";
						RDY <= '1';
						BUSY <= '0';
					end if;
				when "001" =>
				-- get the last outputs for	 the deltas
					for i in range delta'range(2) loop
						delta(2,i) := (a(2,i) - y(2,i)) * sigmoid_primed_placeholder -- maybe use a seperate module to calculate this by feeding it values
					end loop;
					state <= "010";
					RDY <= '0';
					BUSY <= '1';
				when "010" = >
				-- Compute other delta layers
					for i in range delta'range(2) loop
						delta(1,i) := (W(i,2) * y(2,i)) * sigmoid_primed_placeholder -- maybe use a seperate module to calculate this by feeding it values
					end loop;
					state <= "011";
					RDY <= '0';
					BUSY <= '1';
				when "011" = >
					for i in range delta'range(2) loop
						delta(0,i) := (W(i,1) * y(1,i)) * sigmoid_primed_placeholder -- maybe use a seperate module to calculate this by feeding it values
					end loop;
					state <= "011";
					RDY <= '0';
					BUSY <= '1';
				when "100" =>
					for i in W'range(1) loop
						for j in delta'range(2) loop
							for k in W'range(2) loop  
								dCdW(i, k) <= a(i-1, k) * delta(i, j);
								dCdB(i, j) <= delta(i,j);
							end loop;
						end loop;	
					end loop;
					state <= "000";
					RDY <= '0';
					BUSY <= '1';
				when others =>
					state <= "000";
			end case;


		
		end if;
	end if;
end process;
	

end architecture;
