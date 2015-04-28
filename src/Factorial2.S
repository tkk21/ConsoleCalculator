.globl main
.data
	Prompt: .asciiz "Type a positive integer for A 12 or under, press ENTER. \n"
	ResultA: .asciiz "\nThe factorial of "
	ResultB: .asciiz " is "
	ResultC: .asciiz ".\n"
.text
 
main:

	li $v0,4        # syscall to print String
    la $a0,Prompt   # load address of Prompt
    syscall         # print Prompt String  
	
    li $v0,5        # syscall to read integer
    syscall         # read first intger
    move $t0,$v0    # move integer in $v0 to $a0
 
	move    $a0, $t0          # move input to argument register $a0
	addi    $sp, $sp, -12     # move stackpointer up 3 words
	sw      $t0, 0($sp)       # store input in top of stack
	sw      $ra, 8($sp)       # store counter at bottom of stack
	jal     factorial         # call factorial
	
	lw      $s0, 4($sp)
 
	li $v0,4        		  # syscall to print String
    la $a0,ResultA   	 	  # load address of ResultA
    syscall         		  # print result String
 
	lw      $a0, 0($sp)       # load original value into $a0
	li      $v0, 1            # system call for print_int
	syscall                   # print original value to screen

	li $v0,4        		  # syscall to print String
    la $a0,ResultB   	 	  # load address of ResultB
    syscall         		  # print result String
	
	move    $a0, $s0          # move final return value from $s0 to $a0 for return
	li      $v0, 1            # system call for print_int
	syscall                   # print final return value to screen
	 
	li $v0,4        		  # syscall to print String
    la $a0,ResultC   	 	  # load address of ResultC
    syscall         		  # print result String 
	 
	addi    $sp, $sp, 12      # move stack pointer back down where we started
	 
	# return 0;
	li      $v0, 10           # system call for exit
	syscall                   # exit!
	
 
 
.text
factorial:
							# base  case - still in parent's stack segment
  lw      $t0, 0($sp)       # load input from top of stack into register $t0
  beq     $t0, 0, returnOne # if $t0 is equal to 0, branch to returnOne
  addi    $t0, $t0, -1      # subtract 1 from $t0 if not equal to 0
 
  # recursive case - move to this call's stack segment
  addi    $sp, $sp, -12     # move stack pointer up 3 words
  sw      $t0, 0($sp)       # store current working number into the top of the stack segment
  sw      $ra, 8($sp)       # store counter at bottom of stack segment
 
  jal     factorial         # recursive call
  lw      $ra, 8($sp)       # load this call's $ra again(we just got back from a jump)
  lw      $t1, 4($sp)       # load child's return value into $t1
 
  lw      $t2, 12($sp)      # load parent's start value into $t2
  mul     $t3, $t1, $t2     # multiply child's return value by parent's working value, store in $t3.
  sw      $t3, 16($sp)      # take result(in $t3), store in parent's return value.
  addi    $sp, $sp, 12      # move stackpointer back down for the parent call
 
  jr      $ra               # jump to parent call
 

returnOne:
  li      $t0, 1            # load 1 into register $t0
  sw      $t0, 4($sp)       # store 1 into the parent's return value register
  jr      $ra               # jump to parent call