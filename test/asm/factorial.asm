.text
    .globl _start

_start:
    # Initialize variables
    li a0,0x7800   
    lw a0, 0(a0)
    li  t0, 1      # Set t0 to 1 (accumulator for the factorial)
    li a1, 10
    
loop:
    beqz a0, done  # Branch to done if a0 is 0
    jal mult
    addi a0, a0, -1  # Decrement a0 by 1
    j    loop     # Jump back to the loop
    
done:
    li t1, 0x7000
    sw t0, 0(t1)
halt:
    j halt

# t0 = t0 * a0
mult:
    mv t1, a0
    mv t2, t0
mult_loop:
    addi t1, t1, -1
    beqz t1, mult_done
    add t0, t0, t2
    j mult_loop
mult_done:
    ret