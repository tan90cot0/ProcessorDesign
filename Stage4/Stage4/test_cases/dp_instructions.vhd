-- TESTCASE AUTOGENERATED by gentest
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MyTypes.all;

entity mem is
PORT(
	wd : IN word;
	prog_add : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	data_add: in std_logic_vector(5 downto 0);
	MW: IN nibble;
	clock : in std_logic;
	rd : OUT word;
	IorD: in std_logic
	);
end entity;

architecture bev of mem is
    SIGNAL address_m: INTEGER RANGE 0 TO 63;
    signal address_i : INTEGER RANGE 0 TO 63;
    signal mem :  memory_type := (
0 => X"E3A00007",
1 => X"E3A0104A",
2 => X"E0012000",
3 => X"E0213000",
4 => X"E0414000",
5 => X"E0615000",
6 => X"E0816000",
7 => X"E0A17000",
8 => X"E0C18000",
9 => X"E0E19000",
10 => X"E1510000",
11 => X"E1710000",
12 => X"E181A000",
13 => X"E1E0B001",
14 => X"E1C1C000",
others => X"00000000" );
begin
    address_i<=to_integer(unsigned(prog_add));
    address_m<=to_integer(unsigned(data_add));
    rd<=mem(address_m+64) when IorD = '1' else mem(address_i);
    process(clock)
    begin
            if (rising_edge(clock)) then
            	IF(MW(0)='1')THEN
            		mem(address_m+64)(7 DOWNTO 0)<=wd(7 DOWNTO 0);
            	end if;
            	IF(MW(1)='1')THEN
           		mem(address_m+64)(15 DOWNTO 8)<=wd(15 DOWNTO 8);
            	end if;
            	IF(MW(2)='1')THEN
           		mem(address_m+64)(23 DOWNTO 16)<=wd(23 DOWNTO 16);
            	end if;
            	IF(MW(3)='1')THEN
           		mem(address_m+64)(31 DOWNTO 24)<=wd(31 DOWNTO 24);
            	end if;
         end if;
	  END PROCESS;
END BEV;
