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
	return:			.asciiz "\n"
	
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
		
		## Print out the sum and return character.
		la 	$a0, sum
		li 	$v0, 4
		syscall
		move 	$a0, $t3
		li 	$v0, 1
		syscall
		la	$a0, return
		li	$v0, 4
		syscall
		
		## Compute largest and smallest
		bgt 	$t0, $t1, T0_largest_1 	# compare $t0 and $t1
		bgt 	$t1, $t2, T1_largest_2	# compare $t1 and $t2
		
		j 	T2_largest_2			# $t2 is the largest
		
		
	T0_largest_1:
		## $t0 is larger than $t1. Now compare $t0 to $t2
		bgt 	$t0, $t2, T0_largest_2
		
		## $t2 is larger than $t0 and $t1
		j 	T2_largest_2
		
	T0_largest_2:
		## $t1 is the largest integer. Now find the smallest integer.
		move 	$t5, $t0 	# preserve the largest integer in $t5
		blt 	$t1, $t2, T1_smallest
		j 	T2_smallest

		
	T1_largest_2:
		## $t1 is the largest integer. Now find the smallest integer.
		move 	$t5, $t1	# preserve the largest integer in $t5
		blt 	$t0, $t2, T0_smallest
		j 	T2_smallest
	
	T2_largest_2:
		## $t2 is the largest integer. Now find the smallest integer.
		move 	$t5, $t2	# preserve the largest integer in $t5
		blt 	$t0, $t1, T0_smallest
		j 	T1_smallest
		
	T0_smallest:
		move 	$t4, $t0	# preserve the smallest integer in $t4
		j 	print
		
	T1_smallest:
		move 	$t4, $t1	 # preserve the smallest integer in $t4
		j 	print
		
	T2_smallest:
		move 	$t4, $t2	# preserve the smallest integer in $t4
		j 	print
		
	print:
		
		
		j Exit
	
	Exit:
		li 	$v0, 10		# load syscall exit parameter
		syscall			# return control back to OS.
		
