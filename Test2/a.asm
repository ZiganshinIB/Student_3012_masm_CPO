include console.inc

COMMENT *

   ��������� ���������

*
.data

W1 dq "����"
W2 dw 5
W3 db 100
Q dq 01020304h

.code
Start:

   ConsoleTitle " ������������� ������" ;�������� � �������� ������ 
   outstrln	"����� ���������� W1"
   lea 		eax, W1			; �������� ������
   outwordln 	eax 			;
   outwordln    W1 
   
   outstrln	"����� ���������� W2"
   lea 		eax, W2			; �������� ������
   outwordln 	eax 			; 
   outwordln    W2

   outwordln 	W1+4			;
   outwordln 	W2-4  			; ���������� � �������� var
   
   outstrln	"��� ���������� W1"
   OutwordLn 	type 	W1		; �������� ��� ����������

   outstrln	"��� ���������� W2"
   OutwordLn 	type 	W2		; �������� ��� ����������

   outwordln byte ptr W2
   outwordln byte ptr W2+1
   exit

end Start