#Aaron

.data
sum: .asciiz "Array[C]: "							#store string to say sum
arrayA: .float 10.1, 3.2, 7.3, 2.4, 1.5, 20.6, 16.7, 18.8, 11.9, 17.0		#Array1 to store the first list
arrayB: .float 3.0, 4.1, 2.2, 8.3, 4.3, 1.5, 7.6, 9.7, 10.8, 20.9		#Array2 to store the second list
arrayC: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0			#ArraySum to store the sum of Array1 and Array2

.text
main:   
	la $t1, arrayA								#address of arrayA in $t1
	la $t2, arrayB								#address of arrayB in $t2
	la $t3, arrayC								#address of arrayC in $t3

	li $t0, 0								#initiate counter for gameOne				
	li $s1, 10								
	
	li $v0, 4								#print out string "sum"
	la $a0, sum
	syscall
	
	j gameOne								#go to gameOne

gameOne:
	beq $t0, $s1, sideboard							#run gameOne as long as $t0 does not equal 10

	ldc1 $f3, 0($t1)							#load number into $f3
	ldc1 $f4, 0($t2)							#load number into $f4

	add.s $f5, $f3, $f4							#add $f3 and $f4 and put into $f5
	
	swc1 $f5, 0($t3)							#store $f5 into arrayC

	addi $t0, $t0, 1							#add 1 to $t0
	addi $t1, $t1, 4							#move pointer to next spot in arrayA
	addi $t2, $t2, 4							#move pointer to next spot in arrayB
	addi $t3, $t3, 4							#move pointer to next spot in arrayC
	
	j gameOne								#jump back to gameOne

sideboard:
	la $t3, arrayC								#reinitialize $t3 to address of arrayC
	li $t5, 0								#initiate counter for gameTwo gameOne

gameTwo:	
	beq $t5, $s1, GGEZ							#go to GGEZ if counter reaches 10

	ldc1 $f6, 0($t3)							#load number into $f6
	
	li $v0,2								#print number 
	mov.s $f12, $f6				
	syscall

	li $a0, 32								#print space				
	li $v0, 11								
	syscall
	
	addi $t3, $t3, 4							#move pointer to next spot in arrayC
	addi $t5, $t5, 1							#add 1 to $t5
	
	j gameTwo								#jump back to gameTwo

GGEZ:
	li $v0, 10
	syscall									#end the program