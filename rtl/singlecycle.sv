module singlecycle 
(
   input  wire        clk     , 
   input  wire        rst_n   ,
   output reg  [31:0] pc_debug,
   output reg        insn_vld, 
   output reg         insn_tmp,
   output wire [31:0] io_ledr ,
   output wire [31:0] io_ledg , 
   output wire [ 6:0] io_hex0 ,
   output wire [ 6:0] io_hex1 ,
   output wire [ 6:0] io_hex2 ,
   output wire [ 6:0] io_hex3 ,
   output wire [ 6:0] io_hex4 ,
   output wire [ 6:0] io_hex5 ,
   output wire [ 6:0] io_hex6 ,
   output wire [ 6:0] io_hex7 ,
   output wire [31:0] io_lcd  ,
   input  wire [31:0] io_sw   ,
   input  wire [ 3:0] io_btn  ,

   // for testbench
   output wire [31:0] instr_test
); 

   wire [ 1:0] wb_sel;
   wire [31:0] pc     , 
                pc_four, 
                nxt_pc ;
   wire [31:0] instr    , 
                rs1_data , 
                rs2_data , 
                imm      , 
                alu_data , 
                r_data   , 
                operand_a, 
                operand_b;
   reg   [31:0] wb_data;             
   wire        reg_wr_en, 
                br_un    , 
                br_less  , 
                br_equal , 
                a_sel    , 
                b_sel    , 
                wr_en    , 
                pc_sel   ;
   wire [ 3:0] alu_sel, 
                bmask  ;
   wire [ 2:0] ld_sel;

   // for testbench
   assign instr_test = instr;

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
      .insn_vld  (insn_tmp)
   ); 
	// program counter 
	assign pc_four = pc + 4;
	
   // pc select 
   assign nxt_pc = (pc_sel) ? alu_data : pc_four;

   pc u_pc (
      .clk    (clk)   ,
      .rst_n  (rst_n) ,
      .pc_in  (nxt_pc),
      .pc_out (pc)
   );

   inst_mem u_imem (
      .raddr (pc),
      .rdata (instr)
   );

   regfile u_regfile (
      .clk      (clk)         ,   
      .rst_n    (rst_n)       ,
      .rs1_addr (instr[19:15]),
      .rs2_addr (instr[24:20]),
      .rd_addr  (instr[11:7]) ,
      .rd_wren  (reg_wr_en)   ,
      .rd_data  (wb_data)     ,
      .rs1_data (rs1_data)    ,
      .rs2_data (rs2_data)
   );

   immgen u_immgen (
      .instr (instr), 
      .imm   (imm)
   );

   brc u_brc (
      .rs1_data (rs1_data),
      .rs2_data (rs2_data),
      .br_un    (br_un)   ,
      .br_less  (br_less) ,
      .br_equal (br_equal)
   );

   // select operand a
   assign operand_a = (a_sel) ? pc : rs1_data; 

   // select operand b
   assign operand_b = (b_sel) ? imm : rs2_data;

   alu u_alu (
      .operand_a (operand_a),
      .operand_b (operand_b),
      .alu_op    (alu_sel)  ,
      .alu_data  (alu_data)
   );

   lsu u_lsu (
      .clk       (clk)           ,
      .rst_n     (rst_n)         ,
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
   always @(*) begin 
      case (wb_sel)
         2'b00: wb_data = alu_data;
         2'b01: wb_data = r_data;
         2'b10: wb_data = pc_four;
         default: wb_data = 0;
      endcase 
   end

   // Hai Cao Xuan
   always @(posedge clk) begin
      pc_debug <= pc;
      insn_vld <= insn_tmp;
   end

endmodule
   



   