//-----------------------------------------------------------------------------
// microblaze_0_bram_block_elaborate.v
//-----------------------------------------------------------------------------

(* keep_hierarchy = "yes" *)
module microblaze_0_bram_block_elaborate
  (
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    BRAM_Rst_B,
    BRAM_Clk_B,
    BRAM_EN_B,
    BRAM_WEN_B,
    BRAM_Addr_B,
    BRAM_Din_B,
    BRAM_Dout_B
  );
  parameter
    C_MEMSIZE = 'h8000,
    C_PORT_DWIDTH = 32,
    C_PORT_AWIDTH = 32,
    C_NUM_WE = 4,
    C_FAMILY = "virtex6";
  input BRAM_Rst_A;
  input BRAM_Clk_A;
  input BRAM_EN_A;
  input [0:C_NUM_WE-1] BRAM_WEN_A;
  input [0:C_PORT_AWIDTH-1] BRAM_Addr_A;
  output [0:C_PORT_DWIDTH-1] BRAM_Din_A;
  input [0:C_PORT_DWIDTH-1] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:C_NUM_WE-1] BRAM_WEN_B;
  input [0:C_PORT_AWIDTH-1] BRAM_Addr_B;
  output [0:C_PORT_DWIDTH-1] BRAM_Din_B;
  input [0:C_PORT_DWIDTH-1] BRAM_Dout_B;

  // Internal signals

  wire net_gnd0;
  wire [3:0] net_gnd4;
  wire [0:0] pgassign1;
  wire [0:1] pgassign2;
  wire [0:27] pgassign3;
  wire [0:3] pgassign4;
  wire [15:0] pgassign5;
  wire [31:0] pgassign6;
  wire [31:0] pgassign7;
  wire [3:0] pgassign8;
  wire [15:0] pgassign9;
  wire [31:0] pgassign10;
  wire [31:0] pgassign11;
  wire [7:0] pgassign12;
  wire [15:0] pgassign13;
  wire [31:0] pgassign14;
  wire [31:0] pgassign15;
  wire [3:0] pgassign16;
  wire [15:0] pgassign17;
  wire [31:0] pgassign18;
  wire [31:0] pgassign19;
  wire [7:0] pgassign20;
  wire [15:0] pgassign21;
  wire [31:0] pgassign22;
  wire [31:0] pgassign23;
  wire [3:0] pgassign24;
  wire [15:0] pgassign25;
  wire [31:0] pgassign26;
  wire [31:0] pgassign27;
  wire [7:0] pgassign28;
  wire [15:0] pgassign29;
  wire [31:0] pgassign30;
  wire [31:0] pgassign31;
  wire [3:0] pgassign32;
  wire [15:0] pgassign33;
  wire [31:0] pgassign34;
  wire [31:0] pgassign35;
  wire [7:0] pgassign36;
  wire [15:0] pgassign37;
  wire [31:0] pgassign38;
  wire [31:0] pgassign39;
  wire [3:0] pgassign40;
  wire [15:0] pgassign41;
  wire [31:0] pgassign42;
  wire [31:0] pgassign43;
  wire [7:0] pgassign44;
  wire [15:0] pgassign45;
  wire [31:0] pgassign46;
  wire [31:0] pgassign47;
  wire [3:0] pgassign48;
  wire [15:0] pgassign49;
  wire [31:0] pgassign50;
  wire [31:0] pgassign51;
  wire [7:0] pgassign52;
  wire [15:0] pgassign53;
  wire [31:0] pgassign54;
  wire [31:0] pgassign55;
  wire [3:0] pgassign56;
  wire [15:0] pgassign57;
  wire [31:0] pgassign58;
  wire [31:0] pgassign59;
  wire [7:0] pgassign60;
  wire [15:0] pgassign61;
  wire [31:0] pgassign62;
  wire [31:0] pgassign63;
  wire [3:0] pgassign64;
  wire [15:0] pgassign65;
  wire [31:0] pgassign66;
  wire [31:0] pgassign67;
  wire [7:0] pgassign68;

  // Internal assignments

  assign pgassign1[0:0] = 1'b1;
  assign pgassign2[0:1] = 2'b00;
  assign pgassign3[0:27] = 28'b0000000000000000000000000000;
  assign pgassign4[0:3] = 4'b0000;
  assign pgassign5[15:15] = 1'b1;
  assign pgassign5[14:2] = BRAM_Addr_A[17:29];
  assign pgassign5[1:0] = 2'b00;
  assign pgassign6[31:4] = 28'b0000000000000000000000000000;
  assign pgassign6[3:0] = BRAM_Dout_A[0:3];
  assign BRAM_Din_A[0:3] = pgassign7[3:0];
  assign pgassign8[3:3] = BRAM_WEN_A[0:0];
  assign pgassign8[2:2] = BRAM_WEN_A[0:0];
  assign pgassign8[1:1] = BRAM_WEN_A[0:0];
  assign pgassign8[0:0] = BRAM_WEN_A[0:0];
  assign pgassign9[15:15] = 1'b1;
  assign pgassign9[14:2] = BRAM_Addr_B[17:29];
  assign pgassign9[1:0] = 2'b00;
  assign pgassign10[31:4] = 28'b0000000000000000000000000000;
  assign pgassign10[3:0] = BRAM_Dout_B[0:3];
  assign BRAM_Din_B[0:3] = pgassign11[3:0];
  assign pgassign12[7:4] = 4'b0000;
  assign pgassign12[3:3] = BRAM_WEN_B[0:0];
  assign pgassign12[2:2] = BRAM_WEN_B[0:0];
  assign pgassign12[1:1] = BRAM_WEN_B[0:0];
  assign pgassign12[0:0] = BRAM_WEN_B[0:0];
  assign pgassign13[15:15] = 1'b1;
  assign pgassign13[14:2] = BRAM_Addr_A[17:29];
  assign pgassign13[1:0] = 2'b00;
  assign pgassign14[31:4] = 28'b0000000000000000000000000000;
  assign pgassign14[3:0] = BRAM_Dout_A[4:7];
  assign BRAM_Din_A[4:7] = pgassign15[3:0];
  assign pgassign16[3:3] = BRAM_WEN_A[0:0];
  assign pgassign16[2:2] = BRAM_WEN_A[0:0];
  assign pgassign16[1:1] = BRAM_WEN_A[0:0];
  assign pgassign16[0:0] = BRAM_WEN_A[0:0];
  assign pgassign17[15:15] = 1'b1;
  assign pgassign17[14:2] = BRAM_Addr_B[17:29];
  assign pgassign17[1:0] = 2'b00;
  assign pgassign18[31:4] = 28'b0000000000000000000000000000;
  assign pgassign18[3:0] = BRAM_Dout_B[4:7];
  assign BRAM_Din_B[4:7] = pgassign19[3:0];
  assign pgassign20[7:4] = 4'b0000;
  assign pgassign20[3:3] = BRAM_WEN_B[0:0];
  assign pgassign20[2:2] = BRAM_WEN_B[0:0];
  assign pgassign20[1:1] = BRAM_WEN_B[0:0];
  assign pgassign20[0:0] = BRAM_WEN_B[0:0];
  assign pgassign21[15:15] = 1'b1;
  assign pgassign21[14:2] = BRAM_Addr_A[17:29];
  assign pgassign21[1:0] = 2'b00;
  assign pgassign22[31:4] = 28'b0000000000000000000000000000;
  assign pgassign22[3:0] = BRAM_Dout_A[8:11];
  assign BRAM_Din_A[8:11] = pgassign23[3:0];
  assign pgassign24[3:3] = BRAM_WEN_A[1:1];
  assign pgassign24[2:2] = BRAM_WEN_A[1:1];
  assign pgassign24[1:1] = BRAM_WEN_A[1:1];
  assign pgassign24[0:0] = BRAM_WEN_A[1:1];
  assign pgassign25[15:15] = 1'b1;
  assign pgassign25[14:2] = BRAM_Addr_B[17:29];
  assign pgassign25[1:0] = 2'b00;
  assign pgassign26[31:4] = 28'b0000000000000000000000000000;
  assign pgassign26[3:0] = BRAM_Dout_B[8:11];
  assign BRAM_Din_B[8:11] = pgassign27[3:0];
  assign pgassign28[7:4] = 4'b0000;
  assign pgassign28[3:3] = BRAM_WEN_B[1:1];
  assign pgassign28[2:2] = BRAM_WEN_B[1:1];
  assign pgassign28[1:1] = BRAM_WEN_B[1:1];
  assign pgassign28[0:0] = BRAM_WEN_B[1:1];
  assign pgassign29[15:15] = 1'b1;
  assign pgassign29[14:2] = BRAM_Addr_A[17:29];
  assign pgassign29[1:0] = 2'b00;
  assign pgassign30[31:4] = 28'b0000000000000000000000000000;
  assign pgassign30[3:0] = BRAM_Dout_A[12:15];
  assign BRAM_Din_A[12:15] = pgassign31[3:0];
  assign pgassign32[3:3] = BRAM_WEN_A[1:1];
  assign pgassign32[2:2] = BRAM_WEN_A[1:1];
  assign pgassign32[1:1] = BRAM_WEN_A[1:1];
  assign pgassign32[0:0] = BRAM_WEN_A[1:1];
  assign pgassign33[15:15] = 1'b1;
  assign pgassign33[14:2] = BRAM_Addr_B[17:29];
  assign pgassign33[1:0] = 2'b00;
  assign pgassign34[31:4] = 28'b0000000000000000000000000000;
  assign pgassign34[3:0] = BRAM_Dout_B[12:15];
  assign BRAM_Din_B[12:15] = pgassign35[3:0];
  assign pgassign36[7:4] = 4'b0000;
  assign pgassign36[3:3] = BRAM_WEN_B[1:1];
  assign pgassign36[2:2] = BRAM_WEN_B[1:1];
  assign pgassign36[1:1] = BRAM_WEN_B[1:1];
  assign pgassign36[0:0] = BRAM_WEN_B[1:1];
  assign pgassign37[15:15] = 1'b1;
  assign pgassign37[14:2] = BRAM_Addr_A[17:29];
  assign pgassign37[1:0] = 2'b00;
  assign pgassign38[31:4] = 28'b0000000000000000000000000000;
  assign pgassign38[3:0] = BRAM_Dout_A[16:19];
  assign BRAM_Din_A[16:19] = pgassign39[3:0];
  assign pgassign40[3:3] = BRAM_WEN_A[2:2];
  assign pgassign40[2:2] = BRAM_WEN_A[2:2];
  assign pgassign40[1:1] = BRAM_WEN_A[2:2];
  assign pgassign40[0:0] = BRAM_WEN_A[2:2];
  assign pgassign41[15:15] = 1'b1;
  assign pgassign41[14:2] = BRAM_Addr_B[17:29];
  assign pgassign41[1:0] = 2'b00;
  assign pgassign42[31:4] = 28'b0000000000000000000000000000;
  assign pgassign42[3:0] = BRAM_Dout_B[16:19];
  assign BRAM_Din_B[16:19] = pgassign43[3:0];
  assign pgassign44[7:4] = 4'b0000;
  assign pgassign44[3:3] = BRAM_WEN_B[2:2];
  assign pgassign44[2:2] = BRAM_WEN_B[2:2];
  assign pgassign44[1:1] = BRAM_WEN_B[2:2];
  assign pgassign44[0:0] = BRAM_WEN_B[2:2];
  assign pgassign45[15:15] = 1'b1;
  assign pgassign45[14:2] = BRAM_Addr_A[17:29];
  assign pgassign45[1:0] = 2'b00;
  assign pgassign46[31:4] = 28'b0000000000000000000000000000;
  assign pgassign46[3:0] = BRAM_Dout_A[20:23];
  assign BRAM_Din_A[20:23] = pgassign47[3:0];
  assign pgassign48[3:3] = BRAM_WEN_A[2:2];
  assign pgassign48[2:2] = BRAM_WEN_A[2:2];
  assign pgassign48[1:1] = BRAM_WEN_A[2:2];
  assign pgassign48[0:0] = BRAM_WEN_A[2:2];
  assign pgassign49[15:15] = 1'b1;
  assign pgassign49[14:2] = BRAM_Addr_B[17:29];
  assign pgassign49[1:0] = 2'b00;
  assign pgassign50[31:4] = 28'b0000000000000000000000000000;
  assign pgassign50[3:0] = BRAM_Dout_B[20:23];
  assign BRAM_Din_B[20:23] = pgassign51[3:0];
  assign pgassign52[7:4] = 4'b0000;
  assign pgassign52[3:3] = BRAM_WEN_B[2:2];
  assign pgassign52[2:2] = BRAM_WEN_B[2:2];
  assign pgassign52[1:1] = BRAM_WEN_B[2:2];
  assign pgassign52[0:0] = BRAM_WEN_B[2:2];
  assign pgassign53[15:15] = 1'b1;
  assign pgassign53[14:2] = BRAM_Addr_A[17:29];
  assign pgassign53[1:0] = 2'b00;
  assign pgassign54[31:4] = 28'b0000000000000000000000000000;
  assign pgassign54[3:0] = BRAM_Dout_A[24:27];
  assign BRAM_Din_A[24:27] = pgassign55[3:0];
  assign pgassign56[3:3] = BRAM_WEN_A[3:3];
  assign pgassign56[2:2] = BRAM_WEN_A[3:3];
  assign pgassign56[1:1] = BRAM_WEN_A[3:3];
  assign pgassign56[0:0] = BRAM_WEN_A[3:3];
  assign pgassign57[15:15] = 1'b1;
  assign pgassign57[14:2] = BRAM_Addr_B[17:29];
  assign pgassign57[1:0] = 2'b00;
  assign pgassign58[31:4] = 28'b0000000000000000000000000000;
  assign pgassign58[3:0] = BRAM_Dout_B[24:27];
  assign BRAM_Din_B[24:27] = pgassign59[3:0];
  assign pgassign60[7:4] = 4'b0000;
  assign pgassign60[3:3] = BRAM_WEN_B[3:3];
  assign pgassign60[2:2] = BRAM_WEN_B[3:3];
  assign pgassign60[1:1] = BRAM_WEN_B[3:3];
  assign pgassign60[0:0] = BRAM_WEN_B[3:3];
  assign pgassign61[15:15] = 1'b1;
  assign pgassign61[14:2] = BRAM_Addr_A[17:29];
  assign pgassign61[1:0] = 2'b00;
  assign pgassign62[31:4] = 28'b0000000000000000000000000000;
  assign pgassign62[3:0] = BRAM_Dout_A[28:31];
  assign BRAM_Din_A[28:31] = pgassign63[3:0];
  assign pgassign64[3:3] = BRAM_WEN_A[3:3];
  assign pgassign64[2:2] = BRAM_WEN_A[3:3];
  assign pgassign64[1:1] = BRAM_WEN_A[3:3];
  assign pgassign64[0:0] = BRAM_WEN_A[3:3];
  assign pgassign65[15:15] = 1'b1;
  assign pgassign65[14:2] = BRAM_Addr_B[17:29];
  assign pgassign65[1:0] = 2'b00;
  assign pgassign66[31:4] = 28'b0000000000000000000000000000;
  assign pgassign66[3:0] = BRAM_Dout_B[28:31];
  assign BRAM_Din_B[28:31] = pgassign67[3:0];
  assign pgassign68[7:4] = 4'b0000;
  assign pgassign68[3:3] = BRAM_WEN_B[3:3];
  assign pgassign68[2:2] = BRAM_WEN_B[3:3];
  assign pgassign68[1:1] = BRAM_WEN_B[3:3];
  assign pgassign68[0:0] = BRAM_WEN_B[3:3];
  assign net_gnd0 = 1'b0;
  assign net_gnd4[3:0] = 4'b0000;

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_0.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_0 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign5 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign6 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign7 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign8 ),
      .ADDRBWRADDR ( pgassign9 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign10 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign11 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign12 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_1.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_1 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign13 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign14 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign15 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign16 ),
      .ADDRBWRADDR ( pgassign17 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign18 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign19 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign20 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_2.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_2 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign21 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign22 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign23 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign24 ),
      .ADDRBWRADDR ( pgassign25 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign26 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign27 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign28 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_3.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_3 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign29 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign30 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign31 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign32 ),
      .ADDRBWRADDR ( pgassign33 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign34 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign35 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign36 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_4.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_4 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign37 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign38 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign39 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign40 ),
      .ADDRBWRADDR ( pgassign41 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign42 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign43 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign44 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_5.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_5 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign45 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign46 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign47 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign48 ),
      .ADDRBWRADDR ( pgassign49 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign50 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign51 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign52 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_6.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_6 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign53 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign54 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign55 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign56 ),
      .ADDRBWRADDR ( pgassign57 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign58 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign59 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign60 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_7.mem" ),
      .READ_WIDTH_A ( 4 ),
      .READ_WIDTH_B ( 4 ),
      .WRITE_WIDTH_A ( 4 ),
      .WRITE_WIDTH_B ( 4 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_7 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign61 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign62 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign63 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign64 ),
      .ADDRBWRADDR ( pgassign65 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign66 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign67 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign68 )
    );

endmodule

