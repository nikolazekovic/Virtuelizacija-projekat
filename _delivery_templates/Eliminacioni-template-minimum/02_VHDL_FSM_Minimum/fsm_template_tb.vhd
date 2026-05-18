library ieee;
use ieee.std_logic_1164.all;

entity fsm_template_tb is
end fsm_template_tb;

architecture tb of fsm_template_tb is

    signal iCLK   : std_logic := '0';
    signal iRST   : std_logic := '0';
    signal iSTART : std_logic := '0';
    signal iINPUT : std_logic := '0';
    signal oWORK  : std_logic;
    signal oDONE  : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    DUT : entity work.fsm_template
        port map (
            iCLK   => iCLK,
            iRST   => iRST,
            iSTART => iSTART,
            iINPUT => iINPUT,
            oWORK  => oWORK,
            oDONE  => oDONE
        );

    clk_process : process
    begin
        while true loop
            iCLK <= '0';
            wait for CLK_PERIOD / 2;
            iCLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_process : process
    begin
        iRST <= '1';
        wait for 20 ns;
        iRST <= '0';

        iSTART <= '1';
        wait for 20 ns;
        iSTART <= '0';

        wait for 80 ns;
        iINPUT <= '1';

        wait for 100 ns;
        wait;
    end process;

end tb;
