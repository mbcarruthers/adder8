library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_adder8 is
end entity;

architecture RTL of tb_adder8 is
    signal Clk, Clear : std_logic := '0'; 
begin
    uut : entity work.adder8
        Port map(
            Clk   => Clk, 
            Clear => Clear
        );
      
    process
    begin
        Clk <= '0'; 
        Clear <= '1'; 
        wait for 10 ns; 
        Clear <= '0'; 

        for i in 0 to 511 loop
            Clk <= not Clk; -- '1' when(Clk = '0') else '0' when(Clk = '1'); 
            wait for 10 ns;
        end loop; 

        Clk <= '1'; 
        wait for 10 ns; 

        Clk <= '0'; 
        Clear <= '1'; 
        wait for 20 ns; 
        
        wait;
    end process;
end architecture;

