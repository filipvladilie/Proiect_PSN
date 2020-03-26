----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:53:36 05/18/2019 
-- Design Name: 
-- Module Name:    COUNTER - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COUNTER is
    Port ( CLK : in  STD_LOGIC;
          LED1 : out  STD_LOGIC;
			 LED2 : out  STD_LOGIC;
			 LED3 : out  STD_LOGIC;
			 LED4 : out  STD_LOGIC);
end COUNTER;

architecture Behavioral of COUNTER is
SIGNAL TEMP : STD_LOGIC;
SIGNAL TEMP2 : STD_LOGIC;
SIGNAL TEMP3 : STD_LOGIC;
SIGNAL TEMP4 : STD_LOGIC;
begin
	process (clk)
	VARIABLE counter : integer :=0;
	VARIABLE counter_int : integer :=0;
	begin
		if rising_edge(CLK) then
			if (counter = 50000000) then
				--temp <= not(temp);
				counter := 0;
				counter_int :=counter_int +1;	
			else
				if counter_int = 2 then
					temp2 <= not temp2;
				else 
					if counter_int =3 then
						temp3<= not temp3;
					else 
						if counter_int =4 then
							temp4<= not temp4;
							counter_int :=0;
						else
							teMp <= not temp;
							
						end if;
					end if;	
				end if;
			counter := counter +1;
		end if;
		END IF;
end process;
LED1 <= temP;
LED2 <= temP2;
LED3 <= temP3;
LED4 <= temP4;

end Behavioral;

