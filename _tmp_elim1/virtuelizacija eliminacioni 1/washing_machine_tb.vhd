library ieee;
use ieee.std_logic_1164.all;

entity washing_machine_tb is
end washing_machine_tb;

architecture tb of washing_machine_tb is

    ------------------------------------------------------------------
    -- Signali za povezivanje sa DUT-om
    ------------------------------------------------------------------
    signal iCLK   : std_logic := '0';
    signal iRST   : std_logic := '0';
    signal iDOOR_CLOSED : std_logic := '0';

    signal oMOTOR  : std_logic;
    signal oVALVE  : std_logic;
    signal oPUMP   : std_logic;
    signal oDOOR_UNLOCK : std_logic;

    constant iCLK_PERIOD : time := 10 ns;

begin

    ------------------------------------------------------------------
    -- Instanca dizajna (DUT)
    ------------------------------------------------------------------
    DUT : entity work.washing_machine
        port map (
            iCLK         => iCLK,
            iRST         => iRST,
            iDOOR_CLOSED => iDOOR_CLOSED,
            oMOTOR       => oMOTOR,
            oVALVE       => oVALVE,
            oPUMP        => oPUMP,
            oDOOR_UNLOCK => oDOOR_UNLOCK
        );

    ------------------------------------------------------------------
    -- Generator takta
    ------------------------------------------------------------------
    iCLK_process : process
    begin
        while true loop
            iCLK <= '0';
            wait for iCLK_PERIOD / 2;
            iCLK <= '1';
            wait for iCLK_PERIOD / 2;
        end loop;
    end process;

    ------------------------------------------------------------------
    -- Test scenario
    ------------------------------------------------------------------
    stim_process : process
    begin
        -- RESET sistema
        iRST <= '1';
        wait for 20 ns;
        iRST <= '0';

        -- Vrata zatvorena -> start programa
        iDOOR_CLOSED <= '1';

        -- Simulacija kompletnog ciklusa
        wait for 500 ns;

        -- Otvaranje vrata (nakon kraja programa)
        iDOOR_CLOSED <= '0';

        wait for 100 ns;

        -- Kraj simulacije
        wait;
    end process;

end tb;
