library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MyTypes.all;
use IEEE.NUMERIC_STD.ALL;

entity shifter16 is
 Port  (
 		input: in word;
 		sel: in std_logic;
 		shift_type: in bit_pair;
        carryin: in std_logic;
   		carryout: out std_logic;
    	output: out word
    );
 end shifter16;

architecture beh of shifter16 is
begin 
process(input,sel)
begin
if(sel='1') then
	if(shift_type = "00") then
      output(31 downto 16)<=input(15 downto 0);
      output(15 downto 0)<="0000000000000000";
      
    else
	output(15 downto 0)<=input(31 downto 16);
    
    with shift_type select
    output(31 downto 16)<=  "0000000000000000" when "00",
                  "0000000000000000" when "01",
                  input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) & input(31) when "10",
                  input(15 downto 0) when "11",
                  "0000000000000000" when others;
    carryout<= input(15);
    end if;
    
else
	output<=input;
    carryout<=carryin;
end if;

end process;
end beh;