library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;


ENTITY ROM_CUVINTE IS
	PORT (
	SEL : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	reset : in STD_LOGIC;
	CLK : IN STD_LOGIC;
	ANOD : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
	CATOD : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END ROM_CUVINTE;

ARCHITECTURE BEH OF ROM_CUVINTE IS

COMPONENT COUNTER is
    Port ( CLK : in  STD_LOGIC;
          LED1 : out  STD_LOGIC;
			 LED2 : out  STD_LOGIC;
			 LED3 : out  STD_LOGIC;
			 LED4 : out  STD_LOGIC);
end COMPONENT;
COMPONENT COUNTER2 is
    Port ( CLK : in  STD_LOGIC;
          LED1 : out  STD_LOGIC);
end COMPONENT;


TYPE LETTERS_ALPH IS ARRAY (17 DOWNTO 0) of STD_LOGIC_VECTOR(6 DOWNTO 0);
type WORD1 is array (3 downto 0) of std_logic_vector(6 downto 0);
type WORD is array (15 downto 0) of std_logic_vector(6 downto 0);
type WORD22 is array (15 downto 0) of std_logic_vector(6 downto 0);
type WORD33 is array (15 downto 0) of std_logic_vector(6 downto 0);
type WORD44 is array (15 downto 0) of std_logic_vector(6 downto 0);
type WORD2 is array (3 downto 0) of std_logic_vector(6 downto 0);
type WORD3 is array (3 downto 0) of std_logic_vector(6 downto 0);
type WORD4 is array (3 downto 0) of std_logic_vector(6 downto 0);
signal LED_activating_counter: std_logic_vector(1 downto 0);
signal LED_activating_counter2: std_logic_vector(1 downto 0);
signal SELECTOR: std_logic_vector(1 downto 0);
SIGNAL LED_OUT  :STD_LOGIC;
SIGNAL LED_OUT1  :STD_LOGIC;
SIGNAL LED_OUT2  :STD_LOGIC;
SIGNAL LED_OUT3 :STD_LOGIC;
SIGNAL LED_OUT4  :STD_LOGIC;
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
signal refresh_counter2: STD_LOGIC_VECTOR (26 downto 0);
CONSTANT LETTER : LETTERS_ALPH := (0 => "1111111", --spatiu
								1 => "0001000", --A
								2 => "1100000", --b
		 						3 => "0110001", --C
								4 => "1000010", --d
								5 => "0110000", --E
								6 => "0111000", --F
								7 => "0100000", --G
								8 => "1001000", --H
								9 => "1001111", --I
								10 => "1001111", --J
								11 => "1110001", --L
								12 => "0001001", --n
								13 => "0000001", --O
								14 => "0011000", --P
								15 => "1111010", --r
								16 => "0100100", --S
								17 => "1000001"); --U
			
constant W1 : WORD1 := 
					  (0 => letter(1), --A
						1 => letter(11), --L
						2 => letter(6), --F
						3 => letter(1)); --A
constant W11 : WORD := 
					  (
						0 => letter(1), --A
						1 => letter(11), --L
						2 => letter(6), --F
						3 => letter(1), --A
					   4 => letter(1), --A
						5 => letter(1), --A
						6 => letter(11), --L
						7 => letter(6), --F
					   8 => letter(6), --F
						9 => letter(1), --A
						10 => letter(1), --A
						11 => letter(11), --L 
					   12 => letter(6), --F
						13 => letter(11), --L
						14 => letter(1), --A
						15 => letter(1)); --A						
						
					   
						
						
constant W2 : WORD2 := (0 => letter(3),--C
						1 => letter(13),--O
						2 => letter(11),--L
						3 => letter(1));--A
constant W22 : WORD22 := (
						0 => letter(3),--C
						1 => letter(13),--O
						2 => letter(11),--L
						3 => letter(1),--A
						4 => letter(1),--A
						5 => letter(3),--C
						6 => letter(13),--O
						7 => letter(11),--L
						8 => letter(11),--L
						9 => letter(1),--A
						10 => letter(3),--C
						11 => letter(13),--O
						12 => letter(13),--O
						13 => letter(11),--L
						14 => letter(1),--A
						15 => letter(3));--C
										
						
						
						
constant W3: WORD3 := 
						(0 => letter(2),--B
						1=>	letter(5), --E
						2=>	letter(3), --C
						3=>	letter(9)); --I
						
constant W33: WORD33 := 
						(0 => letter(2),--B
						1=>	letter(5), --E
						2=>	letter(3), --C
						3=>	letter(9), --I
						4 => letter(9),--I
						5=>	letter(2), --B
						6=>	letter(5), --E
						7=>	letter(3), --C
						8 => letter(3),--C
						9 =>	letter(9), --I
						10=>	letter(2), --B
						11 =>	letter(5), --E
						12 => letter(5),--E
						13 =>	letter(3), --C
						14 =>	letter(9), --I
						15 =>	letter(2)); --B
								
						
constant W4: WORD4 := (0 => letter(14), --P
						1 => letter(13),--0
						2 => letter(15), --R
						3 => letter(3));--C

constant W44: WORD44 := (
						0 => letter(14), --P
						1 => letter(13),--0
						2 => letter(15), --R
						3 => letter(3),--C
						4 => letter(3), --C
						5 => letter(14),--P
						6 => letter(13), --O
						7 => letter(15),  --R
						8 => letter(15), --R
						9 => letter(3),--C
						10 => letter(14), --P
						11 => letter(13),--0
						12 => letter(13), --0
						13 => letter(15),--R
						14 => letter(3), --C
						15 => letter(14));--P
						
						
begin

LEDURI: COUNTER PORT MAP(
			CLK => CLK,
			LED1=>LED_OUT,
			LED2=>LED_OUT2,
			LED3=>LED_OUT3,
			LED4=>LED_OUT4);
LEDURI2: COUNTER2 PORT MAP(
			CLK => CLK,
			LED1=>LED_OUT1);
clk1 : process(clk,RESET)
begin 
    if(reset='1') then
        refresh_counter <= (others => '0');
		  refresh_counter2 <=(others =>'0');
    elsif(rising_edge(clk)) then
        refresh_counter <= refresh_counter + 1;
		  refresh_counter2 <= refresh_counter2 +1;
    end if;							
end process;
LED_activating_counter <= refresh_counter (19 downto 18);
LED_activating_counter2 <= refresh_counter2 (26 downto 25);

LED : process(LED_activating_counter,sel,LED_OUT,LED_OUT2,LED_OUT3,LED_OUT4,LED_OUT1,LED_ACTIVATING_COUNTER2)
	variable i:integer:=0;
	variable k:integer:=0;
	begin 
	
	case sel is
	-------------------------------------------------------------- PRIMUL CUVANT TOATE ANIMMATIILE
		when "0000" => 
		
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W1(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W1(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W1(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W1(3);
						end case;
		
		when "0001" => 
							if LED_OUT1='1' THEN
							case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W1(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W1(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W1(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W1(3);
						end case;
						
					else 
							
							ANOD <="1111";
							CATOD <="1111111";
		
							end if;
		when "0010" => 
							
					case LED_ACTIVATING_COUNTER2 is
						 
						 when "00" => 
							ANOD <="0111";
							CATOD <= W1(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W1(1);
						 when "10" =>
							ANOD <="1101";
							CATOD <= W1(2);
				
						when others =>
							ANOD <="1110";
							CATOD <= W1(3);
							end case; 
							
	WHEN "0011" =>
			if led_out ='1' THEN
				case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W11(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W11(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W11(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W11(3);
						end case;
						
		else	
		IF LED_OUT2 ='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W11(4);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W11(5);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W11(6);
						
						when others =>
							ANOD <="1110";
							CATOD <= W11(7);
						end case;
		ELSE
		IF LED_OUT3 ='1' THEN
						Case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W11(8);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W11(9);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W11(10);
						
						when others =>
							ANOD <="1110";
							CATOD <= W11(11);
						end case;
					
			ELSE 
			IF LED_OUT4='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W11(12);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W11(13);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W11(14);
						
						when others =>
							ANOD <="1110";
							CATOD <= W11(15);
						end case;
						
					else 	
							ANOD <="1111";
							CATOD <="1111111";
						END IF;
						END IF;
	END IF;	
	END IF;						
				
				
				 
		
							
-------------------------------------------------------------- PRIMUL CUVANT TOATE ANIMMATIILE

-------------------------------------------------------------- AL DOILEA CUVANT TOATE ANIMMATIILE
						
		when "0100" =>
			
			
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W2(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W2(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W2(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W2(3);
						end case;
	when "0101" => 
							if LED_OUT1='1' THEN
							case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W2(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W2(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W2(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W2(3);
						end case;
						
					else 
							
							ANOD <="1111";
							CATOD <="1111111";
		
							end if;
		when "0110" => 
							
					case LED_ACTIVATING_COUNTER2 is
						 
						 when "00" => 
							ANOD <="0111";
							CATOD <= W2(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W2(1);
						 when "10" =>
							ANOD <="1101";
							CATOD <= W2(2);
				
						when others =>
							ANOD <="1110";
							CATOD <= W2(3);
							end case; 
		WHEN "0111" =>
			if led_out ='1' THEN
				case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W22(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W22(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W22(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W22(3);
						end case;
						
		else	
		IF LED_OUT2 ='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W22(4);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W22(5);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W22(6);
						
						when others =>
							ANOD <="1110";
							CATOD <= W22(7);
						end case;
		ELSE
		IF LED_OUT3 ='1' THEN
						Case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W22(8);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W22(9);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W22(10);
						
						when others =>
							ANOD <="1110";
							CATOD <= W22(11);
						end case;
					
			ELSE 
			IF LED_OUT4='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W22(12);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W22(13);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W22(14);
						
						when others =>
							ANOD <="1110";
							CATOD <= W22(15);
						end case;
						
					else 	
							ANOD <="1111";
							CATOD <="1111111";
						END IF;
						END IF;
	END IF;	
	END IF;						
									
		
		
-------------------------------------------------------------- AL DOILEA CUVANT TOATE ANIMMATIILE

-------------------------------------------------------------- AL TREILEA CUVANT TOATE ANIMMATIILE						
	
		when "1000" => case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W3(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W3(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W3(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W3(3);
						end case;
						
		when "1001" => 
							if LED_OUT1='1' THEN
							case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W3(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W3(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W3(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W3(3);
						end case;
						
					else 
							
							ANOD <="1111";
							CATOD <="1111111";
		
							end if;
		when "1010" => 
							
					case LED_ACTIVATING_COUNTER2 is
						 
						 when "00" => 
							ANOD <="0111";
							CATOD <= W3(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W3(1);
						 when "10" =>
							ANOD <="1101";
							CATOD <= W3(2);
				
						when others =>
							ANOD <="1110";
							CATOD <= W3(3);
							end case; 
				
	WHEN "1011" =>
			if led_out ='1' THEN
				case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W33(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W33(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W33(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W33(3);
						end case;
						
		else	
		IF LED_OUT2 ='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W33(4);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W33(5);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W33(6);
						
						when others =>
							ANOD <="1110";
							CATOD <= W33(7);
						end case;
		ELSE
		IF LED_OUT3 ='1' THEN
						Case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W33(8);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W33(9);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W33(10);
						
						when others =>
							ANOD <="1110";
							CATOD <= W33(11);
						end case;
					
			ELSE 
			IF LED_OUT4='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W33(12);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W33(13);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W33(14);
						
						when others =>
							ANOD <="1110";
							CATOD <= W33(15);
						end case;
						
					else 	
							ANOD <="1111";
							CATOD <="1111111";
						END IF;
						END IF;
	END IF;	
	END IF;						
							
		
							
-------------------------------------------------------------- AL TREILEA CUVANT TOATE ANIMATIILE
-------------------------------------------------------------- AL PATRULEA CUVANT TOATE ANIMMATIILE
					
		
		when "1100" => 	
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W4(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W4(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W4(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W4(3);
						end case;
		when "1101" => 
							if LED_OUT1='1' THEN
							case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W4(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W4(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W4(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W4(3);
						end case;
						
					else 
							
							ANOD <="1111";
							CATOD <="1111111";
		
							end if;
		when "1110" => 
							
					case LED_ACTIVATING_COUNTER2 is
						 
						 when "00" => 
							ANOD <="0111";
							CATOD <= W4(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W4(1);
						 when "10" =>
							ANOD <="1101";
							CATOD <= W4(2);
				
						when others =>
							ANOD <="1110";
							CATOD <= W4(3);
							end case; 
		
		WHEN "1111" =>
			if led_out ='1' THEN
				case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W44(0);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W44(1);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W44(2);
						
						when others =>
							ANOD <="1110";
							CATOD <= W44(3);
						end case;
						
		else	
		IF LED_OUT2 ='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W44(4);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W44(5);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W44(6);
						
						when others =>
							ANOD <="1110";
							CATOD <= W44(7);
						end case;
		ELSE
		IF LED_OUT3 ='1' THEN
						Case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W44(8);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W44(9);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W44(10);
						
						when others =>
							ANOD <="1110";
							CATOD <= W44(11);
						end case;
					
			ELSE 
			IF LED_OUT4='1' THEN
						case LED_ACTIVATING_COUNTER is
						 when "00" => 
							ANOD <="0111";
							CATOD <= W44(12);
						
						when "01" => 
							ANOD <="1011";
							CATOD <= W44(13);
						
						 when "10" =>
							ANOD <="1101";
							CATOD <= W44(14);
						
						when others =>
							ANOD <="1110";
							CATOD <= W44(15);
						end case;
						
					else 	
							ANOD <="1111";
							CATOD <="1111111";
						END IF;
						END IF;
	END IF;	
	END IF;						
				
		
		WHEN OTHERS =>
					
						ANOD <="1111";
						CATOD <="1111111";
					

				END CASE;
END PROCESS;
						
END ARCHITECTURE ;