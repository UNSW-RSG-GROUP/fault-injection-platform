library ieee;
use ieee.std_logic_1164.all;

entity fip is
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
end fip;

architecture rtl of fip is
    component mb_sys_stub is
        port(
            rst            : in  std_logic;
            clk_p          : in  std_logic;
            clk_n          : in  std_logic;
            uart_rx        : in  std_logic;
            uart_tx        : out std_logic;
            clk_dut        : out std_logic;
            rst_dut        : out std_logic;
            return_val_dut : in  std_logic_vector(31 downto 0);
            finish_dut     : in  std_logic;
            start_dut      : out std_logic;
			rst_fsm        : out std_logic
        );
    end component mb_sys_stub;
    
    signal clk_sig        : std_logic;
    signal rst_sig        : std_logic;
	signal rst_fsm_sig    : std_logic;
    signal start_sig      : std_logic;
    signal finish_sig     : std_logic;
    signal return_val_sig : std_logic_vector(31 downto 0);
    
    type state_t is (idle_s, busy_s);
    signal state : state_t;
begin
    clk_dut <= clk_sig;
    rst_dut <= rst_sig;

    process(clk_sig, rst_fsm_sig)
    begin
        if (rst_fsm_sig = '1') then
            start_dut  <= '0';
            finish_sig     <= '1';
            return_val_sig <= X"DEADBEEF";
            state <= idle_s;
        elsif (rising_edge(clk_sig)) then
            case state is
                when idle_s =>
                    if (start_sig = '1') then
                        start_dut <= '1';
                        finish_sig    <= '0';
                        return_val_sig <= X"DEADBEEF";
                        state <= busy_s;
                    else
                        start_dut <= '0';
                        finish_sig    <= '1';
                        return_val_sig <= return_val_sig;
                        state <= idle_s;
                    end if;
                when busy_s =>
                    if (finish_dut = '1') then
                        start_dut <= '0';
                        finish_sig    <= '1';
                        return_val_sig <= return_val_dut;
                        state <= idle_s;
                    else
                        start_dut <= '0';
                        finish_sig    <= '0';
                        return_val_sig <= X"DEADBEEF";
                        state <= busy_s;
                    end if;
            end case;
        end if;
    end process;
    
    mb_sys_inst : mb_sys_stub
        port map(
            rst            => rst,
            clk_p          => clk_p,
            clk_n          => clk_n,
            uart_rx        => uart_rx,
            uart_tx        => uart_tx,
            clk_dut        => clk_sig,
            rst_dut        => rst_sig,
            return_val_dut => return_val_sig,
            finish_dut     => finish_sig,
            start_dut      => start_sig,
			rst_fsm        => rst_fsm_sig
        );
end rtl;
