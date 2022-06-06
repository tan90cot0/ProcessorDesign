library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MyTypes.all;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
 Port  (
 		clock: in std_logic;
 		load_store: in load_store_type;
 		instr_class: in instr_class_type;
        Sh: inout word;
        Imm: in word;
        B: inout word;
   		IR: inout word;
    	op: out word;
        shift_result: in word;
        Offset: in word;
        Off: inout word;
        rot: in std_logic_vector (4 downto 0);
        shift1: in std_logic;
        shift2: in std_logic;
        shift4: in std_logic;
        shift8: in std_logic;
        shift16: in std_logic;
        s1: out std_logic;
        s2: out std_logic;
        s4: out std_logic;
        s8: out std_logic;
        s16: out std_logic;
        half: in std_logic;
        shift_mode: in std_logic;
        BW: in std_logic;
        fstate: in integer;
        rd2: in word;
        write_data_register: out word;
        DR: inout word;
        RES: inout word;
        M2R: in std_logic;
        Rn: in nibble;
        rad1: out nibble;
        wad: out nibble;
        A: inout word;
        AW: in std_logic;
        ShW: in std_logic;
        Rd: in nibble;
        rd1: in word;
        Memory_input: in word;
        byte_type: in std_logic_vector(2 downto 0);
        write_data_memory: out word;
        IW: in std_logic;
        DW: in std_logic;
        read_memory_data: in word;
        ex_offset: out word;
        p_c: in word;
        Asrc1: in std_logic;
        op1: out word;
        ReW: in std_logic;
        result: in word;
        Register_input: in word;
        write_back: in std_logic;
        post_pre: in std_logic;
        memory_address: out byte

    );
 end entity;

architecture beh of datapath is
begin 



    --setting operand of shifter
    process(clock)
    begin
        if(load_store = store and instr_class = DT) then
            op<=Sh;
        elsif(IR(25) = '1' and instr_class = DP) then
            op<=Imm;
        else 
            op<=B;
        end if;
    end process;




    --setting Offset
    process(clock)
    begin
    if(IR(27 downto 26) = "01" and IR(25) = '0') then
    	Off<=Offset;
    elsif(instr_class = DT and IR(25) = '0' and IR(22) = '1') then
    	Off<=Offset;
    elsif(instr_class = DT and IR(25) = '0' and IR(22) = '0') then
    	Off<=shift_result;
    else
    	Off<=shift_result;
    end if;
    end process;




    --setting shifts
    process(clock)
    begin
    if(IR(27 downto 25) = "001") then
    	s1<=rot(0);
        s2<=rot(1);
        s4<=rot(2);
        s8<=rot(3);
        s16<=rot(4);
    elsif(half = '1') then
    	s1<='0';
        s2<='0';
        s4<='0';
        s8<='0';
        s16<='0';
    elsif(shift_mode='1') then
    	s1<=Sh(0);
        s2<=Sh(1);
        s4<=Sh(2);
        s8<=Sh(3);
        s16<=Sh(4);
    else
    	s1<=shift1;
        s2<=shift2;
        s4<=shift4;
        s8<=shift8;
        s16<=shift16;   
    end if;
    end process;




    --setting register B
    process(BW)
    begin
    if(BW='1' and fstate = 1) then
    	B<=rd2;
    elsif(BW='1' and fstate = 10 and instr_class /= DT) then
    	B<=shift_result;
    end if;
    end process;



    --setting data to be written in memory
    process(byte_type,B,Memory_input)
    begin
    	if(byte_type="000") then
    		write_data_memory <=B;
        else
         	write_data_memory <= Memory_input;
        end if;
    end process;

    memory_address<= A(7 downto 0) when post_pre = '0' else RES(7 downto 0);



    --storing data read from memory
    IR<=read_memory_data when IW = '1';
    DR<=Register_input when DW = '1';



    --for register file
    write_data_register<= DR when M2R='1' else RES;
    rad1<=Rn;
    wad<=Rn when write_back = '1' and fstate = 5 else Rd;
    A<=rd1 when AW = '1';
    Sh<=rd2 when ShW = '1';



    --storing the required offset
    ex_offset<=shift_result when instr_class = DP else Off;



    --ALU
    op1<="00"&p_c(31 downto 2) when Asrc1='0' else A;
    RES<= result when ReW = '1';


end architecture;