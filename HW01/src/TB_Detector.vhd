library work;
use work.all;

entity tb_moore_detector is
end tb_moore_detector;

architecture Behavioral of tb_moore_detector is

	--Inputs
	signal arst : bit := '0';
	signal clk  : bit := '0';
	signal din  : bit := '0';

	signal sequence : bit_vector(28 downto 0);

	signal clock_period : time := 100 ns;
	--outputs
	signal dout_moore : bit;
	signal dout_mealy : bit;
begin

	-- sequence for test
	sequence <= "00110101110110110010111011100";

	fsm_moore : entity work.detector(behave_moore) port map (
		arst => arst,
		clk  => clk,
		din  => din,
		dout => dout_moore
	);

	fsm_mealy : entity work.detector(behave_mealy) port map (
		arst => arst,
		clk  => clk,
		din  => din,
		dout => dout_mealy
	);

	-- clock generation
	clk <= not clk after clock_period/2;

	-- assign sequence data to din input at every cycle
	din_proc : process
	begin
		-- FSM Reset
		arst <= '1';
		wait for clock_period / 2 ;
		arst <= '0';
		din_loop : for index in sequence'range loop
			din <= sequence(index);
			wait for clock_period;
		end loop din_loop;
	end process ; -- din_proc

end Behavioral;
