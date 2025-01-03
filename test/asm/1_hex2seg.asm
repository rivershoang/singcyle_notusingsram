# base-address s0 = 0x7000
li s0, 0x7000
addi s1, s0, 0x0000     # LEDR[16:0] address: s1 = 0x7000    
addi s2, s0, 0x0010     # LEDG[7:0] address: s2 = 0x7010
addi s3, s0, 0x0020     # _HEX3_HEX2_HEX1_HEX0 address: s3 = 0x7020
addi s4, s0, 0x0024     # _HEX7_HEX6_HEX5_HEX4 address: s4 = 0x7024
addi s5, s0, 0x0030     # LCD address: s5 = 0x7030
addi s6, s0, 0x0400
addi s6, s0, 0x0400     # SW[16:0] address: s6 = 0x7800 (0 - 131071 decimal)
addi s7, s6, 0x0010     # KEY[3:0] address: s7 = 0x7810

# Destructed reg: t1, t2
# t2 = 0x100 is the start-address of LUT(0-9)
Bin2SegLUT:
   addi t2, x0, 0x100
   addi t1, x0, 0x40
   sw t1, 0(t2)
   addi t2, x0, 0x104
   addi t1, x0, 0x79
   sw t1, 0(t2)
   addi t2, x0, 0x108
   addi t1, x0, 0x24
   sw t1, 0(t2)
   addi t2, x0, 0x10c
   addi t1, x0, 0x30
   sw t1, 0(t2)
   addi t2, x0, 0x110
   addi t1, x0, 0x19
   sw t1, 0(t2)
   addi t2, x0, 0x114
   addi t1, x0, 0x12
   sw t1, 0(t2)
   addi t2, x0, 0x118
   addi t1, x0, 0x02
   sw t1, 0(t2)
   addi t2, x0, 0x11c
   addi t1, x0, 0x78
   sw t1, 0(t2)
   addi t2, x0, 0x120
   addi t1, x0, 0x00
   sw t1, 0(t2)
   addi t2, x0, 0x124
   addi t1, x0, 0x10
   sw t1, 0(t2)

MAIN:
   lw t0, 0(s6)
   sw t0, 0(s1)
   jal ra, DIV100000    # t1 will be the quotient, t0 is remainder
   slli t1, t1, 2       # t1 = t1*4
   lw t1, 0x100(t1)     # call LUT to transform t1, t1 = LUT[0x100 + 4*t1]
   jal ra, STORE_HEX5   # store t1 to hex

   jal ra, DIV10000
   slli t1, t1, 2       
   lw t1, 0x100(t1)    
   jal ra, STORE_HEX4  

   jal ra, DIV1000
   slli t1, t1, 2       
   lw t1, 0x100(t1)    
   jal ra, STORE_HEX3  

   jal ra, DIV100
   slli t1, t1, 2       
   lw t1, 0x100(t1)    
   jal ra, STORE_HEX2  

   jal ra, DIV10
   slli t1, t1, 2       
   lw t1, 0x100(t1)    
   jal ra, STORE_HEX1 

   jal ra, DIV1
   slli t1, t1, 2       
   lw t1, 0x100(t1)    
   jal ra, STORE_HEX0 
   
   jal ra, MAIN

# Destructed reg: t0, t1, t2
# Input: t0
# Output: t0 (remainder), t1 (quotient)
DIV100000:
   li t1, 0
   li t2, -100000
DIV100000_LOOP:
   addi t1, t1, 1
   add  t0, t0, t2
   bge  t0, x0, DIV100000_LOOP
   
   addi t1, t1, -1
   li t2, 100000
   add  t0, t0, t2
   jalr x0, ra, 0

DIV10000:
   li t1, 0
   li t2, -10000
DIV10000_LOOP:
   addi t1, t1, 1
   add  t0, t0, t2
   bge  t0, x0, DIV10000_LOOP
   
   addi t1, t1, -1
   li t2, 10000
   add  t0, t0, t2
   jalr x0, ra, 0

DIV1000:
   li t1, 0
   li t2, -1000
DIV1000_LOOP:
   addi t1, t1, 1
   add  t0, t0, t2
   bge  t0, x0, DIV1000_LOOP
   
   addi t1, t1, -1
   li t2, 1000
   add  t0, t0, t2
   jalr x0, ra, 0

DIV100:
   li t1, 0
   li t2, -100
DIV100_LOOP:
   addi t1, t1, 1
   add  t0, t0, t2
   bge  t0, x0, DIV100_LOOP
   
   addi t1, t1, -1
   li t2, 100
   add  t0, t0, t2
   jalr x0, ra, 0

DIV10:
   li t1, 0
   li t2, -10
DIV10_LOOP:
   addi t1, t1, 1
   add  t0, t0, t2
   bge  t0, x0, DIV10_LOOP
   
   addi t1, t1, -1
   li t2, 10
   add  t0, t0, t2
   jalr x0, ra, 0

DIV1:
   li t1, 0
   li t2, -1
DIV1_LOOP:
   addi t1, t1, 1
   add  t0, t0, t2
   bge  t0, x0, DIV1_LOOP
   
   addi t1, t1, -1
   li t2, 1
   add  t0, t0, t2
   jalr x0, ra, 0

# Destructed reg: t1, t2, t3
# Input: t1
# Output: HEX_ hold t1 seg
STORE_HEX0:
   lw t2, 0(s3)
   li t3, 0xFFFFFF00
   and t2, t2, t3
   or t1, t1, t2
   sw t1, 0(s3)
   jalr x0, ra, 0

STORE_HEX1:
   lw t2, 0(s3)
   li t3, 0xFFFF00FF
   and t2, t2, t3
   slli t1, t1, 8
   or t1, t1, t2
   sw t1, 0(s3)
   jalr x0, ra, 0

STORE_HEX2:
   lw t2, 0(s3)
   li t3, 0xFF00FFFF
   and t2, t2, t3
   slli t1, t1, 16
   or t1, t1, t2
   sw t1, 0(s3)
   jalr x0, ra, 0

STORE_HEX3:
   lw t2, 0(s3)
   li t3, 0x00FFFFFF
   and t2, t2, t3
   slli t1, t1, 24
   or t1, t1, t2
   sw t1, 0(s3)
   jalr x0, ra, 0

STORE_HEX4:
   lw t2, 0(s4)
   li t3, 0xFFFFFF00
   and t2, t2, t3
   or t1, t1, t2
   sw t1, 0(s4)
   jalr x0, ra, 0

STORE_HEX5:
   lw t2, 0(s4)
   li t3, 0xFFFF00FF
   and t2, t2, t3
   slli t1, t1, 8
   or t1, t1, t2
   sw t1, 0(s4)
   jalr x0, ra, 0

STORE_HEX6:
   lw t2, 0(s4)
   li t3, 0xFF00FFFF
   and t2, t2, t3
   slli t1, t1, 16
   or t1, t1, t2
   sw t1, 0(s4)
   jalr x0, ra, 0
   
STORE_HEX7:
   lw t2, 0(s4)
   li t3, 0x00FFFFFF
   and t2, t2, t3
   slli t1, t1, 24
   or t1, t1, t2
   sw t1, 0(s4)
   jalr x0, ra, 0