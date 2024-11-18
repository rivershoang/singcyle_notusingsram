`include "../rtl/opcode_type.svh"

module control_unit 
import opcode_type::*; (
  input  logic [31:0] instr    ,
  input  logic        br_less  ,
  input  logic        br_equal ,
  output logic        pc_sel   , // 0 if pc_four, 1 if alu_data
  output logic        reg_wr_en,
  output logic        br_un    , // 1 if signed, 0 if unsigned
  output logic        a_sel    , // 0 if rs1_data, 1 if pc
  output logic        b_sel    , // 0 if rs2_data, 1 if imm
  output logic [ 3:0] alu_sel  ,
  output logic        wr_en    , // write enable from SRAN/LSU
  output logic [ 2:0] ld_sel   , // select byte load
  output logic [ 3:0] bmask    , // select byte store
  output logic [ 1:0] wb_sel   , // 00 if alu_data, 01 if pc_four, 10 if ld_data
  output logic        insn_vld 
);
  
   opcode_type_e opcode_type;
   funct3_e funct3_type;
  
   logic [18:0] other_signal;

   assign {pc_sel, a_sel, b_sel, reg_wr_en, br_un, wr_en, alu_sel, bmask, ld_sel, wb_sel} = other_signal;

   always_comb begin 
      opcode_type = opcode_type_e'(instr[6:0]);
      funct3_type = funct3_e'(instr[14:12]);
      insn_vld = 1'b1;
      case (opcode_type) 
         LUI   : other_signal = 19'b0_1_1_1_1_0_1011_1111_111_00; // lui
         AUIPC : other_signal = 19'b0_1_1_1_1_0_0000_1111_111_00; // auipc
         JAL   : other_signal = 19'b1_1_1_1_1_0_0000_1111_111_10; // jal
         JALR  : other_signal = 19'b1_0_1_1_1_0_0000_1111_111_10; // jalr
         B_type: begin 
            case (funct3_type) 
               BEQ_LB_SB_ADDI   : other_signal = (br_equal) ?  19'b1_1_1_0_1_0_0000_1111_111_00 : 19'b0_1_1_0_1_0_0000_1111_111_00;               // beq
               BNE_LH_SH_SLLI   : other_signal = (~br_equal) ? 19'b1_1_1_0_1_0_0000_1111_111_00 : 19'b0_1_1_0_1_0_0000_1111_111_00;               // bne
               BLT_LBU_XORI     : other_signal = (br_less) ?   19'b1_1_1_0_1_0_0000_1111_111_00 : 19'b0_1_1_0_1_0_0000_1111_111_00;               // blt
               BGE_LHU_SRLI_SRAI: other_signal = (~br_less || br_equal) ?  19'b1_1_1_0_1_0_0000_1111_111_00 : 19'b0_1_1_0_1_0_0000_1111_111_00; // bge
               BLTU_ORI         : other_signal = (br_less) ?   19'b1_1_1_0_0_0_0000_1111_111_00 : 19'b0_1_1_0_0_0_0000_1111_111_00;               // bltu
               BGEU_ANDI        : other_signal = (~br_less || br_equal) ?  19'b1_1_1_0_0_0_0000_1111_111_00 : 19'b0_1_1_0_0_0_0000_1111_111_00; // bgeu
               default          : other_signal = 19'd0;
            endcase
         end 
         I_type: begin 
            case (funct3_type)
               BEQ_LB_SB_ADDI   : other_signal = 19'b0_0_1_1_1_0_0000_1111_111_00; // addi
               LW_SW_SLTI       : other_signal = 19'b0_0_1_1_1_0_0010_1111_111_00; // slti
               SLTIU            : other_signal = 19'b0_0_1_1_0_0_0011_1111_111_00; // sltiu
               BLT_LBU_XORI     : other_signal = 19'b0_0_1_1_1_0_0100_1111_111_00; // xori
               BLTU_ORI         : other_signal = 19'b0_0_1_1_1_0_0110_1111_111_00; // ori
               BGEU_ANDI        : other_signal = 19'b0_0_1_1_1_0_0111_1111_111_00; // andi
               BNE_LH_SH_SLLI   : other_signal = 19'b0_0_1_1_1_0_0001_1111_111_00; // slli
               BGE_LHU_SRLI_SRAI: other_signal = (~instr[30]) ? 19'b0_0_1_1_1_0_0101_1111_111_00 : 19'b0_0_1_1_1_0_1101_1111_111_00; // srli, srai
               default          : other_signal = 19'd0;
            endcase 
         end
         R_type: begin 
            case (funct3_type)
               BEQ_LB_SB_ADDI   : other_signal = (~instr[30]) ? 19'b0_0_0_1_1_0_0000_1111_111_00 : 19'b0_0_0_1_1_0_1000_1111_111_00; // add, sub
               LW_SW_SLTI       : other_signal = 19'b0_0_0_1_1_0_0010_1111_111_00; // slt
               SLTIU            : other_signal = 19'b0_0_0_1_0_0_0011_1111_111_00; // sltu
               BLT_LBU_XORI     : other_signal = 19'b0_0_0_1_1_0_0100_1111_111_00; // xor
               BLTU_ORI         : other_signal = 19'b0_0_0_1_1_0_0110_1111_111_00; // or
               BGEU_ANDI        : other_signal = 19'b0_0_0_1_1_0_0111_1111_111_00; // and
               BNE_LH_SH_SLLI   : other_signal = 19'b0_0_0_1_1_0_0001_1111_111_00; // sll
               BGE_LHU_SRLI_SRAI: other_signal = (~instr[30]) ? 19'b0_0_0_1_1_0_0101_1111_111_00 : 19'b0_0_0_1_1_0_1101_1111_111_00; // srl, sra
               default          : other_signal = 19'd0;
            endcase 
         end
         Load: begin
            case (funct3_type)
               BEQ_LB_SB_ADDI   : other_signal = 19'b0_0_1_1_0_0_0000_1111_000_01; // lb
               BNE_LH_SH_SLLI   : other_signal = 19'b0_0_1_1_0_0_0000_1111_001_01; // lh
               BLT_LBU_XORI     : other_signal = 19'b0_0_1_1_0_0_0000_1111_011_01; // lbu
               BGE_LHU_SRLI_SRAI: other_signal = 19'b0_0_1_1_0_0_0000_1111_100_01; // lhu
               LW_SW_SLTI       : other_signal = 19'b0_0_1_1_0_0_0000_1111_010_01; // lw
               default          : other_signal = 19'd0;
            endcase 
         end
         Store: begin 
            case (funct3_type)
               BEQ_LB_SB_ADDI: other_signal = 19'b0_0_1_0_0_1_0000_0001_000_00; // sb 
               BNE_LH_SH_SLLI: other_signal = 19'b0_0_1_0_0_1_0000_0011_000_00; // sh
               LW_SW_SLTI    : other_signal = 19'b0_0_1_0_0_1_0000_1111_000_00; // sw
               default       : other_signal = 19'd0;
            endcase
         end
         default: begin 
            other_signal = 19'd0;
            insn_vld = 0;
         end
      endcase
   end

endmodule