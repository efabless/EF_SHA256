/*
	Copyright 2024 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale 1ns / 1ps
`default_nettype none

module EF_SHA256_AHBL (

    input  wire        HCLK,
    input  wire        HRESETn,
    input  wire        HWRITE,
    input  wire [31:0] HWDATA,
    input  wire [31:0] HADDR,
    input  wire [ 1:0] HTRANS,
    input  wire        HSEL,
    input  wire        HREADY,
    output wire        HREADYOUT,
    output wire [31:0] HRDATA,
    output wire        IRQ

);

  localparam STATUS_REG_OFFSET = 16'h0000;
  localparam CTRL_REG_OFFSET = 16'h0004;
  localparam BLOCK0_REG_OFFSET = 16'h0008;
  localparam BLOCK1_REG_OFFSET = 16'h000C;
  localparam BLOCK2_REG_OFFSET = 16'h0010;
  localparam BLOCK3_REG_OFFSET = 16'h0014;
  localparam BLOCK4_REG_OFFSET = 16'h0018;
  localparam BLOCK5_REG_OFFSET = 16'h001C;
  localparam BLOCK6_REG_OFFSET = 16'h0020;
  localparam BLOCK7_REG_OFFSET = 16'h0024;
  localparam BLOCK8_REG_OFFSET = 16'h0028;
  localparam BLOCK9_REG_OFFSET = 16'h002C;
  localparam BLOCK10_REG_OFFSET = 16'h0030;
  localparam BLOCK11_REG_OFFSET = 16'h0034;
  localparam BLOCK12_REG_OFFSET = 16'h0038;
  localparam BLOCK13_REG_OFFSET = 16'h003C;
  localparam BLOCK14_REG_OFFSET = 16'h0040;
  localparam BLOCK15_REG_OFFSET = 16'h0044;
  localparam DIGEST0_REG_OFFSET = 16'h0048;
  localparam DIGEST1_REG_OFFSET = 16'h004C;
  localparam DIGEST2_REG_OFFSET = 16'h0050;
  localparam DIGEST3_REG_OFFSET = 16'h0054;
  localparam DIGEST4_REG_OFFSET = 16'h0058;
  localparam DIGEST5_REG_OFFSET = 16'h005C;
  localparam DIGEST6_REG_OFFSET = 16'h0060;
  localparam DIGEST7_REG_OFFSET = 16'h0064;
  localparam IM_REG_OFFSET = 16'hFF00;
  localparam MIS_REG_OFFSET = 16'hFF04;
  localparam RIS_REG_OFFSET = 16'hFF08;
  localparam IC_REG_OFFSET = 16'hFF0C;

  reg [0:0] GCLK_REG;
  wire clk_g;

  wire clk_gated_en = GCLK_REG[0];
  ef_util_gating_cell clk_gate_cell (

      // USE_POWER_PINS
      .clk(HCLK),
      .clk_en(clk_gated_en),
      .clk_o(clk_g)
  );

  wire clk = clk_g;
  wire reset_n = HRESETn;

  reg last_HSEL, last_HWRITE;
  reg [31:0] last_HADDR;
  reg [ 1:0] last_HTRANS;
  always @(posedge HCLK or negedge HRESETn) begin
    if (~HRESETn) begin
      last_HSEL   <= 1'b0;
      last_HADDR  <= 1'b0;
      last_HWRITE <= 1'b0;
      last_HTRANS <= 1'b0;
    end else if (HREADY) begin
      last_HSEL   <= HSEL;
      last_HADDR  <= HADDR;
      last_HWRITE <= HWRITE;
      last_HTRANS <= HTRANS;
    end
  end
  wire    ahbl_valid = last_HSEL & last_HTRANS[1];
  wire ahbl_we = last_HWRITE & ahbl_valid;
  wire ahbl_re = ~last_HWRITE & ahbl_valid;

  wire [1-1:0] init;
  wire [1-1:0] next;
  wire [1-1:0] mode;
  wire [512-1:0] block;
  wire [1-1:0] ready;
  wire [256-1:0] digest;
  wire [1-1:0] digest_valid;

  // Register Definitions
  wire [8-1:0] STATUS_WIRE;
  assign STATUS_WIRE[6 : 6] = ready;
  assign STATUS_WIRE[7 : 7] = digest_valid;

  reg [7:0] CTRL_REG;
  assign init = CTRL_REG[0 : 0];
  assign next = CTRL_REG[1 : 1];
  assign mode = CTRL_REG[2 : 2];
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) CTRL_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == CTRL_REG_OFFSET)) CTRL_REG <= HWDATA[8-1:0];

  reg [31:0] BLOCK0_REG;
  assign block[31:0] = BLOCK0_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK0_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK0_REG_OFFSET)) BLOCK0_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK1_REG;
  assign block[63:32] = BLOCK1_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK1_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK1_REG_OFFSET)) BLOCK1_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK2_REG;
  assign block[95:64] = BLOCK2_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK2_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK2_REG_OFFSET)) BLOCK2_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK3_REG;
  assign block[127:96] = BLOCK3_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK3_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK3_REG_OFFSET)) BLOCK3_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK4_REG;
  assign block[159:128] = BLOCK4_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK4_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK4_REG_OFFSET)) BLOCK4_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK5_REG;
  assign block[191:160] = BLOCK5_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK5_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK5_REG_OFFSET)) BLOCK5_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK6_REG;
  assign block[223:192] = BLOCK6_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK6_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK6_REG_OFFSET)) BLOCK6_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK7_REG;
  assign block[255:224] = BLOCK7_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK7_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK7_REG_OFFSET)) BLOCK7_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK8_REG;
  assign block[287:256] = BLOCK8_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK8_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK8_REG_OFFSET)) BLOCK8_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK9_REG;
  assign block[319:288] = BLOCK9_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK9_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK9_REG_OFFSET)) BLOCK9_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK10_REG;
  assign block[351:320] = BLOCK10_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK10_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK10_REG_OFFSET)) BLOCK10_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK11_REG;
  assign block[383:352] = BLOCK11_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK11_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK11_REG_OFFSET)) BLOCK11_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK12_REG;
  assign block[415:384] = BLOCK12_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK12_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK12_REG_OFFSET)) BLOCK12_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK13_REG;
  assign block[447:416] = BLOCK13_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK13_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK13_REG_OFFSET)) BLOCK13_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK14_REG;
  assign block[479:448] = BLOCK14_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK14_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK14_REG_OFFSET)) BLOCK14_REG <= HWDATA[32-1:0];

  reg [31:0] BLOCK15_REG;
  assign block[511:480] = BLOCK15_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) BLOCK15_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == BLOCK15_REG_OFFSET)) BLOCK15_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST0_REG;
  assign digest[31:0] = DIGEST0_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST0_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST0_REG_OFFSET)) DIGEST0_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST1_REG;
  assign digest[63:32] = DIGEST1_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST1_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST1_REG_OFFSET)) DIGEST1_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST2_REG;
  assign digest[95:64] = DIGEST2_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST2_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST2_REG_OFFSET)) DIGEST2_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST3_REG;
  assign digest[127:96] = DIGEST3_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST3_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST3_REG_OFFSET)) DIGEST3_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST4_REG;
  assign digest[159:128] = DIGEST4_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST4_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST4_REG_OFFSET)) DIGEST4_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST5_REG;
  assign digest[191:160] = DIGEST5_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST5_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST5_REG_OFFSET)) DIGEST5_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST6_REG;
  assign digest[223:192] = DIGEST6_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST6_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST6_REG_OFFSET)) DIGEST6_REG <= HWDATA[32-1:0];

  reg [31:0] DIGEST7_REG;
  assign digest[255:224] = DIGEST7_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) DIGEST7_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == DIGEST7_REG_OFFSET)) DIGEST7_REG <= HWDATA[32-1:0];

  localparam GCLK_REG_OFFSET = 16'hFF10;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) GCLK_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == GCLK_REG_OFFSET)) GCLK_REG <= HWDATA[1-1:0];

  reg  [  1:0] IM_REG;
  reg  [  1:0] IC_REG;
  reg  [  1:0] RIS_REG;

  wire [2-1:0] MIS_REG = RIS_REG & IM_REG;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) IM_REG <= 0;
    else if (ahbl_we & (last_HADDR[16-1:0] == IM_REG_OFFSET)) IM_REG <= HWDATA[2-1:0];
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) IC_REG <= 2'b0;
    else if (ahbl_we & (last_HADDR[16-1:0] == IC_REG_OFFSET)) IC_REG <= HWDATA[2-1:0];
    else IC_REG <= 2'd0;

  wire [0:0] valid = digest_valid;

  integer _i_;
  always @(posedge HCLK or negedge HRESETn)
    if (~HRESETn) RIS_REG <= 0;
    else begin
      for (_i_ = 0; _i_ < 1; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (valid[_i_-0] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
      for (_i_ = 1; _i_ < 2; _i_ = _i_ + 1) begin
        if (IC_REG[_i_]) RIS_REG[_i_] <= 1'b0;
        else if (ready[_i_-1] == 1'b1) RIS_REG[_i_] <= 1'b1;
      end
    end

  assign IRQ = |MIS_REG;

  sha256_core instance_to_wrap (
      .clk(clk),
      .reset_n(reset_n),
      .init(init),
      .next(next),
      .mode(mode),
      .block(block),
      .ready(ready),
      .digest(digest),
      .digest_valid(digest_valid)
  );

  assign	HRDATA = 
			(last_HADDR[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(last_HADDR[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(last_HADDR[16-1:0] == BLOCK0_REG_OFFSET)	? BLOCK0_REG :
			(last_HADDR[16-1:0] == BLOCK1_REG_OFFSET)	? BLOCK1_REG :
			(last_HADDR[16-1:0] == BLOCK2_REG_OFFSET)	? BLOCK2_REG :
			(last_HADDR[16-1:0] == BLOCK3_REG_OFFSET)	? BLOCK3_REG :
			(last_HADDR[16-1:0] == BLOCK4_REG_OFFSET)	? BLOCK4_REG :
			(last_HADDR[16-1:0] == BLOCK5_REG_OFFSET)	? BLOCK5_REG :
			(last_HADDR[16-1:0] == BLOCK6_REG_OFFSET)	? BLOCK6_REG :
			(last_HADDR[16-1:0] == BLOCK7_REG_OFFSET)	? BLOCK7_REG :
			(last_HADDR[16-1:0] == BLOCK8_REG_OFFSET)	? BLOCK8_REG :
			(last_HADDR[16-1:0] == BLOCK9_REG_OFFSET)	? BLOCK9_REG :
			(last_HADDR[16-1:0] == BLOCK10_REG_OFFSET)	? BLOCK10_REG :
			(last_HADDR[16-1:0] == BLOCK11_REG_OFFSET)	? BLOCK11_REG :
			(last_HADDR[16-1:0] == BLOCK12_REG_OFFSET)	? BLOCK12_REG :
			(last_HADDR[16-1:0] == BLOCK13_REG_OFFSET)	? BLOCK13_REG :
			(last_HADDR[16-1:0] == BLOCK14_REG_OFFSET)	? BLOCK14_REG :
			(last_HADDR[16-1:0] == BLOCK15_REG_OFFSET)	? BLOCK15_REG :
			(last_HADDR[16-1:0] == DIGEST0_REG_OFFSET)	? DIGEST0_REG :
			(last_HADDR[16-1:0] == DIGEST1_REG_OFFSET)	? DIGEST1_REG :
			(last_HADDR[16-1:0] == DIGEST2_REG_OFFSET)	? DIGEST2_REG :
			(last_HADDR[16-1:0] == DIGEST3_REG_OFFSET)	? DIGEST3_REG :
			(last_HADDR[16-1:0] == DIGEST4_REG_OFFSET)	? DIGEST4_REG :
			(last_HADDR[16-1:0] == DIGEST5_REG_OFFSET)	? DIGEST5_REG :
			(last_HADDR[16-1:0] == DIGEST6_REG_OFFSET)	? DIGEST6_REG :
			(last_HADDR[16-1:0] == DIGEST7_REG_OFFSET)	? DIGEST7_REG :
			(last_HADDR[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(last_HADDR[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(last_HADDR[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(last_HADDR[16-1:0] == GCLK_REG_OFFSET)	? GCLK_REG :
			32'hDEADBEEF;

  assign HREADYOUT = 1'b1;

endmodule
