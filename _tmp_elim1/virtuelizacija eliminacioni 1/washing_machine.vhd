library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity washing_machine is
    port (
        iCLK   : in  std_logic;
        iRST   : in  std_logic;
        iDOOR_CLOSED : in std_logic;

        oMOTOR  : out std_logic;
        oVALVE  : out std_logic;
        oPUMP   : out std_logic;
        oDOOR_UNLOCK : out std_logic
    );
end washing_machine;

architecture rtl of washing_machine is

    ------------------------------------------------------------------
    -- Definicija stanja FSM-a
    ------------------------------------------------------------------
    type state_type is (
        IDLE,
        FILL_WATER,
        WASH,
        RINSE,
        SPIN,
        DRAIN,
        END_PROGRAM
    );

    signal state, next_state : state_type;

    ------------------------------------------------------------------
    -- Interni signali (UMESTO čitanja out portova)
    ------------------------------------------------------------------
    signal sMOTOR : std_logic;
    signal sVALVE : std_logic;
    signal sPUMP  : std_logic;

    ------------------------------------------------------------------
    -- Brojači
    ------------------------------------------------------------------
    signal timer : integer range 0 to 10;
    signal sMOTOR_time_cnt : integer range 0 to 100;

begin

    ------------------------------------------------------------------
    -- Sekvencijalni deo: FSM + brojač stanja
    ------------------------------------------------------------------
    process(iCLK, iRST)
    begin
        if iRST = '1' then
            state <= IDLE;
            timer <= 0;

        elsif rising_edge(iCLK) then
            state <= next_state;

            if state /= next_state then
                timer <= 0;
            else
                timer <= timer + 1;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------
    -- Kombinacioni deo: prelazi stanja
    ------------------------------------------------------------------
    process(state, timer, iDOOR_CLOSED)
    begin
        next_state <= state;

        case state is

            when IDLE =>
                if iDOOR_CLOSED = '1' then
                    next_state <= FILL_WATER;
                end if;

            when FILL_WATER =>
                if timer = 3 then
                    next_state <= WASH;
                end if;

            when WASH =>
                if timer = 5 then
                    next_state <= RINSE;
                end if;

            when RINSE =>
                if timer = 3 then
                    next_state <= SPIN;
                end if;

            when SPIN =>
                if timer = 4 then
                    next_state <= DRAIN;
                end if;

            when DRAIN =>
                if timer = 2 then
                    next_state <= END_PROGRAM;
                end if;

            when END_PROGRAM =>
                next_state <= END_PROGRAM;

        end case;
    end process;

    ------------------------------------------------------------------
    -- Izlazi (Moore automat)
    ------------------------------------------------------------------
    process(state)
    begin
        sMOTOR <= '0';
        sVALVE <= '0';
        sPUMP  <= '0';

        case state is
            when FILL_WATER =>
                sVALVE <= '1';

            when WASH | RINSE | SPIN =>
                sMOTOR <= '1';

            when DRAIN =>
                sPUMP <= '1';

            when others =>
                null;
        end case;
    end process;

    ------------------------------------------------------------------
    -- DODATNI SEKVENCIJALNI BLOK: Rad oMOTORa i bezbednost vrata
    ------------------------------------------------------------------
    process(iCLK, iRST)
    begin
        if iRST = '1' then
            sMOTOR_time_cnt <= 0;
            oDOOR_UNLOCK <= '0';

        elsif rising_edge(iCLK) then

            -- Brojanje dok oMOTOR radi
            if sMOTOR = '1' then
                sMOTOR_time_cnt <= sMOTOR_time_cnt + 1;
                oDOOR_UNLOCK <= '0';
            end if;

            -- Vrata se mogu otvoriti tek po završetku programa
            if state = END_PROGRAM then
                oDOOR_UNLOCK <= '1';
            end if;

        end if;
    end process;

    ------------------------------------------------------------------
    -- Veza internih signala na izlaze
    ------------------------------------------------------------------
    oMOTOR <= sMOTOR;
    oVALVE <= sVALVE;
    oPUMP  <= sPUMP;

end rtl;
