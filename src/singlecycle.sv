`include "alu_opcode.svh"
`include "opcode_type.svh"

module singlecycle 
(
   input  logic        clk     , 
   input  logic        rst     ,
   output logic        pc_debug,
   output logic        insn_vld,
   output logic [31:0] io_ledr ,
   output logic [31:0] io_ledg , 
   output logic [ 6:0] io_hex0 ,
   output logic [ 6:0] io_hex1 ,
   output logic [ 6:0] io_hex2 ,
   output logic [ 6:0] io_hex3 ,
   output logic [ 6:0] io_hex4 ,
   output logic [ 6:0] io_hex5 ,
   output logic [ 6:0] io_hex6 ,
   output logic [ 6:0] io_hex7 ,
   output logic [31:0] io_lcd  ,
   input  logic [31:0] io_sw   ,
   input  logic [ 3:0] io_btn  
); 

   logic [ 1:0] wb_sel;
   logic [12:0] pc;
   logic [31:0] instr, wb_data, rs1_data, rs2_data, imm, alu_data, r_data;
   logic        reg_wr_en, br_un, br_less, br_equal, a_sel, b_sel, wr_en, pc_sel;
   logic [ 3:0] alu_sel, bmask;
   logic [ 2:0] ld_sel;

   control_unit ctr_unit (
      .instr     (instr)    ,
      .br_less   (br_less)  ,
      .br_equal  (br_equal) ,
      .pc_sel    (pc_sel)   ,
      .reg_wr_en (reg_wr_en),
      .br_un     (br_un)    ,
      .a_sel     (a_sel)    ,
      .b_sel     (b_sel)    ,
      .alu_sel   (alu_sel)  ,
      .wr_en     (wr_en)    ,
      .ld_sel    (ld_sel)   ,
      .bmask     (bmask)    ,
      .wb_sel    (wb_sel)   ,
      .insn_vld  ()
   ); 
	// program counter 
	assign pc_four = pc + 4;
	
   // pc select 
   assign nxt_pc = (~pc_sel) ? pc_four : alu_data;

   pc pr_cnt (
      .clk    (clk)   ,
      .rst    (rst)   ,
      .pc_in  (nxt_pc),
      .pc_out (pc)
   );

   inst_mem imem (
      .raddr (pc),
      .rdata (instr)
   );

   regfile reg_files (
      .clk      (clk)         ,   
      .rst      (rst)         ,
      .rs1_addr (instr[19:15]) ,
      .rs2_addr (instr[24:20]),
      .rd_addr  (instr[11:7]),
      .rd_wren  (reg_wr_en)   ,
      .rd_data  (wb_data)     ,
      .rs1_data (rs1_data)    ,
      .rs2_data (rs2_data)
   );

   immgen immidiate (
      .instr (instr), 
      .imm   (imm)
   );

   brc branchcomp (
      .rs1_data (rs1_data),
      .rs2_data (rs2_data),
      .br_un    (br_un)   ,
      .br_less  (br_less) ,
      .br_equal (br_equal)
   );

   // select operand a
   assign operand_a = (~a_sel) ? rs1_data : pc; 

   // select operand b
   assign operand_b = (~b_sel) ? rs1_data : imm;

   alu alu_process (
      .operand_a (operand_a),
      .operand_b (operand_b),
      .alu_op    (alu_sel)  ,
      .alu_data  (alu_data)
   );

   lsu load_store_unit (
      .clk       (clk)           ,
      .rst       (rst)           ,
      .addr      (alu_data[15:0]),
      .w_data    (rs2_data)      ,
      .wr_en     (wr_en)         ,
      .bmask     (bmask)         ,
      .ld_sel    (ld_sel)        ,
      .r_data    (r_data)        ,
      .io_ledr   (io_ledr)       ,
      .io_ledg   (io_ledg)       ,
      .io_hex0   (io_hex0)       ,
      .io_hex1   (io_hex1)       ,
      .io_hex2   (io_hex2)       ,
      .io_hex3   (io_hex3)       ,
      .io_hex4   (io_hex4)       ,
      .io_hex5   (io_hex5)       , 
      .io_hex6   (io_hex6)       ,
      .io_hex7   (io_hex7)       ,
      .io_lcd    (io_lcd)        ,
      .io_sw     (io_sw)         ,
      .io_btn    (io_btn)        
   );

   // select wb data
   always_comb begin 
      case (wb_sel)
         2'b00: wb_data = alu_data;
         2'b01: wb_data = r_data;
         2'b10: wb_data = pc_four;
         default: wb_data = 0;
      endcase 
   end

   assign pc_debug = pc;

endmodule : singlecycle
   



   