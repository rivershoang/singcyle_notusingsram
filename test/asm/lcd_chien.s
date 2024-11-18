# address lcd (0x7030)
li s0, 0x7030

#enable bit 31 = 1 

li t0, 0x800000000
sw t0, 0(s0)
jal ra, DELAY100MS

# store data write to memory 
data_init:
   li t0, ' '  
   sw t0, 0x200(x0)
   li t0, 'R' 
   sw t0, 0x204(x0)
   li t0, 'i' 
   sw t0, 0x208(x0)
   li t0, 'v' 
   sw t0, 0x20C(x0)
   li t0, 'e' 
   sw t0, 0x210(x0)
   li t0, 'r' 
   sw t0, 0x214(x0)
   li t0, 's' 
   sw t0, 0x218(x0)
   li t0, 'H' 
   sw t0, 0x21C(x0)
   li t0, 'o' 
   sw t0, 0x220(x0)
   li t0, 'a' 
   sw t0, 0x224(x0)
   li t0, 'n' 
   sw t0, 0x228(x0)
   li t0, 'g' 
   sw t0, 0x22C(x0)

   li t0, ' ' 
   sw t0, 0x240(x0)
   li t0, 'E' 
   sw t0, 0x244(x0)
   li t0, 'E' 
   sw t0, 0x248(x0)
   li t0, '3' 
   sw t0, 0x24C(x0)
   li t0, '0' 
   sw t0, 0x250(x0)
   li t0, '4' 
   sw t0, 0x254(x0)
   li t0, '3' 


# send command init lcd
# data send in reg a1
# 8 bit, 2 lines
addi a1, x0, 0x00000038
jal ra, write_command

# clear display 
addi a1, x0, 0x00000001
jal ra, write_command

# turnon display, off cursor
addi a1, x0, 0x0000000c
jal ra, write_command

# cursor move right 
addi a1, x0, 0x00000006
jal ra, write_command

# cursor on first lines
addi a1, x0, 0x00000080
jal ra, write_command

# send data ascii to lcd 
# data ascii send in reg a1
lw a1, 0x200(x0)
jal ra, write_data
lw a1, 0x204(x0)
jal ra, write_data
lw a1, 0x208(x0)
jal ra, write_data
lw a1, 0x20c(x0)
jal ra, write_data
lw a1, 0x210(x0)
jal ra, write_data
lw a1, 0x214(x0)
jal ra, write_data
lw a1, 0x218(x0)
jal ra, write_data
lw a1, 0x21c(x0)
jal ra, write_data
lw a1, 0x220(x0)
jal ra, write_data
lw a1, 0x224(x0)
jal ra, write_data
lw a1, 0x228(x0)
jal ra, write_data
lw a1, 0x22c(x0)
jal ra, write_data

# cursor in line 2
addi a1, x0, 0x000000c0
jal ra, write_command

# send data cont
lw a1, 0x240(x0)
jal ra, write_data
lw a1, 0x244(x0)
jal ra, write_data
lw a1, 0x248(x0)
jal ra, write_data
lw a1, 0x24c(x0)
jal ra, write_data
lw a1, 0x250(x0)
jal ra, write_data
lw a1, 0x254(x0)
jal ra, write_data

halt: 
   jal halt 

# write command used a1 for data 
write_command: 
   ori t1, a1, 1024 # EN = 1, RS = 0, RW = 0, data = data 
   sh t1, 0(s0) # send to lcd address (0x7030)
   jal ra, DELAY10MS # wait 10ms to process
   addi t1, a1, 255   # EN = 0 , RS = 0, RW = 0, data = data
   sh t1, 0(s0) # send to lcd address (0x7030) again
   jalr x0, ra, 0


# write data used a1 for data
write_data: 
   ori a1, a1, 512 # RS = 1, data = data 
   ori t1, a1, 1024 # EN = 1, RS = 1, RW = 0, data = data
   sh t1, 0(s0) # send to lcd address (0x7030)
   jal ra, DELAY10MS # wait 10ms to process
   addi t1, a1, 255 # EN = 0 , RS = 1, RW = 0, data = data
   sh t1, 0(s0) # send to lcd address (0x7030) again
   jalr x0, ra, 0

# delay function
DELAY10MS:
   li t0, 200000                 # 20ns
   addi t0, t0, -1               # 20ns
   bne  t0, x0, DELAY10MS        # 20ns
   jalr x0, ra, 0                # 20ns

DELAY100MS:
   li t0, 250000                 # 20ns
   addi t0, t0, -1               # 20ns
   bne  t0, x0, DELAY100MS       # 20n
   jalr x0, ra, 0                # 20ns