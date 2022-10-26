//
// Generated by Bluespec Compiler, version 2022.01-29-gc526ff54 (build c526ff54)
//
// On Thu Oct 27 01:56:18 CST 2022
//
//
// Ports:
// Name                         I/O  size props
// CLK                            I     1 clock
// RST_N                          I     1 reset
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkTb(CLK,
	    RST_N);
  input  CLK;
  input  RST_N;

  // register counter
  reg [9 : 0] counter;
  wire [9 : 0] counter$D_IN;
  wire counter$EN;

  // ports of submodule isa_ex_itf
  wire [236 : 0] isa_ex_itf$alu_set_alu_in;
  wire [97 : 0] isa_ex_itf$alu_out_to_mem;
  wire [37 : 0] isa_ex_itf$alu_out_to_reg;
  wire isa_ex_itf$EN_alu_set;

  // ports of submodule reg_itf
  wire [37 : 0] reg_itf$reg_wr_back_alu_out_to_reg;
  wire [11 : 0] reg_itf$reg_rd_out_id_to_reg;
  wire reg_itf$EN_reg_wr_back;

  // remaining internal signals
  wire [31 : 0] alu_in_instr__h238;

  // submodule isa_ex_itf
  mkISAEX isa_ex_itf(.CLK(CLK),
		     .RST_N(RST_N),
		     .alu_set_alu_in(isa_ex_itf$alu_set_alu_in),
		     .EN_alu_set(isa_ex_itf$EN_alu_set),
		     .RDY_alu_set(),
		     .alu_out_to_reg(isa_ex_itf$alu_out_to_reg),
		     .RDY_alu_out_to_reg(),
		     .alu_out_to_mem(isa_ex_itf$alu_out_to_mem),
		     .RDY_alu_out_to_mem());

  // submodule reg_itf
  mkRegfile reg_itf(.CLK(CLK),
		    .RST_N(RST_N),
		    .reg_rd_out_id_to_reg(reg_itf$reg_rd_out_id_to_reg),
		    .reg_wr_back_alu_out_to_reg(reg_itf$reg_wr_back_alu_out_to_reg),
		    .EN_reg_wr_back(reg_itf$EN_reg_wr_back),
		    .RDY_reg_wr_back(),
		    .reg_rd_out(),
		    .RDY_reg_rd_out());

  // register counter
  assign counter$D_IN = counter + 10'd1 ;
  assign counter$EN = counter != 10'd1023 ;

  // submodule isa_ex_itf
  assign isa_ex_itf$alu_set_alu_in =
	     { alu_in_instr__h238,
	       32'd0,
	       { {22{counter[9]}}, counter },
	       141'h000000001080000000000000000000000000 } ;
  assign isa_ex_itf$EN_alu_set = 1'd1 ;

  // submodule reg_itf
  assign reg_itf$reg_rd_out_id_to_reg = 12'h0 ;
  assign reg_itf$reg_wr_back_alu_out_to_reg = isa_ex_itf$alu_out_to_reg ;
  assign reg_itf$EN_reg_wr_back = 1'd1 ;

  // remaining internal signals
  assign alu_in_instr__h238 = { 2'b0, counter, 5'b0, counter[2:0], 12'd19 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        counter <= `BSV_ASSIGNMENT_DELAY 10'b0;
      end
    else
      begin
        if (counter$EN) counter <= `BSV_ASSIGNMENT_DELAY counter$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    counter = 10'h2AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      $display("%d , ISAEX immd operation input", $unsigned(counter));
    if (RST_N != `BSV_RESET_VALUE) if (counter == 10'd1023) $finish(32'd1);
    if (RST_N != `BSV_RESET_VALUE)
      $display("%d , IMMD operation output",
	       $signed(isa_ex_itf$alu_out_to_reg[37:6]));
    if (RST_N != `BSV_RESET_VALUE)
      $display("%d %d , IMMD operation output",
	       isa_ex_itf$alu_out_to_mem[0],
	       $unsigned(isa_ex_itf$alu_out_to_mem[97:66]));
  end
  // synopsys translate_on
endmodule  // mkTb
