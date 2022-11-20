library work;
use work.all;

entity tb_claadder is
end tb_claadder;

architecture bench of tb_claadder is
    
    signal a: bit_vector(7 downto 0) := (others => '0');
    signal b: bit_vector(7 downto 0) := (others => '0');
    signal cin: bit:= '0' ;
    signal sum8: bit_vector(7 downto 0);
    signal sum4: bit_vector(3 downto 0);
    signal cout8: bit;
    signal cout4: bit;
    signal overflow8: bit;
    signal overflow4: bit;
    
begin

    cla8bit: entity work.CLADDER 
        generic map(
            size => 8
        )
        port map(
            a => a,
            b => b,
            cin => cin,
            c =>sum8,
            cout => cout8,
            ov => overflow8
        );
        
    cla4bit: entity work.CLADDER 
        generic map(
            size => 4
        )
        port map(
            a => a(3 downto 0),
            b => b(3 downto 0),
            cin => cin,
            c =>  sum4,
            cout => cout4,
            ov => overflow4
        );

   a <= X"00", 
        X"11" after 010 ns,
        X"22" after 020 ns,
        X"33" after 030 ns,
        X"44" after 040 ns,
        X"55" after 050 ns,
        X"66" after 060 ns,
        X"77" after 070 ns,
        X"88" after 080 ns,
        X"99" after 090 ns,
        X"5A" after 100 ns,
        X"4B" after 110 ns,
        X"3C" after 120 ns;

   b <= X"00",              
        X"0A" after 015 ns,
        X"2B" after 025 ns,        
        X"3C" after 035 ns,
        X"4D" after 045 ns,
        X"5E" after 055 ns,
        X"6F" after 065 ns,
        X"44" after 075 ns,
        X"55" after 085 ns,
        X"D8" after 095 ns,
        X"66" after 105 ns,
        X"AA" after 115 ns,
        X"BB" after 125 ns;

end bench;