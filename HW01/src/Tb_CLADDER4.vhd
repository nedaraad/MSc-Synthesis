library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;



entity tb_CLAADDER4 is
end entity ; -- tb_CLAADDER4


architecture arch of tb_CLAADDER4 is
component CLAADDER4 is
	port (
		a    : in  bit_vector(3 downto 0) ;
		b    : in  bit_vector(3 downto 0) ;
		cin  : in  bit ;
		c    : out bit_vector(3 downto 0) ;
		cout : out bit ;
		ov   : out bit
	);
end component CLAADDER4;

--Inputs
signal a : bit_vector(3 downto 0) := (others => '0');
signal b : bit_vector(3 downto 0) := (others => '0');
signal cin : bit := '0';
 
--Outputs
signal c : bit_vector(3 downto 0);
signal cout : bit;
signal ov : bit;

BEGIN
uut: CLAADDER4 PORT MAP (
a => a,
b => b,
cin => cin,
c => c,
cout => cout,
ov => ov
);

cin  <= not cin after 01 ns;

b(0) <=  not b(0) after 02 ns;
b(1) <=  not b(1) after 08 ns;
b(2) <=  not b(2) after 32 ns;
b(3) <=  not b(3) after 128 ns;

a(0)  <= not a(0) after 04 ns;  
a(1)  <= not a(1) after 16 ns;
a(2)  <= not a(2) after 64 ns;
a(3)  <= not a(3) after 256 ns;

end architecture ; -- arch
