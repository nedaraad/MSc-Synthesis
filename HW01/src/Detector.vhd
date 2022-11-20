
entity detector is
  Port (
    arst : in  bit;
    clk  : in  bit;
    din  : in  bit;
    dout : out bit
  );
end detector;

architecture behave_moore of detector is

  type states is (start, get_1, get_11, get_110, get_1101, get_11011, trap);
  
  signal c_state, n_state : states ;

begin

  process (arst, clk)
  begin
     if (arst = '1') then
        c_state <= start;
      elsif clk'event and clk='1' then
        c_state <= n_state;
      end if;
  end process;

  moore_proc : process(c_state, din)
  begin
    case (c_state) is
      when start =>
        if din='1' then
          n_state <= get_1;
        else
          n_state <= start;
        end if;
      when get_1 =>
        if din='1' then
          n_state <= get_11;
        else
          n_state <= start;
        end if;
      when get_11 =>
        if din='1' then
          n_state <= get_11;
        else
          n_state <= get_110;
        end if;
      when get_110 =>
        if din='1' then
          n_state <= get_1101;
        else
          n_state <= start;
        end if;
      when get_1101 =>
        if din='1' then
          n_state <= get_11011;
        else
          n_state <= start;
        end if;
      when get_11011 =>
        if din='1' then
          n_state <= get_11;
        else
          n_state <= get_110;
        end if;
      when others =>
        n_state <= trap;
    end case;
  end process ; -- moore_proc

  dout <= '1' when c_state = get_11011 else '0';

end behave_moore ;

architecture behave_mealy of detector is

  type states is (start, get_1, get_11, get_110, get_1101, trap);
  signal c_state, n_state : states ;

begin

  process (arst, clk)
  begin
     if (arst = '1') then
        c_state <= start;
      elsif clk'event and clk='1' then
        c_state <= n_state;
      end if;
  end process;

  mealy_proc : process(c_state, din)
  begin
    dout <= '0';
    case (c_state) is
      when start =>
        if din='1' then
          n_state <= get_1;
        else
          n_state <= start;
        end if;
      when get_1 =>
        if din='1' then
          n_state <= get_11;
        else
          n_state <= start;
        end if;
      when get_11 =>
        if din='1' then
          n_state <= get_11;
        else
          n_state <= get_110;
        end if;
      when get_110 =>
        if din='1' then
          n_state <= get_1101;
        else
          n_state <= start;
        end if;
      when get_1101 =>
        if din='1' then
          n_state <= get_11;
          dout <= '1';
        else
          n_state <= start;
        end if;
      when others =>
        n_state <= trap;
    end case;
end process ; -- mealy_proc

end architecture ; -- behave_mealy
