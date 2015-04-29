.globl variance
.text

variance:
	addu	$s4, $0, $ra	#save the return address in a global register
	
	jal mean
	#set f2 to the mean
	add.d $f2, $f0, $f0
	sub.d $f2, $f2, $f0
	
	mtc1 $0, $f0  #initialize the accumulator
	cvt.d.w $f0, $f0
	add $t1, $zero, $zero #initialize iteration
var_loop:
	lw $t0, ($a0)
	mtc1 $t0, $f4  #turn x into float
	cvt.d.w $f4, $f4
	sub.d $f4, $f4, $f2 # x minus mean
	mul.d $f4, $f4, $f4 # difference squared
	add.d $f0, $f0, $f4 # add the squared difference from the mean to the accumulator
	
	#housekeeping
	
	addi $a0, $a0, 4 #increment ptr by a word
	addi $t1, $t1, 1 #increment iteration by 1
	blt $t1, $a1, var_loop #while iteration < size of arr
	
	mtc1 $a1, $f6  #turn size into float
	cvt.d.w $f6, $f6
	div.d $f0, $f0, $f6 # div by size
	
	
	jal reset_arr
	addu	$ra, $0, $s4	#restore the return address
	jr $ra