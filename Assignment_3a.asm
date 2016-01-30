# Parker Smith -- 1/29/16

# Assignment_3a.asm -- A program that receives 3
#		integers from the keyboard, calculates
#		and displays the sum of the integers,
#		displays the smallest and largest
#		of the integers. It then runs again if
#		desired by the user.

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
	run_again:		.asciiz "Enter 1 to run the program again or 0 to exit: "
	return:			.asciiz "\n"
	
.text
	main:
		## Print out the message to get the first integer
		la 	$a0, first_integer	# load address for first_integer
		li 	$v0, 4			# setup syscall to print string
		syscall
		
		## Read the first integer and place it in $t0
		li 	$v0, 5			# setup syscall to read integer
		syscall
		move 	$t0, $v0		# move input to $t0
		
		## Print out the message to get the second integer
		la 	$a0, second_integer	# load address for second_integer
		li 	$v0, 4			# setup syscall to print string
		syscall
		
		## Read the second integer and place it in $t1
		li 	$v0, 5			# setup syscall to read integer
		syscall
		move 	$t1, $v0		# move input to $t1
			
		## Print out message to get the third integer
		la 	$a0, third_integer	# load address for third_integer
		li 	$v0, 4			# setup syscall to print string
		syscall
		
		## Read the third integer and place it in $t2
		li 	$v0, 5			# setup syscall to read integer
		syscall	
		move 	$t2, $v0		# move input to $t2
		
		## Compute the sum of the 3 integers
		add 	$t3, $t0, $t1		# $t3 = $t0 + $t1
		add 	$t3, $t2, $t3		# $t3 += $t2
		
		## Print out the sum and return character.
		la 	$a0, sum		# load address for sum
		li 	$v0, 4			# setup syscall to print string
		syscall
		move 	$a0, $t3		# load $t3 into syscall parameter
		li 	$v0, 1			# setup syscall to print integer
		syscall
		la	$a0, return		# load address for return
		li	$v0, 4			# setup syscall to print string
		syscall
		
		## Compute largest and smallest
		bgt 	$t0, $t1, T0_largest_1 	# if $t0 > $t1, branch to T0_largest_1
		bgt 	$t1, $t2, T1_largest_2	# else if $t1 > $t2, branch to T1_largest_2
		
		j 	T2_largest_2		# else jump to T2_largest_2
		
		
	T0_largest_1:
		bgt 	$t0, $t2, T0_largest_2	# if $t0 > $t2, branch to T0_largest_2
		j 	T2_largest_2		# else jump to T2_largest_2
		
	T0_largest_2:
		move 	$t5, $t0 		# preserve the largest integer in $t5
		blt 	$t1, $t2, T1_smallest	# if $t1 < $t2, branch to T1_smallest
		j 	T2_smallest		# else jump to T2_smallest

		
	T1_largest_2:
		move 	$t5, $t1		# preserve the largest integer in $t5
		blt 	$t0, $t2, T0_smallest	# if $t0 < $t2, branch to T0_smallest
		j 	T2_smallest		# else jump to T2_smallest
	
	T2_largest_2:
		move 	$t5, $t2		# preserve the largest integer in $t5
		blt 	$t0, $t1, T0_smallest	# if $t0 < $t1, branch to T0_smallest
		j 	T1_smallest		# else jump to T1_smallest
		
	T0_smallest:
		move 	$t4, $t0		# preserve the smallest integer in $t4
		j 	print			# jump to print
		
	T1_smallest:
		move 	$t4, $t1	 	# preserve the smallest integer in $t4
		j 	print			# jump to print
		
	T2_smallest:
		move 	$t4, $t2		# preserve the smallest integer in $t4
		j 	print
		
	print:
		## Print the smallest integer and a return character
		la 	$a0, smallest		# load address of smallest
		li 	$v0, 4			# setup syscall to print string
		syscall
		move 	$a0, $t4		# load $t4 into syscall parameter
		li	$v0, 1			# setup syscall to print integer
		syscall
		la	$a0, return		# load address of return
		li	$v0, 4			# setup syscall to print string
		syscall
		
		## Print out the largest input and a return character
		la	$a0, largest		# load address of largest
		li	$v0, 4			# setup syscall to print string
		syscall
		move 	$a0, $t5		# load $t5 into syscall parameter
		li	$v0, 1			# setup syscall to print integer
		syscall
		la	$a0, return		# load address of return
		li	$v0, 4			# setup syscall to print string
		syscall
		
		## Ask user whether to run again.
		la	$a0, run_again		# load address of run_again
		li	$v0, 4			# setup syscall to print string
		syscall
		li	$v0, 5			# setup syscall to read integer
		syscall
		move 	$t0, $v0		# move input into $t0 since we're done with it.
		
		## Loop if user wants to run again, otherwise exit
		li	$t1, 1			# load immediate 1 into $t1 since we're done with it
		beq	$t0, $t1, main		# if $t0 = $t1 branch to main
		j 	Exit			# else jump to exit
	
	Exit:
		li 	$v0, 10			# load syscall exit parameter
		syscall				# return control back to OS.
		
