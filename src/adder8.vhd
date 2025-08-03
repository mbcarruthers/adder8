library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity d_flop is
    Port(
        D      : in  std_logic;
        Clk    : in  std_logic;
        Output : out std_logic
    );
end entity;

architecture RTL of d_flop is
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if (D = '1') then
                Output <= '1';
            else
                Output <= '0';
            end if;
        end if;
    end process;
end architecture;

library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity adder4 is
    Port(
        Clk : in std_logic
        -- Clear : in std_logic
    );
end entity;

architecture RTL of adder4 is
    signal Clear : std_logic := '0'; 
    signal N : std_logic_vector(3 downto 0); 
begin
    Clear <= '1' when (N(0) and N(1) and N(2) and N(3)) else '0';
    b0 : entity work.d_flop
        Port map(
            D      => (not N(0)) and not Clear,
            Clk    => Clk,
            Output => N(0)
        );
    b1 : entity work.d_flop
        Port map(
            D      => (N(0) xor N(1)) and not Clear,
            Clk    => Clk,
            Output => N(1)
        );
    b2 : entity work.d_flop
        Port map(
            D      => ((N(0) and N(1)) xor N(2)) and not Clear,
            Clk    => Clk,
            Output => N(2)
        );
    b3 : entity work.d_flop
        Port map(
            D      => ((N(0) and N(1) and N(2)) xor N(3)) and not Clear,
            Clk    => Clk,
            Output => N(3)
        );
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder8 is 
    Port(
        Clk : in std_logic
    );
end entity; 

architecture RTL of adder8 is 
    signal Clear : std_logic := '0';  
    signal N : std_logic_vector(7 downto 0); 
begin 
    Clear <= and N; 
   b0 : entity work.d_flop
    port map(
        D      => not N(0) and not Clear,
        Clk    => Clk,
        Output => N(0)
    );
   b1 : entity work.d_flop
    port map(
        D      => (N(0) xor N(1)) and not Clear,
        Clk    => Clk,
        Output => N(1)
    );
   b2 : entity work.d_flop
    port map(
        D      => ((N(0) and N(1)) xor N(2) )and not Clear,
        Clk    => Clk,
        Output => N(2)
    );
   b3 : entity work.d_flop
    port map(
        D      => ((N(0) and N(1) and N(2)) xor N(3)) and not Clear,
        Clk    => Clk,
        Output => N(3)
    );
    b4 : entity work.d_flop 
    port map(
        D => ((N(0) and N(1) and N(2) and N(3)) xor N(4)) and not Clear,
        Clk => Clk, 
        Output => N(4) 
    );
    b5 : entity work.d_flop
        port map(
            D      => ((N(0) and N(1) and N(2) and N(3) and N(4)) xor N(5)) and not Clear,
            Clk    => Clk,
            Output => N(5)
        );
    b6 : entity work.d_flop 
    Port map(
        D => ((N(0) and N(1) and N(2) and N(3) and N(4) and N(5) ) xor N(6)) and not Clear,
        Clk => Clk, 
        Output => N(6) 
    );
    b7 : entity work.d_flop
        port map(
            D      => ((N(0) and N(1) and N(2) and N(3) and N(4) and N(5) and N(6)) xor N(7)) and not Clear,
            Clk    => Clk,
            Output => N(7) 
        );
end architecture; 