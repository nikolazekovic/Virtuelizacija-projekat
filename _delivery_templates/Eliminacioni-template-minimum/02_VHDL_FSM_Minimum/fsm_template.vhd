library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_template is
    port (
        iCLK   : in  std_logic;
        iRST   : in  std_logic;
        iSTART : in  std_logic;
        iINPUT : in  std_logic;
        oWORK  : out std_logic;
        oDONE  : out std_logic
    );
end fsm_template;

architecture rtl of fsm_template is

    type state_type is (
        IDLE,
        STEP1,
        STEP2,
        FINISH
    );

    signal state, next_state : state_type;
    signal timer : integer range 0 to 20;

begin

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

    process(state, timer, iSTART, iINPUT)
    begin
        next_state <= state;

        case state is
            when IDLE =>
                if iSTART = '1' then
                    next_state <= STEP1;
                end if;

            when STEP1 =>
                if timer = 3 then
                    next_state <= STEP2;
                end if;

            when STEP2 =>
                if iINPUT = '1' then
                    next_state <= FINISH;
                end if;

            when FINISH =>
                next_state <= FINISH;
        end case;
    end process;

    process(state)
    begin
        oWORK <= '0';
        oDONE <= '0';

        case state is
            when STEP1 | STEP2 =>
                oWORK <= '1';

            when FINISH =>
                oDONE <= '1';

            when others =>
                null;
        end case;
    end process;

end rtl;
