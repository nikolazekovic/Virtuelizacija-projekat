-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"

-- DATE "01/20/2026 19:32:30"

-- 
-- Device: Altera 10M16SAU169C8G Package UFBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_G1,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_F5,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_F6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_E7,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_C4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_C5,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	washing_machine IS
    PORT (
	iCLK : IN std_logic;
	iRST : IN std_logic;
	iDOOR_CLOSED : IN std_logic;
	oMOTOR : OUT std_logic;
	oVALVE : OUT std_logic;
	oPUMP : OUT std_logic;
	oDOOR_UNLOCK : OUT std_logic
	);
END washing_machine;

-- Design Ports Information
-- oMOTOR	=>  Location: PIN_J5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- oVALVE	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- oPUMP	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- oDOOR_UNLOCK	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iDOOR_CLOSED	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iCLK	=>  Location: PIN_H5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iRST	=>  Location: PIN_H4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF washing_machine IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_iCLK : std_logic;
SIGNAL ww_iRST : std_logic;
SIGNAL ww_iDOOR_CLOSED : std_logic;
SIGNAL ww_oMOTOR : std_logic;
SIGNAL ww_oVALVE : std_logic;
SIGNAL ww_oPUMP : std_logic;
SIGNAL ww_oDOOR_UNLOCK : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \iRST~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \iCLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \oMOTOR~output_o\ : std_logic;
SIGNAL \oVALVE~output_o\ : std_logic;
SIGNAL \oPUMP~output_o\ : std_logic;
SIGNAL \oDOOR_UNLOCK~output_o\ : std_logic;
SIGNAL \iCLK~input_o\ : std_logic;
SIGNAL \iCLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \iDOOR_CLOSED~input_o\ : std_logic;
SIGNAL \iRST~input_o\ : std_logic;
SIGNAL \iRST~inputclkctrl_outclk\ : std_logic;
SIGNAL \state.END_PROGRAM~q\ : std_logic;
SIGNAL \process_0~9_combout\ : std_logic;
SIGNAL \timer~1_combout\ : std_logic;
SIGNAL \timer~3_combout\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \timer~2_combout\ : std_logic;
SIGNAL \Selector0~1_combout\ : std_logic;
SIGNAL \Selector0~3_combout\ : std_logic;
SIGNAL \Selector3~2_combout\ : std_logic;
SIGNAL \state.RINSE~q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Selector0~2_combout\ : std_logic;
SIGNAL \Selector2~4_combout\ : std_logic;
SIGNAL \Selector2~1_combout\ : std_logic;
SIGNAL \Selector2~2_combout\ : std_logic;
SIGNAL \Selector2~3_combout\ : std_logic;
SIGNAL \Selector2~5_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \Selector4~1_combout\ : std_logic;
SIGNAL \state.SPIN~q\ : std_logic;
SIGNAL \Selector5~0_combout\ : std_logic;
SIGNAL \Selector5~1_combout\ : std_logic;
SIGNAL \state.DRAIN~q\ : std_logic;
SIGNAL \process_0~8_combout\ : std_logic;
SIGNAL \WideOr0~0_combout\ : std_logic;
SIGNAL \process_0~7_combout\ : std_logic;
SIGNAL \WideOr0~1_combout\ : std_logic;
SIGNAL \WideOr0~2_combout\ : std_logic;
SIGNAL \timer~0_combout\ : std_logic;
SIGNAL \state.END_PROGRAM~0_combout\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \Selector3~1_combout\ : std_logic;
SIGNAL \state.IDLE~0_combout\ : std_logic;
SIGNAL \state.IDLE~q\ : std_logic;
SIGNAL \Selector0~4_combout\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \state.FILL_WATER~q\ : std_logic;
SIGNAL \Selector2~6_combout\ : std_logic;
SIGNAL \state.WASH~q\ : std_logic;
SIGNAL \WideOr2~0_combout\ : std_logic;
SIGNAL \oDOOR_UNLOCK~0_combout\ : std_logic;
SIGNAL \oDOOR_UNLOCK~reg0_q\ : std_logic;
SIGNAL timer : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_iRST~inputclkctrl_outclk\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_iCLK <= iCLK;
ww_iRST <= iRST;
ww_iDOOR_CLOSED <= iDOOR_CLOSED;
oMOTOR <= ww_oMOTOR;
oVALVE <= ww_oVALVE;
oPUMP <= ww_oPUMP;
oDOOR_UNLOCK <= ww_oDOOR_UNLOCK;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\iRST~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \iRST~input_o\);

\iCLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \iCLK~input_o\);
\ALT_INV_iRST~inputclkctrl_outclk\ <= NOT \iRST~inputclkctrl_outclk\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X26_Y28_N20
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X6_Y0_N2
\oMOTOR~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \WideOr2~0_combout\,
	devoe => ww_devoe,
	o => \oMOTOR~output_o\);

-- Location: IOOBUF_X8_Y0_N30
\oVALVE~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \state.FILL_WATER~q\,
	devoe => ww_devoe,
	o => \oVALVE~output_o\);

-- Location: IOOBUF_X8_Y0_N23
\oPUMP~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \state.DRAIN~q\,
	devoe => ww_devoe,
	o => \oPUMP~output_o\);

-- Location: IOOBUF_X6_Y0_N30
\oDOOR_UNLOCK~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \oDOOR_UNLOCK~reg0_q\,
	devoe => ww_devoe,
	o => \oDOOR_UNLOCK~output_o\);

-- Location: IOIBUF_X0_Y8_N15
\iCLK~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iCLK,
	o => \iCLK~input_o\);

-- Location: CLKCTRL_G3
\iCLK~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \iCLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \iCLK~inputclkctrl_outclk\);

-- Location: IOIBUF_X6_Y0_N22
\iDOOR_CLOSED~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iDOOR_CLOSED,
	o => \iDOOR_CLOSED~input_o\);

-- Location: IOIBUF_X0_Y8_N22
\iRST~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iRST,
	o => \iRST~input_o\);

-- Location: CLKCTRL_G4
\iRST~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \iRST~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \iRST~inputclkctrl_outclk\);

-- Location: FF_X8_Y5_N23
\state.END_PROGRAM\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	asdata => \state.END_PROGRAM~0_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.END_PROGRAM~q\);

-- Location: LCCOMB_X8_Y5_N26
\process_0~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \process_0~9_combout\ = (\state.FILL_WATER~q\ & (!\Selector3~1_combout\ & ((\state.END_PROGRAM~q\) # (!\Selector0~4_combout\)))) # (!\state.FILL_WATER~q\ & (\Selector0~4_combout\ & (!\state.END_PROGRAM~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001011010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~4_combout\,
	datab => \state.END_PROGRAM~q\,
	datac => \state.FILL_WATER~q\,
	datad => \Selector3~1_combout\,
	combout => \process_0~9_combout\);

-- Location: LCCOMB_X8_Y5_N8
\timer~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \timer~1_combout\ = (!\WideOr0~2_combout\ & (timer(0) $ (timer(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => timer(0),
	datac => timer(1),
	datad => \WideOr0~2_combout\,
	combout => \timer~1_combout\);

-- Location: FF_X8_Y5_N9
\timer[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \timer~1_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => timer(1));

-- Location: LCCOMB_X8_Y5_N28
\timer~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \timer~3_combout\ = (!\WideOr0~2_combout\ & (timer(2) $ (((timer(0) & timer(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => timer(1),
	datac => timer(2),
	datad => \WideOr0~2_combout\,
	combout => \timer~3_combout\);

-- Location: FF_X8_Y5_N29
\timer[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \timer~3_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => timer(2));

-- Location: LCCOMB_X7_Y5_N30
\Add0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = timer(3) $ (((timer(0) & (timer(1) & timer(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => timer(1),
	datac => timer(3),
	datad => timer(2),
	combout => \Add0~0_combout\);

-- Location: LCCOMB_X8_Y5_N30
\timer~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \timer~2_combout\ = (\Add0~0_combout\ & !\WideOr0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Add0~0_combout\,
	datad => \WideOr0~2_combout\,
	combout => \timer~2_combout\);

-- Location: FF_X8_Y5_N31
\timer[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \timer~2_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => timer(3));

-- Location: LCCOMB_X7_Y5_N10
\Selector0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector0~1_combout\ = (!timer(3) & (!timer(1) & timer(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(3),
	datac => timer(1),
	datad => timer(2),
	combout => \Selector0~1_combout\);

-- Location: LCCOMB_X7_Y5_N28
\Selector0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector0~3_combout\ = (\state.WASH~q\ & (timer(0) & \Selector0~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.WASH~q\,
	datac => timer(0),
	datad => \Selector0~1_combout\,
	combout => \Selector0~3_combout\);

-- Location: LCCOMB_X8_Y5_N4
\Selector3~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector3~2_combout\ = (\state.END_PROGRAM~q\ & (((\state.RINSE~q\ & \Selector3~1_combout\)))) # (!\state.END_PROGRAM~q\ & ((\Selector0~3_combout\) # ((\state.RINSE~q\ & \Selector3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.END_PROGRAM~q\,
	datab => \Selector0~3_combout\,
	datac => \state.RINSE~q\,
	datad => \Selector3~1_combout\,
	combout => \Selector3~2_combout\);

-- Location: FF_X8_Y5_N5
\state.RINSE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \Selector3~2_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.RINSE~q\);

-- Location: LCCOMB_X7_Y5_N22
\Selector2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (!\state.RINSE~q\ & (!\state.FILL_WATER~q\ & !\state.END_PROGRAM~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.RINSE~q\,
	datac => \state.FILL_WATER~q\,
	datad => \state.END_PROGRAM~q\,
	combout => \Selector2~0_combout\);

-- Location: LCCOMB_X8_Y5_N16
\Equal0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = (!timer(3) & (timer(1) & !timer(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(3),
	datac => timer(1),
	datad => timer(2),
	combout => \Equal0~1_combout\);

-- Location: LCCOMB_X8_Y5_N18
\Selector0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector0~2_combout\ = (timer(0) & (\Equal0~1_combout\ & ((\state.RINSE~q\) # (\state.FILL_WATER~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.RINSE~q\,
	datab => timer(0),
	datac => \state.FILL_WATER~q\,
	datad => \Equal0~1_combout\,
	combout => \Selector0~2_combout\);

-- Location: LCCOMB_X7_Y5_N8
\Selector2~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~4_combout\ = (\Selector0~2_combout\) # ((\iDOOR_CLOSED~input_o\ & (!\state.IDLE~q\ & \Selector2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iDOOR_CLOSED~input_o\,
	datab => \state.IDLE~q\,
	datac => \Selector2~0_combout\,
	datad => \Selector0~2_combout\,
	combout => \Selector2~4_combout\);

-- Location: LCCOMB_X7_Y5_N20
\Selector2~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~1_combout\ = (!\state.WASH~q\ & (!timer(0) & (\state.DRAIN~q\ & \Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.WASH~q\,
	datab => timer(0),
	datac => \state.DRAIN~q\,
	datad => \Equal0~1_combout\,
	combout => \Selector2~1_combout\);

-- Location: LCCOMB_X7_Y5_N0
\Selector2~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~2_combout\ = (\Selector0~1_combout\ & ((\state.WASH~q\ & (timer(0))) # (!\state.WASH~q\ & (!timer(0) & !\state.DRAIN~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.WASH~q\,
	datab => timer(0),
	datac => \state.DRAIN~q\,
	datad => \Selector0~1_combout\,
	combout => \Selector2~2_combout\);

-- Location: LCCOMB_X7_Y5_N6
\Selector2~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~3_combout\ = (\state.IDLE~q\ & (\Selector2~0_combout\ & ((\Selector2~1_combout\) # (\Selector2~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.IDLE~q\,
	datab => \Selector2~1_combout\,
	datac => \Selector2~0_combout\,
	datad => \Selector2~2_combout\,
	combout => \Selector2~3_combout\);

-- Location: LCCOMB_X7_Y5_N4
\Selector2~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~5_combout\ = (!\state.END_PROGRAM~q\ & (!\Selector2~4_combout\ & !\Selector2~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.END_PROGRAM~q\,
	datac => \Selector2~4_combout\,
	datad => \Selector2~3_combout\,
	combout => \Selector2~5_combout\);

-- Location: LCCOMB_X7_Y5_N24
\Equal0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (timer(0) & (timer(1) & (!timer(3) & !timer(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => timer(1),
	datac => timer(3),
	datad => timer(2),
	combout => \Equal0~0_combout\);

-- Location: LCCOMB_X7_Y5_N2
\Selector4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = (\Equal0~0_combout\ & (!\state.END_PROGRAM~q\ & ((\Selector2~4_combout\) # (\Selector2~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~0_combout\,
	datab => \state.END_PROGRAM~q\,
	datac => \Selector2~4_combout\,
	datad => \Selector2~3_combout\,
	combout => \Selector4~0_combout\);

-- Location: LCCOMB_X7_Y5_N18
\Selector4~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector4~1_combout\ = (\state.RINSE~q\ & ((\Selector4~0_combout\) # ((\Selector2~5_combout\ & \state.SPIN~q\)))) # (!\state.RINSE~q\ & (\Selector2~5_combout\ & (\state.SPIN~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.RINSE~q\,
	datab => \Selector2~5_combout\,
	datac => \state.SPIN~q\,
	datad => \Selector4~0_combout\,
	combout => \Selector4~1_combout\);

-- Location: FF_X7_Y5_N19
\state.SPIN\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \Selector4~1_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.SPIN~q\);

-- Location: LCCOMB_X7_Y5_N12
\Selector5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector5~0_combout\ = (!timer(0) & (\state.SPIN~q\ & \Selector0~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => \state.SPIN~q\,
	datad => \Selector0~1_combout\,
	combout => \Selector5~0_combout\);

-- Location: LCCOMB_X8_Y5_N6
\Selector5~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector5~1_combout\ = (\Selector5~0_combout\ & (((\state.DRAIN~q\ & \Selector3~1_combout\)) # (!\state.END_PROGRAM~q\))) # (!\Selector5~0_combout\ & (((\state.DRAIN~q\ & \Selector3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector5~0_combout\,
	datab => \state.END_PROGRAM~q\,
	datac => \state.DRAIN~q\,
	datad => \Selector3~1_combout\,
	combout => \Selector5~1_combout\);

-- Location: FF_X8_Y5_N13
\state.DRAIN\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	asdata => \Selector5~1_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.DRAIN~q\);

-- Location: LCCOMB_X8_Y5_N22
\process_0~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \process_0~8_combout\ = (!timer(0) & (\state.DRAIN~q\ & (!\state.END_PROGRAM~q\ & \Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => \state.DRAIN~q\,
	datac => \state.END_PROGRAM~q\,
	datad => \Equal0~1_combout\,
	combout => \process_0~8_combout\);

-- Location: LCCOMB_X8_Y5_N24
\WideOr0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr0~0_combout\ = (\Selector0~4_combout\) # ((\process_0~8_combout\) # (\state.DRAIN~q\ $ (\Selector5~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~4_combout\,
	datab => \state.DRAIN~q\,
	datac => \process_0~8_combout\,
	datad => \Selector5~1_combout\,
	combout => \WideOr0~0_combout\);

-- Location: LCCOMB_X7_Y5_N16
\process_0~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \process_0~7_combout\ = (\state.SPIN~q\ & (!\Selector2~5_combout\ & ((!\Selector4~0_combout\) # (!\state.RINSE~q\)))) # (!\state.SPIN~q\ & (\state.RINSE~q\ & ((\Selector4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010011000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.RINSE~q\,
	datab => \state.SPIN~q\,
	datac => \Selector2~5_combout\,
	datad => \Selector4~0_combout\,
	combout => \process_0~7_combout\);

-- Location: LCCOMB_X8_Y5_N20
\WideOr0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr0~1_combout\ = (\state.WASH~q\ & ((\state.RINSE~q\ $ (\Selector3~2_combout\)) # (!\Selector2~6_combout\))) # (!\state.WASH~q\ & ((\Selector2~6_combout\) # (\state.RINSE~q\ $ (\Selector3~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111110110111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.WASH~q\,
	datab => \state.RINSE~q\,
	datac => \Selector3~2_combout\,
	datad => \Selector2~6_combout\,
	combout => \WideOr0~1_combout\);

-- Location: LCCOMB_X8_Y5_N10
\WideOr0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr0~2_combout\ = (\process_0~9_combout\) # ((\WideOr0~0_combout\) # ((\process_0~7_combout\) # (\WideOr0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \process_0~9_combout\,
	datab => \WideOr0~0_combout\,
	datac => \process_0~7_combout\,
	datad => \WideOr0~1_combout\,
	combout => \WideOr0~2_combout\);

-- Location: LCCOMB_X8_Y5_N2
\timer~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \timer~0_combout\ = (!timer(0) & !\WideOr0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => timer(0),
	datad => \WideOr0~2_combout\,
	combout => \timer~0_combout\);

-- Location: FF_X8_Y5_N3
\timer[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \timer~0_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => timer(0));

-- Location: LCCOMB_X8_Y5_N12
\state.END_PROGRAM~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \state.END_PROGRAM~0_combout\ = (\state.END_PROGRAM~q\) # ((!timer(0) & (\Equal0~1_combout\ & \state.DRAIN~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => \Equal0~1_combout\,
	datac => \state.DRAIN~q\,
	datad => \state.END_PROGRAM~q\,
	combout => \state.END_PROGRAM~0_combout\);

-- Location: LCCOMB_X7_Y5_N26
\Selector3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (!\Selector0~4_combout\ & ((timer(0)) # ((!\Selector0~1_combout\) # (!\state.SPIN~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => timer(0),
	datab => \state.SPIN~q\,
	datac => \Selector0~4_combout\,
	datad => \Selector0~1_combout\,
	combout => \Selector3~0_combout\);

-- Location: LCCOMB_X8_Y5_N0
\Selector3~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector3~1_combout\ = (!\state.END_PROGRAM~0_combout\ & (!\Selector0~2_combout\ & (\Selector3~0_combout\ & !\Selector0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.END_PROGRAM~0_combout\,
	datab => \Selector0~2_combout\,
	datac => \Selector3~0_combout\,
	datad => \Selector0~3_combout\,
	combout => \Selector3~1_combout\);

-- Location: LCCOMB_X6_Y5_N24
\state.IDLE~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \state.IDLE~0_combout\ = (\state.IDLE~q\) # (!\Selector3~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \state.IDLE~q\,
	datad => \Selector3~1_combout\,
	combout => \state.IDLE~0_combout\);

-- Location: FF_X6_Y5_N25
\state.IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \state.IDLE~0_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.IDLE~q\);

-- Location: LCCOMB_X6_Y5_N6
\Selector0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector0~4_combout\ = (\iDOOR_CLOSED~input_o\ & !\state.IDLE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \iDOOR_CLOSED~input_o\,
	datad => \state.IDLE~q\,
	combout => \Selector0~4_combout\);

-- Location: LCCOMB_X8_Y5_N14
\Selector1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\Selector0~4_combout\ & (((\state.FILL_WATER~q\ & \Selector3~1_combout\)) # (!\state.END_PROGRAM~q\))) # (!\Selector0~4_combout\ & (((\state.FILL_WATER~q\ & \Selector3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~4_combout\,
	datab => \state.END_PROGRAM~q\,
	datac => \state.FILL_WATER~q\,
	datad => \Selector3~1_combout\,
	combout => \Selector1~0_combout\);

-- Location: FF_X8_Y5_N15
\state.FILL_WATER\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \Selector1~0_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.FILL_WATER~q\);

-- Location: LCCOMB_X7_Y5_N14
\Selector2~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~6_combout\ = (\state.WASH~q\ & ((\Selector2~5_combout\) # ((\state.FILL_WATER~q\ & \Selector4~0_combout\)))) # (!\state.WASH~q\ & (\state.FILL_WATER~q\ & ((\Selector4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.WASH~q\,
	datab => \state.FILL_WATER~q\,
	datac => \Selector2~5_combout\,
	datad => \Selector4~0_combout\,
	combout => \Selector2~6_combout\);

-- Location: FF_X7_Y5_N13
\state.WASH\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	asdata => \Selector2~6_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.WASH~q\);

-- Location: LCCOMB_X6_Y5_N16
\WideOr2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr2~0_combout\ = (\state.WASH~q\) # ((\state.RINSE~q\) # (\state.SPIN~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.WASH~q\,
	datac => \state.RINSE~q\,
	datad => \state.SPIN~q\,
	combout => \WideOr2~0_combout\);

-- Location: LCCOMB_X6_Y5_N30
\oDOOR_UNLOCK~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \oDOOR_UNLOCK~0_combout\ = (\state.END_PROGRAM~q\) # ((\oDOOR_UNLOCK~reg0_q\ & !\WideOr2~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.END_PROGRAM~q\,
	datac => \oDOOR_UNLOCK~reg0_q\,
	datad => \WideOr2~0_combout\,
	combout => \oDOOR_UNLOCK~0_combout\);

-- Location: FF_X6_Y5_N31
\oDOOR_UNLOCK~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \iCLK~inputclkctrl_outclk\,
	d => \oDOOR_UNLOCK~0_combout\,
	clrn => \ALT_INV_iRST~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \oDOOR_UNLOCK~reg0_q\);

-- Location: UNVM_X0_Y18_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X25_Y28_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

ww_oMOTOR <= \oMOTOR~output_o\;

ww_oVALVE <= \oVALVE~output_o\;

ww_oPUMP <= \oPUMP~output_o\;

ww_oDOOR_UNLOCK <= \oDOOR_UNLOCK~output_o\;
END structure;


