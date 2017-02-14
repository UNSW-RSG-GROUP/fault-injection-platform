-------------------------------------------------------------------------------
-- mb_sys_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity mb_sys_stub is
  port (
    rst : in std_logic;
    clk_p : in std_logic;
    clk_n : in std_logic;
    uart_rx : in std_logic;
    uart_tx : out std_logic;
    return_val_dut : in std_logic_vector(31 downto 0);
    start_dut : out std_logic;
    clk_dut : out std_logic;
    finish_dut : in std_logic;
    rst_dut : out std_logic;
    rst_fsm : out std_logic
  );
end mb_sys_stub;

architecture STRUCTURE of mb_sys_stub is

  component mb_sys is
    port (
      rst : in std_logic;
      clk_p : in std_logic;
      clk_n : in std_logic;
      uart_rx : in std_logic;
      uart_tx : out std_logic;
      return_val_dut : in std_logic_vector(31 downto 0);
      start_dut : out std_logic;
      clk_dut : out std_logic;
      finish_dut : in std_logic;
      rst_dut : out std_logic;
      rst_fsm : out std_logic
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of mb_sys : component is "user_black_box";

begin

  mb_sys_i : mb_sys
    port map (
      rst => rst,
      clk_p => clk_p,
      clk_n => clk_n,
      uart_rx => uart_rx,
      uart_tx => uart_tx,
      return_val_dut => return_val_dut,
      start_dut => start_dut,
      clk_dut => clk_dut,
      finish_dut => finish_dut,
      rst_dut => rst_dut,
      rst_fsm => rst_fsm
    );

end architecture STRUCTURE;

