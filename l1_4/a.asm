include console.inc
COMMENT *
	Lab1 4
*
.data
	a 		db 	?
	countBite 	db  	16
	stepLoop 	dw  	1
	sumTwoN		dw	?
.code

Start:
	mov ax,0;
	mov cx,0;
	ClrScr
	ConsoleTitle 	"¬вод символов, вычисление суммы, вывод кода суммы чисел"
	outstrln 	"¬ведите два символа подр€д"
	inchar 		al
	inchar 		a 
	movzx 		cx, a;
	add 		ax, cx;
	outwordln 	ax;
	mov		sumTwoN, ax;
	jmp 		StartLoop;

StartLoop:
	mov 	cx, 0;
	jmp	cycle;

cycle:
	cmp 			cx,countBite
	jl 			bodyLoopPrint
	jmp			exite
	

zero:
	outchar 		"0"
	add 			cx,stepLoop
	jmp			cycle

one:
	outchar 		"1"
	add 			cx, stepLoop
	jmp			cycle
	

bodyLoopPrint:
	rol 			sumTwoN,1
	jnc 			zero
	jc 			one

exite:
	newline
	exit
	end Start	
	

	
	
