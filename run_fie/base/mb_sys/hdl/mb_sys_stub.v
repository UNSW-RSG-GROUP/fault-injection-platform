//-----------------------------------------------------------------------------
// mb_sys_stub.v
//-----------------------------------------------------------------------------

module mb_sys_stub
  (
    rst,
    clk_p,
    clk_n,
    uart_rx,
    uart_tx,
    return_val_dut,
    start_dut,
    clk_dut,
    finish_dut,
    rst_dut,
    rst_fsm
  );
  input rst;
  input clk_p;
  input clk_n;
  input uart_rx;
  output uart_tx;
  input [31:0] return_val_dut;
  output start_dut;
  output clk_dut;
  input finish_dut;
  output rst_dut;
  output rst_fsm;

  (* BOX_TYPE = "user_black_box" *)
  mb_sys
    mb_sys_i (
      .rst ( rst ),
      .clk_p ( clk_p ),
      .clk_n ( clk_n ),
      .uart_rx ( uart_rx ),
      .uart_tx ( uart_tx ),
      .return_val_dut ( return_val_dut ),
      .start_dut ( start_dut ),
      .clk_dut ( clk_dut ),
      .finish_dut ( finish_dut ),
      .rst_dut ( rst_dut ),
      .rst_fsm ( rst_fsm )
    );

endmodule

module mb_sys
  (
    rst,
    clk_p,
    clk_n,
    uart_rx,
    uart_tx,
    return_val_dut,
    start_dut,
    clk_dut,
    finish_dut,
    rst_dut,
    rst_fsm
  );
  input rst;
  input clk_p;
  input clk_n;
  input uart_rx;
  output uart_tx;
  input [31:0] return_val_dut;
  output start_dut;
  output clk_dut;
  input finish_dut;
  output rst_dut;
  output rst_fsm;
endmodule

