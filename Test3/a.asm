include console.inc

COMMENT *

   Заготовка программы

*
.data								; данные 8 строчка

	op1 	db 	?
	op2 	db 	100
		




.code
Start:


	ConsoleTitle	"Команда mov"				;название в комадной строке 
   	outstrln	"Присвоим в op1 op2"			;
   	
	;mov		op1, op2				;так нельзя делать 
	mov		al, op2					;
	mov		op1, al					; 
	outintln	op1					;
	
	
   	exit

end Start