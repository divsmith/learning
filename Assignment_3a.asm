# Parker Smith -- 1/29/16
# Assignment_3a.asm -- A program that receives 3
#		integers from the keyboard, calculates
#		and displays the sum of the integers,
#		displays the smallest and largest
#		of the integers.

# Registers used:
#	$t0	- used to hold the first integer
#	$t1	- used to hold the second integer
#	$t2 	- used to hold the third integer
#	$v0	- syscall parameter and return value
#	$a0	- syscall parameter

.data
	first_integer:		.asciiz "Please enter the first integer: "
	second_integer:		.asciiz "Please enter the second integer: "
	third_integer:		.asciiz "Please enter the third integer: "
	
	run_again:		.asciiz "Enter 1 to run the program again, 0 to exit: "
	
.text
	main:
		## Print out the message to get the first integer
		la $a0, first_integer
		li $v0, 4
		syscall
		
		## Read the first integer and place it in $t0
		li $v0, 5
		syscall
		
		move $t0, $v0
		
		## Print out the message to get the second integer
		
		
		## Read the second integer and place it in $t1
		
		
		
		## load the third integer
		
