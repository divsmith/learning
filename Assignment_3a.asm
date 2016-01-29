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
#	$t3	- used to hold the sum
#	$t4 	- used to hold the smallest integer
#	$t5	- used to hold the largest integer
#	$v0	- syscall parameter and return value
#	$a0	- syscall parameter

.data
	first_integer:		.asciiz "Please enter the first integer: "
	second_integer:		.asciiz "Please enter the second integer: "
	third_integer:		.asciiz "Please enter the third integer: "
	sum:			.asciiz "The sum of the integers is "
	smallest:		.asciiz "The smallest integer is "
	largest:		.asciiz "The largest integer is "
	run_again:		.asciiz "Enter 1 to run the program again, 0 to exit: "
	
.text
	main:
		## Print out the message to get the first integer
		la 	$a0, first_integer
		li 	$v0, 4
		syscall
		
		## Read the first integer and place it in $t0
		li 	$v0, 5
		syscall
		move 	$t0, $v0
		
		## Print out the message to get the second integer
		la 	$a0, second_integer
		li 	$v0, 4
		syscall
		
		## Read the second integer and place it in $t1
		li 	$v0, 5
		syscall
		move 	$t1, $v0
			
		## Print out message to get the third integer
		la 	$a0, third_integer
		li 	$v0, 4
		syscall
		
		## Read the third integer and place it in $t2
		li 	$v0, 5
		syscall	
		move 	$t2, $v0
		
		## Compute the sum of the 3 integers
		add $t3, $t0, $t1
		add $t3, $t2, $t3
		
		## Print out the sum
		la 	$a0, sum
		li 	$v0, 4
		syscall
		move 	$a0, $t3
		li 	$v0, 1
		syscall
		
		
		
		j Exit
		
	Exit:
		li 	$v0, 10		# load syscall exit parameter
		syscall			# return control back to OS.
		
