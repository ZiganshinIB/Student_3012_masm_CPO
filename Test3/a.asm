include console.inc

COMMENT *

   ��������� ���������

*
.data								; ������ 8 �������

	op1 	db 	?
	op2 	db 	100
		




.code
Start:


	ConsoleTitle	"������� mov"				;�������� � �������� ������ 
   	outstrln	"�������� � op1 op2"			;
   	
	;mov		op1, op2				;��� ������ ������ 
	mov		al, op2					;
	mov		op1, al					; 
	outintln	op1					;
	
	
   	exit

end Start