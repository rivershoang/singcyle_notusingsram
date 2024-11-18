`timescale 1ns/1ps

module control_unit_tb;

    logic [31:0]  instr;
    logic         br_less, br_equal;
    logic         br_sel, rd_wren, br_unsigned, op_a_sel, op_b_sel, mem_wren;
    logic [3:0]   alu_op, bmask;
    logic [1:0]   wb_sel;
    logic [2:0]   ld_sel;
   
	control_unit u_control_unit (
		.instr      (instr      ),
		.br_less    (br_less    ),
		.br_equal   (br_equal   ),
		.pc_sel     (br_sel     ),
		.reg_wr_en  (rd_wren    ),
		.br_un      (br_unsigned),
		.a_sel      (op_a_sel   ),
		.b_sel      (op_b_sel   ),
		.wr_en      (mem_wren   ),
		.alu_sel    (alu_op     ),
		.wb_sel     (wb_sel     ),
      .ld_sel     (ld_sel     ),
      .bmask      (bmask     ),
      .insn_vld   (          )
	);
	
	initial begin
		instr        = 32'h0000_0013;
      br_less      = 1'b0;
		br_equal     = 1'b0;
	end
	
	initial begin
		#3
		instr = 32'b00000000000000000111010100110111;         // LUI x10, 7
		$display ("LUI x10, 7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b1011) && (wb_sel == 2'b00)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_less = 1'b0;                                       
		br_equal = 1'b1;
		#3
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		instr = 32'b00000000000000000111010100010111;         // AUIPC x10, 7
		$display ("AUIPC x10, 7");
		#1
      assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0000) && (wb_sel == 2'b00)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_equal = 1'b1;                                      
		#3
		br_less = 1'b0;
		#3
		br_equal = 1'b0;
		#3 
		instr = 32'b00000000101000000000001011101111;         // JAL x5, 10
		$display ("JAL x5, 10");
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (wb_sel == 2'b10)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_equal = 1'b1;                                      
		#3
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		instr = 32'b0000000000011000010101100111;             // JALR x5, 0(x2)
		$display ("JALR x5, 0(x2)");
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (wb_sel == 2'b10)) $display("PASSED"); 
		else $error("Assertion failed");
		#2
		br_equal = 1'b1;                                      
		#3
		br_less = 1'b0;
		#3
		br_equal = 1'b0;
		#3
		instr = 32'b00000000101001011000010001100011;         // BEQ x11, x10, 8
		$display ("BEQ x11, x10, 8");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) 
      && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 0
		#2
		br_equal = 1'b1; 
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 1
      #2
		instr = 32'b00000000101001011001011001100011;         // BNE x11, x10, 12
		$display ("BNE x11, x10, 12");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 1
		#2
		br_equal = 1'b0; 
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
      (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 0
		#2
		instr = 32'b00000001000001111100010001100011;         // BLT x15, x16, 8
		$display ("BLT x15, x16, 8");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 0
		#2
		br_less = 1'b1;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 1, br_equal = 0
		#2
		instr = 32'b00000000110000111101001001100011;         // BGE x7, x12, 4
		$display ("BGE x7, x12, 4");	
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
      else $error("Assertion failed");                      //br_less = 1, br_equal = 0
		#2
		br_less = 1'b0;                                       //br_less = 0, br_equal = 0
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 0
		#2
		br_equal = 1'b1;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b1) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 1
		#2
		instr = 32'b00000000010100011110010001100011;         // BLTU x3, x5, 8
		$display ("BLTU x3, x5, 8");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 1
		#2
		br_less = 1'b1;
		br_equal = 1'b0;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 1, br_equal = 0
		#2
		instr = 32'b00000001000001111111100001100011;         // BGEU x15, x16, 16
		$display ("BGEU x15, x16, 16");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 1, br_equal = 0
		#2
		br_less = 1'b0;
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 0
		#2
		br_equal = 1'b1; 
		#1
		assert ((br_sel == 1'b1) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b1) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0)) $display("PASSED"); 
		else $error("Assertion failed");                      //br_less = 0, br_equal = 1
		
      #2
		instr = 32'b00000000000000110010101000000011;         //LW x20, 0(x6)
		$display ("LW x20, 0(x6)");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0) && (wb_sel == 2'b01)) $display("PASSED"); 
		else $error("Assertion failed");                      
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000100100010010001000100011;      //SW x9, 4(x2)
		$display ("SW x9, 4(x2)");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b0) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b1) && (alu_op == 4'b0)  && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111101110001000110100010011;      //ADDI x26, x17, -5
		$display ("ADDI x26, x17, -5");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1)  && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b00000) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111101110001010110100010011;      //SLTI x26, x17, -5
		$display ("SLTI x26, x17, -5");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0010)  &&  (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111101110001011110100010011;      //SLTIU x26, x17, -5
		$display ("SLTIU x26, x17, -5");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (br_unsigned == 1'b0) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b011) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000100110010100001010010011;      //XORI x5, x18, 9
		$display ("XORI x5, x18, 9");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0100) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000101101100110001010010011;      //ORI x5, x12, 11
		$display ("ORI x5, x12, 11");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0110) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b11111111110101001111001010010011;      //ANDI x5, x9, -3
		$display ("ANDI x5, x9, -3");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0111) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
	   #2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011001001001001010010011;      //SLLI x5, x9, 6
		$display ("SLLI x5, x9, 6");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0001) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000001101010101001010010011;      //SRLI x5, x10, 3
		$display ("SRLI x5, x10, 3");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b0101) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b01000000110001010101010110010011;      //SRAI x11, x10, 12
		$display ("SRAI x11, x10, 12");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b1) && (mem_wren == 1'b0) && (alu_op == 4'b1101) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000010101010000010110110011;      //ADD x11, x10, x5
		$display ("ADD x11, x10, x5");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0000) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                   
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b01000000010101010000010110110011;   //SUB x11, x10, x5
		$display ("SUB x11, x10, x5");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b1000) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110010001010110011;   //SLT x5, x6, x7
		$display ("SLT x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0010) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110011001010110011;   //SLTU x5, x6, x7
		$display ("SLTU x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0011) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110100001010110011;   //XOR x5, x6, x7
		$display ("XOR x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0100) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3         
		instr = 32'b00000000011100110110001010110011;   //OR x5, x6, x7
		$display ("OR x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0110) && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110111001010110011;   //AND x5, x6, x7
		$display ("AND x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0111) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3          
		instr = 32'b00000000011100110001001010110011;   //SLL x5, x6, x7
		$display ("SLL x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0001)  && (wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
		#3
		instr = 32'b00000000011100110101001010110011;   //SRL x5, x6, x7
		$display ("SRL x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b0101) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b1;
		#3
		br_less = 1'b0;
		#3          
		instr = 32'b01000000011100110101001010110011;   //SRA x5, x6, x7
		$display ("SRA x5, x6, x7");
		#1
		assert ((br_sel == 1'b0) && (rd_wren == 1'b1) && (op_a_sel == 1'b0) &&
	   (op_b_sel == 1'b0) && (mem_wren == 1'b0) && (alu_op == 4'b1101) &&
		(wb_sel == 2'b0)) $display("PASSED"); 
		else $error("Assertion failed");                
		#2
		br_less = 1'b1;
		#3
		br_equal = 1'b0;
		#3
		br_less = 1'b0;
	   #10	
      $finish;
	end

   initial begin
      $dumpfile("control_unit.vcd");
      $dumpvars(0, control_unit_tb);
   end

endmodule 