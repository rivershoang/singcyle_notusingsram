li x5, 68            # number 1 (68) is loaded to x5
li x6, 119           # number 2 (119) is loaded to x6

gcd_loop:
    # If x6 is zero, we're done
    beq x6, x0, end_gcd

    # If x5 > x6, subtract x6 from x5
    blt x6, x5, subtract

    # Else, subtract x5 from x6
    sub x6, x6, x5
    j gcd_loop

subtract:
    sub x5, x5, x6     # Subtract x6 from x5

    # Jump back to the start of the loop
    j gcd_loop

end_gcd:
   lui t1, 0x7       # Nạp phần cao của địa chỉ 0x7010 vào t1 (t1 = 0x70000000)
   addi t1, t1, 0x20   # Thêm phần thấp (0x10) vào t1 (t1 = 0x7010)
   sw x5, 0(t1)        # Lưu giá trị trong x5 (GCD) vào địa chỉ 0x7010


halt:
    j halt              # Halt the program
