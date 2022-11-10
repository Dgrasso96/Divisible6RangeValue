.data
input: .asciiz "Enter a value to check divisibility with6 6\n"
yes: .asciiz "The number is divisible by 6\n"
no: .asciiz "The number is not divisibility by 6\n"

.text
Main:
la $a0, input
li $v0, 4
syscall
li $v0, 5
syscall
move $a0, $v0
jal div6
li $v0, 10
syscall

div6:
addi $sp, $sp, -8
sw $ra, 0($sp)

while:
beq $a0, $zero, exitloop
li $t0, 3
div $a0, $t0
mfhi $t0
bne $t0, $zero, else
sw $a0, 4($sp)
jal div2
#lw $a0, 4($sp) # prova a togliere
beq $v0, $zero, else
#lw $a0, 4($sp)  # prova a togliere
la $a0, yes
li $v0, 4
syscall
lw $a0, 4($sp)
j decremento

else:
sw $a0, 4($sp)
la $a0, no
li $v0, 4
syscall
lw $a0, 4($sp)

decremento:
subi $a0, $a0, 1
j while

exitloop:
lw $ra, 0($sp)
addi $sp, $sp, 8
jr $ra

div2:
li $t0, 2
div $a0, $t0
mfhi $t0
beq $t0, $zero, return1
li $v0, 0
j exit

return1:
li $v0, 1

exit:
jr $ra
