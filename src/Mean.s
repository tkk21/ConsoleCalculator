.text
.globl mean
mean:
	addu	$s5, $0, $ra	#save the return address in a global register
	
	jal addition
	
	mtc1 $v0, $f0 #convert sum of arr into double
	cvt.d.w $f0, $f0
	
	mtc1 $a1, $f2 #convert size of arr into double
	cvt.d.w $f2, $f2
	
	div.d $f0, $f0, $f2 # sum/size
	
	addu	$ra, $0, $s5	#restore the return address
	jr $ra