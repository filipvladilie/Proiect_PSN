----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:48:36 05/20/2019 
-- Design Name: 
-- Module Name:    COUNTER2 - Behavioral 
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

entity COUNTER2 is
    Port ( CLK : in  STD_LOGIC;
          LED1 : out  STD_LOGIC);
end COUNTER2;

architecture Behavioral of COUNTER2 is
SIGNAL TEMP : STD_LOGIC;
begin
	process (clk)
	VARIABLE counter : integer :=0;
		BEGIN
		if rising_edge(CLK) then
			if (counter = 50000000) then
				temp <= not(temp);
				counter := 0;
				
		ELSE
			counter := counter +1;
		end if;
		END IF;
end process;
LED1 <= temP;


end Behavioral;
