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

module EF_SHA256_WB (

    input  wire        clk_i,
    input  wire        rst_i,
    input  wire [31:0] adr_i,
    input  wire [31:0] dat_i,
    output wire [31:0] dat_o,
    input  wire [ 3:0] sel_i,
    input  wire        cyc_i,
    input  wire        stb_i,
    output reg         ack_o,
    input  wire        we_i,
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
      .clk(clk_i),
      .clk_en(clk_gated_en),
      .clk_o(clk_g)
  );

  wire           clk = clk_g;
  wire           reset_n = (~rst_i);

  wire           wb_valid = cyc_i & stb_i;
  wire           wb_we = we_i & wb_valid;
  wire           wb_re = ~we_i & wb_valid;
  wire [    3:0] wb_byte_sel = sel_i & {4{wb_we}};

  wire [  1-1:0] init;
  wire [  1-1:0] next;
  wire [  1-1:0] mode;
  wire [512-1:0] block;
  wire [  1-1:0] ready;
  wire [256-1:0] digest;
  wire [  1-1:0] digest_valid;

  // Register Definitions
  wire [  8-1:0] STATUS_WIRE;
  assign STATUS_WIRE[6 : 6] = ready;
  assign STATUS_WIRE[7 : 7] = digest_valid;

  reg [7:0] CTRL_REG;
  assign init = CTRL_REG[0 : 0];
  assign next = CTRL_REG[1 : 1];
  assign mode = CTRL_REG[2 : 2];
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) CTRL_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == CTRL_REG_OFFSET)) CTRL_REG <= dat_i[8-1:0];

  reg [31:0] BLOCK0_REG;
  assign block[31:0] = BLOCK0_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK0_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK0_REG_OFFSET)) BLOCK0_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK1_REG;
  assign block[63:32] = BLOCK1_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK1_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK1_REG_OFFSET)) BLOCK1_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK2_REG;
  assign block[95:64] = BLOCK2_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK2_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK2_REG_OFFSET)) BLOCK2_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK3_REG;
  assign block[127:96] = BLOCK3_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK3_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK3_REG_OFFSET)) BLOCK3_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK4_REG;
  assign block[159:128] = BLOCK4_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK4_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK4_REG_OFFSET)) BLOCK4_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK5_REG;
  assign block[191:160] = BLOCK5_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK5_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK5_REG_OFFSET)) BLOCK5_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK6_REG;
  assign block[223:192] = BLOCK6_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK6_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK6_REG_OFFSET)) BLOCK6_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK7_REG;
  assign block[255:224] = BLOCK7_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK7_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK7_REG_OFFSET)) BLOCK7_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK8_REG;
  assign block[287:256] = BLOCK8_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK8_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK8_REG_OFFSET)) BLOCK8_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK9_REG;
  assign block[319:288] = BLOCK9_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK9_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK9_REG_OFFSET)) BLOCK9_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK10_REG;
  assign block[351:320] = BLOCK10_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK10_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK10_REG_OFFSET)) BLOCK10_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK11_REG;
  assign block[383:352] = BLOCK11_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK11_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK11_REG_OFFSET)) BLOCK11_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK12_REG;
  assign block[415:384] = BLOCK12_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK12_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK12_REG_OFFSET)) BLOCK12_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK13_REG;
  assign block[447:416] = BLOCK13_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK13_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK13_REG_OFFSET)) BLOCK13_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK14_REG;
  assign block[479:448] = BLOCK14_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK14_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK14_REG_OFFSET)) BLOCK14_REG <= dat_i[32-1:0];

  reg [31:0] BLOCK15_REG;
  assign block[511:480] = BLOCK15_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) BLOCK15_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == BLOCK15_REG_OFFSET)) BLOCK15_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST0_REG;
  assign digest[31:0] = DIGEST0_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST0_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST0_REG_OFFSET)) DIGEST0_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST1_REG;
  assign digest[63:32] = DIGEST1_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST1_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST1_REG_OFFSET)) DIGEST1_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST2_REG;
  assign digest[95:64] = DIGEST2_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST2_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST2_REG_OFFSET)) DIGEST2_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST3_REG;
  assign digest[127:96] = DIGEST3_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST3_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST3_REG_OFFSET)) DIGEST3_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST4_REG;
  assign digest[159:128] = DIGEST4_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST4_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST4_REG_OFFSET)) DIGEST4_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST5_REG;
  assign digest[191:160] = DIGEST5_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST5_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST5_REG_OFFSET)) DIGEST5_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST6_REG;
  assign digest[223:192] = DIGEST6_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST6_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST6_REG_OFFSET)) DIGEST6_REG <= dat_i[32-1:0];

  reg [31:0] DIGEST7_REG;
  assign digest[255:224] = DIGEST7_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) DIGEST7_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == DIGEST7_REG_OFFSET)) DIGEST7_REG <= dat_i[32-1:0];

  localparam GCLK_REG_OFFSET = 16'hFF10;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) GCLK_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == GCLK_REG_OFFSET)) GCLK_REG <= dat_i[1-1:0];

  reg  [  1:0] IM_REG;
  reg  [  1:0] IC_REG;
  reg  [  1:0] RIS_REG;

  wire [2-1:0] MIS_REG = RIS_REG & IM_REG;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) IM_REG <= 0;
    else if (wb_we & (adr_i[16-1:0] == IM_REG_OFFSET)) IM_REG <= dat_i[2-1:0];
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) IC_REG <= 2'b0;
    else if (wb_we & (adr_i[16-1:0] == IC_REG_OFFSET)) IC_REG <= dat_i[2-1:0];
    else IC_REG <= 2'd0;

  wire [0:0] valid = digest_valid;

  integer _i_;
  always @(posedge clk_i or posedge rst_i)
    if (rst_i) RIS_REG <= 0;
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

  assign	dat_o = 
			(adr_i[16-1:0] == STATUS_REG_OFFSET)	? STATUS_WIRE :
			(adr_i[16-1:0] == CTRL_REG_OFFSET)	? CTRL_REG :
			(adr_i[16-1:0] == BLOCK0_REG_OFFSET)	? BLOCK0_REG :
			(adr_i[16-1:0] == BLOCK1_REG_OFFSET)	? BLOCK1_REG :
			(adr_i[16-1:0] == BLOCK2_REG_OFFSET)	? BLOCK2_REG :
			(adr_i[16-1:0] == BLOCK3_REG_OFFSET)	? BLOCK3_REG :
			(adr_i[16-1:0] == BLOCK4_REG_OFFSET)	? BLOCK4_REG :
			(adr_i[16-1:0] == BLOCK5_REG_OFFSET)	? BLOCK5_REG :
			(adr_i[16-1:0] == BLOCK6_REG_OFFSET)	? BLOCK6_REG :
			(adr_i[16-1:0] == BLOCK7_REG_OFFSET)	? BLOCK7_REG :
			(adr_i[16-1:0] == BLOCK8_REG_OFFSET)	? BLOCK8_REG :
			(adr_i[16-1:0] == BLOCK9_REG_OFFSET)	? BLOCK9_REG :
			(adr_i[16-1:0] == BLOCK10_REG_OFFSET)	? BLOCK10_REG :
			(adr_i[16-1:0] == BLOCK11_REG_OFFSET)	? BLOCK11_REG :
			(adr_i[16-1:0] == BLOCK12_REG_OFFSET)	? BLOCK12_REG :
			(adr_i[16-1:0] == BLOCK13_REG_OFFSET)	? BLOCK13_REG :
			(adr_i[16-1:0] == BLOCK14_REG_OFFSET)	? BLOCK14_REG :
			(adr_i[16-1:0] == BLOCK15_REG_OFFSET)	? BLOCK15_REG :
			(adr_i[16-1:0] == DIGEST0_REG_OFFSET)	? DIGEST0_REG :
			(adr_i[16-1:0] == DIGEST1_REG_OFFSET)	? DIGEST1_REG :
			(adr_i[16-1:0] == DIGEST2_REG_OFFSET)	? DIGEST2_REG :
			(adr_i[16-1:0] == DIGEST3_REG_OFFSET)	? DIGEST3_REG :
			(adr_i[16-1:0] == DIGEST4_REG_OFFSET)	? DIGEST4_REG :
			(adr_i[16-1:0] == DIGEST5_REG_OFFSET)	? DIGEST5_REG :
			(adr_i[16-1:0] == DIGEST6_REG_OFFSET)	? DIGEST6_REG :
			(adr_i[16-1:0] == DIGEST7_REG_OFFSET)	? DIGEST7_REG :
			(adr_i[16-1:0] == IM_REG_OFFSET)	? IM_REG :
			(adr_i[16-1:0] == MIS_REG_OFFSET)	? MIS_REG :
			(adr_i[16-1:0] == RIS_REG_OFFSET)	? RIS_REG :
			(adr_i[16-1:0] == IC_REG_OFFSET)	? IC_REG :
			32'hDEADBEEF;

  always @(posedge clk_i or posedge rst_i)
    if (rst_i) ack_o <= 1'b0;
    else if (wb_valid & ~ack_o) ack_o <= 1'b1;
    else ack_o <= 1'b0;
endmodule