// `timescale 1ns / 1ps

// module immgen_tb;
//    reg  [31:0] instr;
//    wire [31:0] imm;
//    reg         correct;
    
//    immgen u_immgen (
//       .instr  (instr ),
//       .imm    (imm   )
//    );
        
//    initial instr = 32'h0;
    
//    initial begin
//       instr = 32'b00000000000000000100001010110111;  #5;
// 	   if (imm == 32'h4000) correct = 1; else correct = 0;
// 	   $display ("1. lui x5, 4            : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);	     
          
//       instr = 32'b00000000000000001011001100010111;  #5;
// 	   if (imm == 32'hb000) correct = 1; else correct = 0;
// 	   $display ("2. auipc x6, 11         : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);
          
//       instr = 32'b00000000100000000000010101101111;  #5;
// 	   if (imm == 32'd8) correct = 1; else correct = 0;
// 	   $display ("3. jal x10, 8           : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);
         
//       instr = 32'b00000000110000110000000111100111;  #5;
// 	   if (imm == 32'd12) correct = 1; else correct = 0;
// 	   $display ("4. jalr x3, 12(x6)      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000001001110100000011001100011;  #5;
// 	   if (imm == 32'd12) correct = 1; else correct = 0;
// 	   $display ("5. beq x20, x19, 12     : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000001001110100001010101100011;  #5;
// 	   if (imm == 32'd10) correct = 1; else correct = 0;
// 	   $display ("6. bne x20, x19, 10     : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000001001110100100001001100011;  #5;
// 	   if (imm == 32'd4) correct = 1; else correct = 0;
// 	   $display ("7. blt x20, x19, 4      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000001001101111101001101100011;  #5;
// 	   if (imm == 32'd6) correct = 1; else correct = 0;
// 	   $display ("8. bge x15, x19, 6      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000010100011110010001100011;  #5;
// 	   if (imm == 32'd8) correct = 1; else correct = 0;
// 	   $display ("9. bltu x3, x5, 8       : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000001000001111111100001100011;  #5;
// 	   if (imm == 32'd16) correct = 1; else correct = 0;
// 	   $display ("10. bgeu x15, x16, 16   : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000001100010000001010000011;  #5;
// 	   if (imm == 32'd3) correct = 1; else correct = 0;
// 	   $display ("11. lb x5, 3(x2)        : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000000101111100001100000011;  #5;
// 	   if (imm == 32'd1) correct = 1; else correct = 0;
// 	   $display ("12. lbu x6, 1(x15)      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000100001111101001100000011;  #5;
// 	   if (imm == 32'd8) correct = 1; else correct = 0;
// 	   $display ("13. lhu x6, 8(x15)      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000010011001111000001000100011;  #5;
// 	   if (imm == 32'd36) correct = 1; else correct = 0;
// 	   $display ("14. sb x6, 36(x15)      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000011001111001101000100011;  #5;
// 	   if (imm == 32'd20) correct = 1; else correct = 0;
// 	   $display ("15. sh x6, 20(x15)      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000000000110010101000000011;  #5;
// 	   if (imm == 32'd0) correct = 1; else correct = 0;
// 	   $display ("16. lw x20, 0(x6)       : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000001001111001001100000011;  #5;
// 	   if (imm == 32'd2) correct = 1; else correct = 0;
// 	   $display ("17. lh x6, 2(x15)       : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);
	     
//       instr = 32'b00000000100100010010001000100011;  #5;
// 	   if (imm == 32'd4) correct = 1; else correct = 0;
// 	   $display ("18. sw x9, 4(x2)        : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b11111111101110001000110100010011;  #5;
// 	   if (imm == 32'b11111111111111111111111111111011) correct = 1; else correct = 0;
// 	   $display ("19. addi x26, x17, -5   : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b11111111101110001010110100010011;  #5;
// 	   if (imm == 32'b11111111111111111111111111111011) correct = 1; else correct = 0;
// 	   $display ("20. slti x26, x17, -5   : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000010110001011110100010011;  #5;
// 	   if (imm == 32'd5) correct = 1; else correct = 0;
// 	   $display ("21. sltiu x26, x17, 5   : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000100110010100001010010011;  #5;
// 	   if (imm == 32'd9) correct = 1; else correct = 0;
// 	   $display ("22. xori x5, x18, 9     : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000101101100110001010010011;  #5;
// 	   if (imm == 32'd11) correct = 1; else correct = 0;
// 	   $display ("23. ori x5, x12, 11     : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b11111111110101001111001010010011;  #5;
// 	   if (imm == 32'b11111111111111111111111111111101) correct = 1; else correct = 0;
// 	   $display ("24. andi x5, x9, -3     : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000011001001001001010010011;  #5;
// 	   if (imm == 32'd6) correct = 1; else correct = 0;
// 	   $display ("25. slli x5, x9, 6      : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b01000000110001010101010110010011;  #5;
// 	   if (imm == 32'd12) correct = 1; else correct = 0;
// 	   $display ("26. srai x11, x10, 12   : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);

//       instr = 32'b00000000010101010000010110110011;  #5;
// 	   if (imm == 32'd0) correct = 1; else correct = 0;
// 	   $display ("27. add x11, x10, x5    : T = %2d, instr = %8h, imm = %8h, correct = %1d", $time, instr, imm, correct);
//       #5 $finish;
//    end
   
//    initial begin
//       $dumpfile("immgen.vcd");
//       $dumpvars(0, immgen_tb);
//    end

// endmodule


`timescale 1ns / 1ps

module immgen_tb;
   reg  [31:0] instr;
   wire [31:0] imm;
   
   reg [47:0] correct;
    
   immgen u_immgen (
      .instr  (instr ),
      .imm    (imm   )
   );
        
   initial instr = 32'h0;
    
   initial begin
      instr = 32'b00000000000000000100001010110111;  #5;
	   if (imm == 32'h4000) correct = "PASSED"; else correct = "FAILED";
	   $display ("1. lui x5, 4            : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);	     
          
      instr = 32'b00000000000000001011001100010111;  #5;
	   if (imm == 32'hb000) correct = "PASSED"; else correct = "FAILED";
	   $display ("2. auipc x6, 11         : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);
          
      instr = 32'b00000000100000000000010101101111;  #5;
	   if (imm == 32'd8) correct = "PASSED"; else correct = "FAILED";
	   $display ("3. jal x10, 8           : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);
         
      instr = 32'b00000000110000110000000111100111;  #5;
	   if (imm == 32'd12) correct = "PASSED"; else correct = "FAILED";
	   $display ("4. jalr x3, 12(x6)      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000001001110100000011001100011;  #5;
	   if (imm == 32'd12) correct = "PASSED"; else correct = "FAILED";
	   $display ("5. beq x20, x19, 12     : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000001001110100001010101100011;  #5;
	   if (imm == 32'd10) correct = "PASSED"; else correct = "FAILED";
	   $display ("6. bne x20, x19, 10     : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000001001110100100001001100011;  #5;
	   if (imm == 32'd4) correct = "PASSED"; else correct = "FAILED";
	   $display ("7. blt x20, x19, 4      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000001001101111101001101100011;  #5;
	   if (imm == 32'd6) correct = "PASSED"; else correct = "FAILED";
	   $display ("8. bge x15, x19, 6      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000010100011110010001100011;  #5;
	   if (imm == 32'd8) correct = "PASSED"; else correct = "FAILED";
	   $display ("9. bltu x3, x5, 8       : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000001000001111111100001100011;  #5;
	   if (imm == 32'd16) correct = "PASSED"; else correct = "FAILED";
	   $display ("10. bgeu x15, x16, 16   : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000001100010000001010000011;  #5;
	   if (imm == 32'd3) correct = "PASSED"; else correct = "FAILED";
	   $display ("11. lb x5, 3(x2)        : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000000101111100001100000011;  #5;
	   if (imm == 32'd1) correct = "PASSED"; else correct = "FAILED";
	   $display ("12. lbu x6, 1(x15)      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000100001111101001100000011;  #5;
	   if (imm == 32'd8) correct = "PASSED"; else correct = "FAILED";
	   $display ("13. lhu x6, 8(x15)      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000010011001111000001000100011;  #5;
	   if (imm == 32'd36) correct = "PASSED"; else correct = "FAILED";
	   $display ("14. sb x6, 36(x15)      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000011001111001101000100011;  #5;
	   if (imm == 32'd20) correct = "PASSED"; else correct = "FAILED";
	   $display ("15. sh x6, 20(x15)      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000000000110010101000000011;  #5;
	   if (imm == 32'd0) correct = "PASSED"; else correct = "FAILED";
	   $display ("16. lw x20, 0(x6)       : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000001001111001001100000011;  #5;
	   if (imm == 32'd2) correct = "PASSED"; else correct = "FAILED";
	   $display ("17. lh x6, 2(x15)       : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);
	     
      instr = 32'b00000000100100010010001000100011;  #5;
	   if (imm == 32'd4) correct = "PASSED"; else correct = "FAILED";
	   $display ("18. sw x9, 4(x2)        : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b11111111101110001000110100010011;  #5;
	   if (imm == 32'b11111111111111111111111111111011) correct = "PASSED"; else correct = "FAILED";
	   $display ("19. addi x26, x17, -5   : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b11111111101110001010110100010011;  #5;
	   if (imm == 32'b11111111111111111111111111111011) correct = "PASSED"; else correct = "FAILED";
	   $display ("20. slti x26, x17, -5   : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000010110001011110100010011;  #5;
	   if (imm == 32'd5) correct = "PASSED"; else correct = "FAILED";
	   $display ("21. sltiu x26, x17, 5   : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000100110010100001010010011;  #5;
	   if (imm == 32'd9) correct = "PASSED"; else correct = "FAILED";
	   $display ("22. xori x5, x18, 9     : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000101101100110001010010011;  #5;
	   if (imm == 32'd11) correct = "PASSED"; else correct = "FAILED";
	   $display ("23. ori x5, x12, 11     : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b11111111110101001111001010010011;  #5;
	   if (imm == 32'b11111111111111111111111111111101) correct = "PASSED"; else correct = "FAILED";
	   $display ("24. andi x5, x9, -3     : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000011001001001001010010011;  #5;
	   if (imm == 32'd6) correct = "PASSED"; else correct = "FAILED";
	   $display ("25. slli x5, x9, 6      : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b01000000110001010101010110010011;  #5;
	   if (imm == 32'd12) correct = "PASSED"; else correct = "FAILED";
	   $display ("26. srai x11, x10, 12   : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);

      instr = 32'b00000000010101010000010110110011;  #5;
	   if (imm == 32'd0) correct = "PASSED"; else correct = "FAILED";
	   $display ("27. add x11, x10, x5    : T = %2d, instr = %8h, imm = %8h, \t | \t %s", $time, instr, imm, correct);
      #5 $finish;
   end
   
   initial begin
      $dumpfile("immgen.vcd");
      $dumpvars(0, immgen_tb);
   end

endmodule