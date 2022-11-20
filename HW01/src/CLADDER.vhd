
library work;
use work.all;


entity partial_gen is
	port (
		a_i : in  bit;
		b_i : in  bit;
		g_o : out bit
	);
end entity partial_gen;

architecture rtl of partial_gen is

begin

	g_o <= a_i and b_i;

end architecture rtl;


entity partial_propagate is
	port (
		a_i : in  bit;
		b_i : in  bit;
		p_o : out bit
	);
end entity partial_propagate;

architecture rtl of partial_propagate is

begin

	p_o <= a_i xor b_i;

end architecture rtl;

entity sum_gen is
	port (
		a_i : in  bit;
		b_i : in  bit;
		c_i : in  bit;
		s_o : out bit
	);
end entity sum_gen;

architecture rtl of sum_gen is

begin

	s_o <= a_i xor b_i xor c_i;

end architecture rtl;
entity carry_gen is
	port (
		g_i : in  bit;
		p_i : in  bit;
		c_i : in  bit;
		c_o : out bit
	);
end entity carry_gen;

architecture rtl of carry_gen is

begin

	c_o <= g_i or (p_i and c_i);

end architecture rtl;


entity CLADDER is
	generic (
		size : integer := 8
	);
	Port (
		a    : in  bit_vector(size - 1 downto 0);
		b    : in  bit_vector(size - 1 downto 0);
		cin  : in  bit;
		c    : out bit_vector(size - 1 downto 0);
		cout : out bit;
		ov   : out bit
	);
end CLADDER;

architecture structural of CLADDER is
	signal p     : bit_vector(size-1 downto 0);
	signal g     : bit_vector(size-1 downto 0);
	signal carry : bit_vector(size downto 0);
begin
	ppgen : for i in 0 to size - 1 generate
		ppx : entity work.partial_propagate
			port map (
				a_i => a(i),
				b_i => b(i),
				p_o => p(i)
			);
	end generate ppgen;

	pggen : for i in 0 to size - 1 generate
		pgx : entity work.partial_gen
			port map (
				a_i => a(i),
				b_i => b(i),
				g_o => g(i)
			);
	end generate pggen;

	cgen : for i in 0 to size - 1 generate
		pgx : entity work.carry_gen
			port map (
				g_i => g(i),
				p_i => p(i),
				c_i => carry(i),
				c_o => carry(i+1)
			);
	end generate cgen;

	sumgen : for i in 0 to size - 1 generate
		sumx : entity work.sum_gen
			port map (
				a_i => a(i),
				b_i => b(i),
				c_i => carry(i),
				s_o => c(i)
			);
	end generate sumgen;


	carry(0) <= cin;
	cout     <= carry(size);
	ov       <= carry(size) xor carry(size-1);



end structural;
