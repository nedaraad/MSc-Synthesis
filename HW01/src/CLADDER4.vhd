entity pfa is
    port (
        a   : in  bit;
        b   : in  bit;
        cin : in  bit;
        c   : out bit;
        g   : out bit;
        p   : out bit
    ) ;
end entity ; -- pfa

architecture arch of pfa is

begin

    c <= a xor b xor cin;
    g <= a and b;
    p <= a xor b;

end architecture ; -- arch

entity CLAADDER4 is
    port (
        a    : in  bit_vector(3 downto 0) ;
        b    : in  bit_vector(3 downto 0) ;
        cin  : in  bit ;
        c    : out bit_vector(3 downto 0) ;
        cout : out bit ;
        ov   : out bit
    );
end CLAADDER4;

architecture concurrent of CLAADDER4 is
    component pfa is
        port (
            a   : in  bit;
            b   : in  bit;
            cin : in  bit;
            c   : out bit;
            g   : out bit;
            p   : out bit
        ) ;
    end component ; -- pfa

    signal c0, c1, c2, c3, c4: bit;
    signal p, g : bit_vector(3 downto 0);

begin

        pfa0 : pfa port map (a=> a(0), b=> b(0), cin=> c0, c => c(0), g=> g(0), p=> p(0));
        pfa1 : pfa port map (a=> a(1), b=> b(1), cin=> c1, c => c(1), g=> g(1), p=> p(1));
        pfa2 : pfa port map (a=> a(2), b=> b(2), cin=> c2, c => c(2), g=> g(2), p=> p(2));
        pfa3 : pfa port map (a=> a(3), b=> b(3), cin=> c3, c => c(3), g=> g(3), p=> p(3));

        c0 <= cin;
        c1 <= g(0) or (p(0) and cin);
        c2 <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
        c3 <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or
              (p(2) and p(1) and p(0) and cin);
        c4 <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or
              (p(3) and p(2) and p(1) and g(0)) or 
              (p(3) and p(2) and p(1) and p(0) and cin);
        
        cout <= c4;
        ov <= c3 xor c4;
end;
