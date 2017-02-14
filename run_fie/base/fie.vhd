library ieee;
use ieee.std_logic_1164.all;

entity fie is
    port(
        clk_p          : in  std_logic;
        clk_n          : in  std_logic;
        rst            : in  std_logic;
        uart_rx        : in  std_logic;
        uart_tx        : out std_logic
    );
end fie;

architecture rtl of fie is
    component fip is
        port(
            clk_p          : in  std_logic;
            clk_n          : in  std_logic;
            rst            : in  std_logic;
            uart_rx        : in  std_logic;
            uart_tx        : out std_logic;
            clk_dut        : out std_logic;
            rst_dut        : out std_logic;
            return_val_dut : in  std_logic_vector(31 downto 0);
            finish_dut     : in  std_logic;
            start_dut      : out std_logic
        );
    end component fip;
    
    component top is
        port(
            clk         : in std_logic;
            reset       : in std_logic;
            start       : in std_logic;
            finish      : out std_logic;
            waitrequest : in std_logic;
            return_val  : out std_logic_vector(31 downto 0)
        );
    end component top;
    
    signal clk_dut : std_logic;
    signal rst_dut : std_logic;
    signal return_val_dut : std_logic_vector(31 downto 0);
    signal finish_dut : std_logic;
    signal start_dut : std_logic;
begin
    fip_inst : fip
    port map(
        clk_p          => clk_p,
        clk_n          => clk_n,
        rst            => rst,
        uart_rx        => uart_rx,
        uart_tx        => uart_tx,
        clk_dut        => clk_dut,
        rst_dut        => rst_dut,
        return_val_dut => return_val_dut,
        finish_dut     => finish_dut,
        start_dut      => start_dut
    );
    
    top_inst : top
    port map(
        clk         => clk_dut,
        reset       => rst_dut,
        start       => start_dut,
        finish      => finish_dut,
        waitrequest => '0',
        return_val  => return_val_dut
    );
end rtl;
