include console.inc
COMMENT *
	Laba 1 #3
*

.data
	a dw 0
	s dw 0


.code

Start:
	ClrScr							
	ConsoleTitle 		"Вывод КОД Арефмитической прогресии"
	outstrln 		"Введите N"
	inint 			cx
	jmp			sumatoron 

sumatoron:						
	add 			a,cx						
	sub			cx,1
	cmp 			cx,0	
	jg 			sumatoron
	outwordln		a
	mov 			cx,-1
	jmp			cycle 

zero:
	outchar 		"0"
	jmp			cycle

one:
	outchar 		"1"
	jmp			cycle
	

bodyLoopPrint:
	rol 			a,1
	jnc 			zero
	jc 			one

cycle:
	add 			cx,1
	cmp 			cx,16
	jl 			bodyLoopPrint
	jmp			exite

exite:
	newline
	exit
	end Start

	
	
